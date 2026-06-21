import 'dart:math';
import 'package:flutter/material.dart';

import '../data/app_text.dart';
import '../data/drink_data.dart';
import '../models/drink.dart';
import '../models/player_progress.dart';
import '../services/audio_service.dart';
import '../services/language_service.dart';
import '../services/progress_storage_service.dart';
import '../services/purchase_service.dart';
import '../widgets/potio_card.dart';

class _PictureMatchQuestion {
  final Drink correctDrink;
  final List<Drink> options;

  _PictureMatchQuestion(this.correctDrink, this.options);
}

class PictureMatchScreen extends StatefulWidget {
  const PictureMatchScreen({super.key});

  @override
  State<PictureMatchScreen> createState() => _PictureMatchScreenState();
}

class _PictureMatchScreenState extends State<PictureMatchScreen> {
  final ProgressStorageService _storage = ProgressStorageService();
  PlayerProgress _progress = PlayerProgress.initial();

  bool _loading = true;
  bool _isFinished = false;
  
  List<_PictureMatchQuestion> _questions = [];
  int _currentIndex = 0;
  int _score = 0;
  int _lives = 3; // <--- ADDED LIVES
  
  bool _isAnswered = false;
  Drink? _selectedAnswer;

  @override
  void initState() {
    super.initState();
    _initGame();
  }

  Future<void> _initGame() async {
    _progress = await _storage.loadProgress();

    final isPremium = PotioPurchaseService.instance.isPremium.value || _progress.hasPremium;
    final availableDrinks = isPremium ? allDrinks : basicDrinks;

    final random = Random();
    
    final shuffledDrinks = List<Drink>.from(availableDrinks)..shuffle(random);
    final selectedDrinks = shuffledDrinks.take(10).toList();

    _questions = selectedDrinks.map((correctDrink) {
      final wrongDrinks = availableDrinks
          .where((d) => d.id != correctDrink.id)
          .toList()..shuffle(random);

      final options = [correctDrink, ...wrongDrinks.take(3)]..shuffle(random);
      return _PictureMatchQuestion(correctDrink, options);
    }).toList();

    if (mounted) {
      setState(() {
        _loading = false;
      });
    }
  }

  void _selectAnswer(Drink option) async {
    if (_isAnswered) return;

    setState(() {
      _selectedAnswer = option;
      _isAnswered = true;
    });

    final isCorrect = option.id == _questions[_currentIndex].correctDrink.id;
    if (isCorrect) {
      _score++;
      PotioAudioService.instance.playCorrect();
    } else {
      _lives--; // <--- DECREASE LIVES
      PotioAudioService.instance.playWrong();
    }

    await Future.delayed(const Duration(milliseconds: 1500));

    if (!mounted) return;

    if (_lives <= 0) {
      _finishGame();
    } else if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _isAnswered = false;
        _selectedAnswer = null;
      });
    } else {
      _finishGame();
    }
  }

  Future<void> _finishGame() async {
    final xpEarned = _score * 10;
    final updatedProgress = _progress.addXp(xpEarned);
    await _storage.saveProgress(updatedProgress);

    setState(() {
      _isFinished = true;
    });
  }

  Color _getOptionColor(Drink option) {
    if (!_isAnswered) return Colors.white;
    final isCorrectOption = option.id == _questions[_currentIndex].correctDrink.id;
    if (isCorrectOption) return potioEmerald.withValues(alpha: 0.9);
    if (option.id == _selectedAnswer?.id) return Colors.red.shade400;
    return Colors.white.withValues(alpha: 0.5);
  }

  Color _getTextColor(Drink option) {
    if (!_isAnswered) return potioInk;
    final isCorrectOption = option.id == _questions[_currentIndex].correctDrink.id;
    if (isCorrectOption || option.id == _selectedAnswer?.id) return Colors.white;
    return potioMutedInk;
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const PotioScaffold(
        child: Center(
          child: CircularProgressIndicator(color: potioCopperLight),
        ),
      );
    }

    final languageCode = LanguageService.instance.languageCode.value;

    if (_isFinished) {
      return _buildResultsScreen(languageCode);
    }

    final currentQ = _questions[_currentIndex];

    return PotioScaffold(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // HEADER WITH LIVES
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: potioInk),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    '${_currentIndex + 1} / ${_questions.length}',
                    style: const TextStyle(
                      color: potioMutedInk,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Row(
                    children: List.generate(3, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Icon(
                          index < _lives ? Icons.favorite : Icons.favorite_border,
                          color: index < _lives ? Colors.red.shade400 : potioMutedInk.withValues(alpha: 0.3),
                          size: 24,
                        ),
                      );
                    }),
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              LinearProgressIndicator(
                value: (_currentIndex) / _questions.length,
                backgroundColor: Colors.white.withValues(alpha: 0.3),
                color: potioEmerald,
                minHeight: 8,
                borderRadius: BorderRadius.circular(999),
              ),

              const SizedBox(height: 24),
              
              // QUESTION CARD
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: potioPaper,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    )
                  ]
                ),
                child: Column(
                  children: [
                    Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: potioCopperLight.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          'assets/drinks/${currentQ.correctDrink.id}.png',
                          fit: BoxFit.contain, // Recommended for transparent PNGs
                          errorBuilder: (context, error, stackTrace) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.add_photo_alternate_outlined, size: 48, color: potioCopper),
                                const SizedBox(height: 8),
                                Text(
                                  AppText.get(languageCode, 'image_placeholder'),
                                  style: const TextStyle(
                                    color: potioCopper,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      currentQ.correctDrink.shortDescription,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: potioInk,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // OPTIONS
              for (final option in currentQ.options)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    child: Material(
                      color: _getOptionColor(option),
                      borderRadius: BorderRadius.circular(20),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () => _selectAnswer(option),
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: _isAnswered ? Colors.transparent : potioMutedInk.withValues(alpha: 0.1),
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(option.imageEmoji, style: const TextStyle(fontSize: 24)),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  option.name,
                                  style: TextStyle(
                                    color: _getTextColor(option),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultsScreen(String languageCode) {
    final isDead = _lives <= 0;

    return PotioScaffold(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isDead ? Icons.heart_broken : Icons.emoji_events, 
                color: isDead ? Colors.red.shade400 : potioCopper, 
                size: 72
              ),
              const SizedBox(height: 20),
              Text(
                isDead ? AppText.get(languageCode, 'out_of_lives') : AppText.get(languageCode, 'quiz_complete'),
                style: const TextStyle(
                  color: potioInk,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '${AppText.get(languageCode, 'score')}: $_score / ${_questions.length}',
                style: const TextStyle(
                  color: potioMutedInk,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: potioEmerald.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '+${_score * 10} ${AppText.get(languageCode, 'xp_earned')}',
                  style: const TextStyle(
                    color: potioEmerald,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: potioEmerald,
                    foregroundColor: potioPaper,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    AppText.get(languageCode, 'back_to_menu'),
                    style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}