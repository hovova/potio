class AppText {
  static String get(String languageCode, String key) {
    final safeLanguage = switch (languageCode) {
      'uk' => 'uk',
      'ru' => 'ru',
      _ => 'en',
    };

    return _text[key]?[safeLanguage] ?? _text[key]?['en'] ?? key;
  }

  static const Map<String, Map<String, String>> _text = {
    // General
    'app_name': {
      'en': 'Potio',
      'uk': 'Potio',
      'ru': 'Potio',
    },
    'done': {
      'en': 'Done',
      'uk': 'Готово',
      'ru': 'Готово',
    },
    'back': {
      'en': 'Back',
      'uk': 'Назад',
      'ru': 'Назад',
    },
    'coming_soon': {
      'en': 'Coming soon',
      'uk': 'Скоро буде',
      'ru': 'Скоро будет',
    },

    // Bottom navigation
    'nav_home': {
      'en': 'Home',
      'uk': 'Головна',
      'ru': 'Главная',
    },
    'nav_play': {
      'en': 'Play',
      'uk': 'Грати',
      'ru': 'Играть',
    },
    'nav_drinks': {
      'en': 'Drinks',
      'uk': 'Напої',
      'ru': 'Напитки',
    },
    'nav_academy': {
      'en': 'Academy',
      'uk': 'Академія',
      'ru': 'Академия',
    },
    'nav_profile': {
      'en': 'Profile',
      'uk': 'Профіль',
      'ru': 'Профиль',
    },

    // Home
    'home_eyebrow': {
      'en': 'Mixology academy',
      'uk': 'Академія міксології',
      'ru': 'Академия миксологии',
    },
    'home_subtitle': {
      'en':
          'Learn drinks through recipes, ingredients, technique, glassware, and bartender-style quizzes.',
      'uk':
          'Вивчай напої через рецепти, інгредієнти, техніку, посуд і барменські тести.',
      'ru':
          'Изучай напитки через рецепты, ингредиенты, технику, посуду и барменские тесты.',
    },
    'created_by': {
      'en': 'Created by Mriya Interactive',
      'uk': 'Створено Mriya Interactive',
      'ru': 'Создано Mriya Interactive',
    },
    'basic_bar_academy': {
      'en': 'Basic Bar Academy',
      'uk': 'Базова барна академія',
      'ru': 'Базовая барная академия',
    },
    'basic_bar_subtitle': {
      'en': '20 levels built around 50 popular drinks.',
      'uk': '20 рівнів на основі 50 популярних напоїв.',
      'ru': '20 уровней на основе 50 популярных напитков.',
    },
    'recipe_cards': {
      'en': 'Full Recipe Cards',
      'uk': 'Повні картки рецептів',
      'ru': 'Полные карточки рецептов',
    },
    'recipe_cards_subtitle': {
      'en':
          'Glass, ice, method, garnish, taste profile, allergens, ingredients, and steps.',
      'uk':
          'Посуд, лід, метод, прикраса, смак, алергени, інгредієнти та кроки.',
      'ru':
          'Посуда, лёд, метод, украшение, вкус, аллергены, ингредиенты и шаги.',
    },
    'daily_mixology': {
      'en': 'Daily Mixology',
      'uk': 'Щоденна міксологія',
      'ru': 'Ежедневная миксология',
    },
    'daily_mixology_subtitle': {
      'en': 'One XP reward per day, replayable for practice.',
      'uk': 'Одна XP-нагорода на день, можна перегравати для практики.',
      'ru': 'Одна XP-награда в день, можно переигрывать для практики.',
    },
    'practice_bar': {
      'en': 'Practice Bar',
      'uk': 'Тренувальний бар',
      'ru': 'Тренировочный бар',
    },
    'practice_bar_subtitle': {
      'en':
          'Recipe Guess, Picture Match, Build the Drink, Mixology Trivia, and more.',
      'uk':
          'Вгадай рецепт, матч зображень, збери напій, вікторина та інше.',
      'ru':
          'Угадай рецепт, матч картинок, собери напиток, викторина и другое.',
    },

    // Language
    'choose_language': {
      'en': 'Choose Language',
      'uk': 'Оберіть мову',
      'ru': 'Выберите язык',
    },
    'english': {
      'en': 'English',
      'uk': 'English',
      'ru': 'English',
    },
    'ukrainian': {
      'en': 'Українська',
      'uk': 'Українська',
      'ru': 'Українська',
    },
    'russian': {
      'en': 'Русский',
      'uk': 'Русский',
      'ru': 'Русский',
    },
    'current_language': {
      'en': 'Current language',
      'uk': 'Поточна мова',
      'ru': 'Текущий язык',
    },

    // Profile/settings
    'bartender_profile': {
      'en': 'Bartender Profile',
      'uk': 'Профіль бармена',
      'ru': 'Профиль бармена',
    },
    'beginner_bartender': {
      'en': 'Beginner Bartender',
      'uk': 'Бармен-початківець',
      'ru': 'Начинающий бармен',
    },
    'premium_bartender': {
      'en': 'Premium Bartender',
      'uk': 'Преміум-бармен',
      'ru': 'Премиум-бармен',
    },
    'edit_name': {
      'en': 'Edit name',
      'uk': 'Змінити імʼя',
      'ru': 'Изменить имя',
    },
    'settings': {
      'en': 'Settings',
      'uk': 'Налаштування',
      'ru': 'Настройки',
    },
    'premium_status': {
      'en': 'Premium Status',
      'uk': 'Статус Premium',
      'ru': 'Статус Premium',
    },
    'recipe_units': {
      'en': 'Recipe Units',
      'uk': 'Одиниці рецепта',
      'ru': 'Единицы рецепта',
    },
    'sound_effects': {
      'en': 'Sound Effects',
      'uk': 'Звукові ефекти',
      'ru': 'Звуковые эффекты',
    },
    'music': {
      'en': 'Music',
      'uk': 'Музика',
      'ru': 'Музыка',
    },
    'language': {
      'en': 'Language',
      'uk': 'Мова',
      'ru': 'Язык',
    },
    'active': {
      'en': 'Active',
      'uk': 'Активно',
      'ru': 'Активно',
    },
    'not_active': {
      'en': 'Not active',
      'uk': 'Неактивно',
      'ru': 'Неактивно',
    },
    'on': {
      'en': 'On',
      'uk': 'Увімкнено',
      'ru': 'Включено',
    },
    'off': {
      'en': 'Off',
      'uk': 'Вимкнено',
      'ru': 'Выключено',
    },

    // Drinks
    'encyclopedia': {
      'en': 'Encyclopedia',
      'uk': 'Енциклопедія',
      'ru': 'Энциклопедия',
    },
    'encyclopedia_subtitle': {
      'en': 'Recipe cards, filters, favourites, and drink details.',
      'uk': 'Картки рецептів, фільтри, обране та деталі напоїв.',
      'ru': 'Карточки рецептов, фильтры, избранное и детали напитков.',
    },
    'drink_filters': {
      'en': 'Drink Filters',
      'uk': 'Фільтри напоїв',
      'ru': 'Фильтры напитков',
    },
    'alcohol_type': {
      'en': 'Alcohol Type',
      'uk': 'Тип алкоголю',
      'ru': 'Тип алкоголя',
    },
    'difficulty': {
      'en': 'Difficulty',
      'uk': 'Складність',
      'ru': 'Сложность',
    },
    'country_origin': {
      'en': 'Country of Origin',
      'uk': 'Країна походження',
      'ru': 'Страна происхождения',
    },
    'favourites_only': {
      'en': 'Favourites Only',
      'uk': 'Лише обране',
      'ru': 'Только избранное',
    },
    'reset_filters': {
      'en': 'Reset Filters',
      'uk': 'Скинути фільтри',
      'ru': 'Сбросить фильтры',
    },
    'results': {
      'en': 'results',
      'uk': 'результатів',
      'ru': 'результатов',
    },
    'saved': {
      'en': 'saved',
      'uk': 'збережено',
      'ru': 'сохранено',
    },
    'ingredients': {
      'en': 'Ingredients',
      'uk': 'Інгредієнти',
      'ru': 'Ингредиенты',
    },
    'recipe_steps': {
      'en': 'Recipe Steps',
      'uk': 'Кроки рецепта',
      'ru': 'Шаги рецепта',
    },
    'allergy_notes': {
      'en': 'Allergy notes',
      'uk': 'Нотатки щодо алергенів',
      'ru': 'Заметки об аллергенах',
    },
    'free_campaign': {
    'en': 'Free campaign',
    'uk': 'Безкоштовна кампанія',
    'ru': 'Бесплатная кампания',
    },
    'free_daily': {
      'en': 'Free daily',
      'uk': 'Безкоштовне щоденне',
      'ru': 'Бесплатное ежедневное',
    },
    'all_modes': {
      'en': 'All modes',
      'uk': 'Усі режими',
      'ru': 'Все режимы',
    },
  };
}