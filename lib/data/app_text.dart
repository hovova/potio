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
    'premium': {
      'en': 'Premium',
      'uk': 'Преміум',
      'ru': 'Премиум',
    },
    'sound': {
      'en': 'Sound',
      'uk': 'Звук',
      'ru': 'Звук',
    },
    'free': {
      'en': 'Free',
      'uk': 'Безкоштовно',
      'ru': 'Бесплатно',
    },
    'included': {
      'en': 'Included',
      'uk': 'Включено',
      'ru': 'Включено',
    },
    'full_access': {
      'en': 'Full access',
      'uk': 'Повний доступ',
      'ru': 'Полный доступ',
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

    // Campaign / Academy
    'academy_paths': {
      'en': 'Academy Paths',
      'uk': 'Шляхи академії',
      'ru': 'Пути академии',
    },
    'campaign': {
      'en': 'Campaign',
      'uk': 'Кампанія',
      'ru': 'Кампания',
    },
    'campaign_subtitle': {
      'en': 'Potio uses bartender academy paths instead of Stella’s sky map.',
      'uk':
          'Potio використовує барменські академічні шляхи замість зоряної мапи Stella.',
      'ru':
          'Potio использует академические пути бармена вместо звёздной карты Stella.',
    },
    'free_label': {
      'en': 'Free',
      'uk': 'Безкоштовно',
      'ru': 'Бесплатно',
    },
    'premium_label': {
      'en': 'Premium',
      'uk': 'Преміум',
      'ru': 'Премиум',
    },
    'exam_style': {
      'en': 'Exam Style',
      'uk': 'Стиль іспиту',
      'ru': 'Стиль экзамена',
    },
    'master_mixologist_academy': {
      'en': 'Master Mixologist Academy',
      'uk': 'Академія Master Mixologist',
      'ru': 'Академия Master Mixologist',
    },
    'master_mixologist_academy_subtitle': {
      'en':
          '100+ total drinks • advanced recipes • bartender guide • offline • no ads.',
      'uk':
          '100+ напоїв • складні рецепти • гід бармена • офлайн • без реклами.',
      'ru':
          '100+ напитков • продвинутые рецепты • гид бармена • офлайн • без рекламы.',
    },
    'bartender_trials': {
      'en': 'Bartender Trials',
      'uk': 'Барменські випробування',
      'ru': 'Испытания бармена',
    },
    'bartender_trials_subtitle': {
      'en':
          'Future challenge levels covering glassware, methods, allergens, and service knowledge.',
      'uk':
          'Майбутні рівні-випробування про посуд, методи, алергени та сервіс.',
      'ru': 'Будущие испытания о посуде, методах, аллергенах и сервисе.',
    },

    // Drinks / Encyclopedia
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

    // Profile / Settings
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
    'edit_player_name': {
      'en': 'Edit Player Name',
      'uk': 'Змінити імʼя гравця',
      'ru': 'Изменить имя игрока',
    },
    'player_name': {
      'en': 'Player name',
      'uk': 'Імʼя гравця',
      'ru': 'Имя игрока',
    },
    'save_name': {
      'en': 'Save Name',
      'uk': 'Зберегти імʼя',
      'ru': 'Сохранить имя',
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
    'levels_done': {
      'en': 'Levels done',
      'uk': 'Рівнів пройдено',
      'ru': 'Уровней пройдено',
    },
    'achievements': {
      'en': 'Achievements',
      'uk': 'Досягнення',
      'ru': 'Достижения',
    },
    'favourites': {
      'en': 'Favourites',
      'uk': 'Обране',
      'ru': 'Избранное',
    },
    'xp': {
      'en': 'XP',
      'uk': 'XP',
      'ru': 'XP',
    },
    'progress': {
      'en': 'Progress',
      'uk': 'Прогрес',
      'ru': 'Прогресс',
    },
    'profile': {
      'en': 'Profile',
      'uk': 'Профіль',
      'ru': 'Профиль',
    },
    'ranking': {
      'en': 'Ranking',
      'uk': 'Рейтинг',
      'ru': 'Рейтинг',
    },
    'app': {
      'en': 'App',
      'uk': 'Додаток',
      'ru': 'Приложение',
    },
    'about': {
      'en': 'About',
      'uk': 'Про додаток',
      'ru': 'О приложении',
    },
    'achievement_card_subtitle': {
      'en': 'View achievement progress, rewards, avatars, and frames.',
      'uk': 'Переглядай прогрес досягнень, нагороди, аватари та рамки.',
      'ru': 'Просматривай прогресс достижений, награды, аватары и рамки.',
    },
    'avatar_selection': {
      'en': 'Avatar Selection',
      'uk': 'Вибір аватара',
      'ru': 'Выбор аватара',
    },
    'avatar_selection_subtitle': {
      'en': 'Choose your bartender avatar and future profile frames.',
      'uk': 'Обери аватар бармена та майбутні рамки профілю.',
      'ru': 'Выбери аватар бармена и будущие рамки профиля.',
    },
    'leaderboard': {
      'en': 'Leaderboard',
      'uk': 'Таблиця лідерів',
      'ru': 'Таблица лидеров',
    },
    'leaderboard_card_subtitle': {
      'en': 'Compare progress by XP, levels, and achievements.',
      'uk': 'Порівнюй прогрес за XP, рівнями та досягненнями.',
      'ru': 'Сравнивай прогресс по XP, уровням и достижениям.',
    },
    'settings_subtitle': {
      'en': 'Units, premium status, language, sound, music, and app preferences.',
      'uk':
          'Одиниці, Premium-статус, мова, звук, музика та налаштування додатка.',
      'ru':
          'Единицы, Premium-статус, язык, звук, музыка и настройки приложения.',
    },
    'credits': {
      'en': 'Credits',
      'uk': 'Подяки',
      'ru': 'Благодарности',
    },
    'credits_subtitle': {
      'en': 'View Potio asset, recipe, and app credits.',
      'uk': 'Переглянь подяки за ресурси, рецепти та додаток Potio.',
      'ru': 'Посмотри благодарности за ресурсы, рецепты и приложение Potio.',
    },

    // Premium
    'premium_eyebrow': {
      'en': 'Potio Premium',
      'uk': 'Potio Premium',
      'ru': 'Potio Premium',
    },
    'premium_upgrade_title': {
      'en': 'Upgrade',
      'uk': 'Оновити до Premium',
      'ru': 'Обновить до Premium',
    },
    'premium_upgrade_subtitle': {
      'en':
          'Compare the free learning experience with the full Master Mixologist version.',
      'uk':
          'Порівняй безкоштовне навчання з повною версією Master Mixologist.',
      'ru':
          'Сравни бесплатное обучение с полной версией Master Mixologist.',
    },
    'unlock_potio_premium': {
      'en': 'Unlock Potio Premium',
      'uk': 'Відкрити Potio Premium',
      'ru': 'Открыть Potio Premium',
    },
    'developer_unlock_premium': {
      'en': 'Developer: Unlock Premium',
      'uk': 'Розробник: відкрити Premium',
      'ru': 'Разработчик: открыть Premium',
    },
    'debug_only_button': {
      'en': 'Debug-only button. This will not appear in release builds.',
      'uk':
          'Кнопка лише для тестування. Вона не зʼявиться у релізній версії.',
      'ru':
          'Кнопка только для тестирования. Она не появится в релизной версии.',
    },
    'premium_unlocks': {
      'en': 'Premium unlocks',
      'uk': 'Premium відкриває',
      'ru': 'Premium открывает',
    },
    'full_bartender_guide': {
      'en': 'Full Bartender Guide',
      'uk': 'Повний гід бармена',
      'ru': 'Полный гид бармена',
    },
    'full_bartender_guide_subtitle': {
      'en': 'Learn techniques, glassware, allergens, service and more.',
      'uk': 'Вивчай техніки, посуд, алергени, сервіс та інше.',
      'ru': 'Изучай техники, посуду, аллергены, сервис и другое.',
    },
    'feature_50_drinks': {
      'en': '50 popular drinks',
      'uk': '50 популярних напоїв',
      'ru': '50 популярных напитков',
    },
    'feature_100_drinks': {
      'en': '100+ total drinks',
      'uk': '100+ напоїв загалом',
      'ru': '100+ напитков всего',
    },
    'feature_basic_academy': {
      'en': '20-level Basic Academy',
      'uk': '20 рівнів Basic Academy',
      'ru': '20 уровней Basic Academy',
    },
    'feature_master_academy': {
      'en': 'Master Mixologist Academy',
      'uk': 'Академія Master Mixologist',
      'ru': 'Академия Master Mixologist',
    },
    'feature_daily_mixology': {
      'en': 'Daily Mixology',
      'uk': 'Щоденна міксологія',
      'ru': 'Ежедневная миксология',
    },
    'feature_all_quiz_modes': {
      'en': 'All quiz modes',
      'uk': 'Усі режими тестів',
      'ru': 'Все режимы тестов',
    },
    'feature_filters_favourites': {
      'en': 'Filters & favourites',
      'uk': 'Фільтри та обране',
      'ru': 'Фильтры и избранное',
    },
    'feature_ads_included': {
      'en': 'Ads included',
      'uk': 'З рекламою',
      'ru': 'С рекламой',
    },
    'feature_offline_access': {
      'en': 'Offline access',
      'uk': 'Офлайн-доступ',
      'ru': 'Офлайн-доступ',
    },
    'feature_no_ads': {
      'en': 'No ads',
      'uk': 'Без реклами',
      'ru': 'Без рекламы',
    },
    'feature_future_packs': {
      'en': 'Future premium packs',
      'uk': 'Майбутні Premium-набори',
      'ru': 'Будущие Premium-наборы',
    },

    // Avatar selection
    'profile_style': {
      'en': 'Profile Style',
      'uk': 'Стиль профілю',
      'ru': 'Стиль профиля',
    },
    'avatars_and_frames': {
      'en': 'Avatars and frames',
      'uk': 'Аватари та рамки',
      'ru': 'Аватары и рамки',
    },
    'no_frame_selected': {
      'en': 'No frame selected.',
      'uk': 'Рамку не вибрано.',
      'ru': 'Рамка не выбрана.',
    },
    'avatars': {
      'en': 'Avatars',
      'uk': 'Аватари',
      'ru': 'Аватары',
    },
    'frames': {
      'en': 'Frames',
      'uk': 'Рамки',
      'ru': 'Рамки',
    },
    'classic_bartender': {
      'en': 'Classic Bartender',
      'uk': 'Класичний бармен',
      'ru': 'Классический бармен',
    },
    'default_starter_avatar': {
      'en': 'Default starter avatar',
      'uk': 'Стандартний стартовий аватар',
      'ru': 'Стандартный стартовый аватар',
    },
    'welcome_bartender': {
      'en': 'Welcome Bartender',
      'uk': 'Вітальний бармен',
      'ru': 'Приветственный бармен',
    },
    'unlocked_first_open': {
      'en': 'Unlocked when you first open Potio',
      'uk': 'Відкривається після першого запуску Potio',
      'ru': 'Открывается при первом запуске Potio',
    },
    'recipe_rookie': {
      'en': 'Recipe Rookie',
      'uk': 'Новачок рецептів',
      'ru': 'Новичок рецептов',
    },
    'unlocked_5_recipe_questions': {
      'en': 'Unlocked by completing 5 recipe questions',
      'uk': 'Відкривається після 5 питань про рецепти',
      'ru': 'Открывается после 5 вопросов о рецептах',
    },
    'daily_regular': {
      'en': 'Daily Regular',
      'uk': 'Щоденний гість',
      'ru': 'Ежедневный гость',
    },
    'unlocked_3_daily': {
      'en': 'Unlocked by completing 3 Daily Mixology challenges',
      'uk': 'Відкривається після 3 щоденних завдань з міксології',
      'ru': 'Открывается после 3 ежедневных заданий по миксологии',
    },
    'academy_student': {
      'en': 'Academy Student',
      'uk': 'Студент академії',
      'ru': 'Студент академии',
    },
    'unlocked_5_academy_levels': {
      'en': 'Unlocked by completing 5 Basic Academy levels',
      'uk': 'Відкривається після 5 рівнів Basic Academy',
      'ru': 'Открывается после 5 уровней Basic Academy',
    },
    'gold_pour_avatar': {
      'en': 'Gold Pour',
      'uk': 'Золотий налив',
      'ru': 'Золотой налив',
    },
    'unlocked_100_any_level': {
      'en': 'Unlocked by scoring 100% in any level',
      'uk': 'Відкривається за 100% на будь-якому рівні',
      'ru': 'Открывается за 100% на любом уровне',
    },
    'master_mixologist': {
      'en': 'Master Mixologist',
      'uk': 'Майстер міксолог',
      'ru': 'Мастер миксолог',
    },
    'premium_avatar': {
      'en': 'Premium avatar',
      'uk': 'Premium-аватар',
      'ru': 'Premium-аватар',
    },
    'golden_shaker': {
      'en': 'Golden Shaker',
      'uk': 'Золотий шейкер',
      'ru': 'Золотой шейкер',
    },
    'no_frame': {
      'en': 'No Frame',
      'uk': 'Без рамки',
      'ru': 'Без рамки',
    },
    'clean_default_profile_style': {
      'en': 'Clean default profile style',
      'uk': 'Чистий стандартний стиль профілю',
      'ru': 'Чистый стандартный стиль профиля',
    },
    'copper_frame': {
      'en': 'Copper Frame',
      'uk': 'Мідна рамка',
      'ru': 'Медная рамка',
    },
    'unlocked_first_quiz': {
      'en': 'Unlocked by completing your first quiz',
      'uk': 'Відкривається після першого тесту',
      'ru': 'Открывается после первого теста',
    },
    'mint_frame': {
      'en': 'Mint Frame',
      'uk': 'Мʼятна рамка',
      'ru': 'Мятная рамка',
    },
    'unlocked_5_favourites': {
      'en': 'Unlocked by saving 5 favourite drinks',
      'uk': 'Відкривається після 5 обраних напоїв',
      'ru': 'Открывается после 5 избранных напитков',
    },
    'gold_award_frame': {
      'en': 'Gold Award Frame',
      'uk': 'Золота рамка',
      'ru': 'Золотая рамка',
    },
    'diamond_bar_frame': {
      'en': 'Diamond Bar Frame',
      'uk': 'Діамантова рамка',
      'ru': 'Бриллиантовая рамка',
    },
    'unlocked_all_gold': {
      'en': 'Unlocked by earning gold on all Basic Academy levels',
      'uk': 'Відкривається за золото на всіх рівнях Basic Academy',
      'ru': 'Открывается за золото на всех уровнях Basic Academy',
    },
    'emerald_premium_frame': {
      'en': 'Emerald Premium Frame',
      'uk': 'Смарагдова Premium-рамка',
      'ru': 'Изумрудная Premium-рамка',
    },
    'platinum_premium_frame': {
      'en': 'Platinum Premium Frame',
      'uk': 'Платинова Premium-рамка',
      'ru': 'Платиновая Premium-рамка',
    },
    'premium_frame': {
      'en': 'Premium frame',
      'uk': 'Premium-рамка',
      'ru': 'Premium-рамка',
    },
    'requires_potio_premium': {
      'en': 'Requires Potio Premium',
      'uk': 'Потрібен Potio Premium',
      'ru': 'Требуется Potio Premium',
    },
    'continue_playing': {
      'en': 'Continue Playing',
      'uk': 'Продовжити гру',
      'ru': 'Продолжить игру',
    },
    'go_to_premium': {
      'en': 'Go to Premium',
      'uk': 'Перейти до Premium',
      'ru': 'Перейти к Premium',
    },

    // Achievements
    'mixology_rewards': {
      'en': 'Mixology rewards',
      'uk': 'Нагороди міксології',
      'ru': 'Награды миксологии',
    },
    'unlocked': {
      'en': 'Unlocked',
      'uk': 'Відкрито',
      'ru': 'Открыто',
    },
    'gold_awards': {
      'en': 'Gold awards',
      'uk': 'Золоті нагороди',
      'ru': 'Золотые награды',
    },
    'achievement_first_login_title': {
      'en': 'Welcome to Potio',
      'uk': 'Ласкаво просимо до Potio',
      'ru': 'Добро пожаловать в Potio',
    },
    'achievement_first_login_subtitle': {
      'en': 'Open Potio for the first time.',
      'uk': 'Відкрий Potio вперше.',
      'ru': 'Открой Potio впервые.',
    },
    'achievement_first_login_reward': {
      'en': 'Unlocks Welcome Bartender avatar',
      'uk': 'Відкриває аватар Welcome Bartender',
      'ru': 'Открывает аватар Welcome Bartender',
    },
    'achievement_first_sip_title': {
      'en': 'First Sip',
      'uk': 'Перший ковток',
      'ru': 'Первый глоток',
    },
    'achievement_first_sip_subtitle': {
      'en': 'Complete your first quiz.',
      'uk': 'Пройди свій перший тест.',
      'ru': 'Пройди свой первый тест.',
    },
    'achievement_first_sip_reward': {
      'en': 'Unlocks Copper Frame',
      'uk': 'Відкриває мідну рамку',
      'ru': 'Открывает медную рамку',
    },
    'achievement_recipe_rookie_title': {
      'en': 'Recipe Rookie',
      'uk': 'Новачок рецептів',
      'ru': 'Новичок рецептов',
    },
    'achievement_recipe_rookie_subtitle': {
      'en': 'Complete 5 recipe questions.',
      'uk': 'Виконай 5 питань про рецепти.',
      'ru': 'Выполни 5 вопросов о рецептах.',
    },
    'achievement_recipe_rookie_reward': {
      'en': 'Unlocks Recipe Rookie avatar',
      'uk': 'Відкриває аватар Recipe Rookie',
      'ru': 'Открывает аватар Recipe Rookie',
    },
    'achievement_daily_regular_title': {
      'en': 'Daily Regular',
      'uk': 'Щоденний гість',
      'ru': 'Ежедневный гость',
    },
    'achievement_daily_regular_subtitle': {
      'en': 'Complete 3 Daily Mixology challenges.',
      'uk': 'Виконай 3 щоденні завдання з міксології.',
      'ru': 'Выполни 3 ежедневных задания по миксологии.',
    },
    'achievement_daily_regular_reward': {
      'en': 'Unlocks Daily Regular avatar',
      'uk': 'Відкриває аватар Daily Regular',
      'ru': 'Открывает аватар Daily Regular',
    },
    'achievement_academy_starter_title': {
      'en': 'Academy Starter',
      'uk': 'Початок академії',
      'ru': 'Старт академии',
    },
    'achievement_academy_starter_subtitle': {
      'en': 'Complete 5 Basic Academy levels.',
      'uk': 'Пройди 5 рівнів Basic Academy.',
      'ru': 'Пройди 5 уровней Basic Academy.',
    },
    'achievement_academy_starter_reward': {
      'en': 'Unlocks Academy Student avatar',
      'uk': 'Відкриває аватар Academy Student',
      'ru': 'Открывает аватар Academy Student',
    },
    'achievement_collector_title': {
      'en': 'Collector',
      'uk': 'Колекціонер',
      'ru': 'Коллекционер',
    },
    'achievement_collector_subtitle': {
      'en': 'Save 5 drinks to favourites.',
      'uk': 'Додай 5 напоїв в обране.',
      'ru': 'Добавь 5 напитков в избранное.',
    },
    'achievement_collector_reward': {
      'en': 'Unlocks Mint Frame',
      'uk': 'Відкриває мʼятну рамку',
      'ru': 'Открывает мятную рамку',
    },
    'achievement_perfect_pour_title': {
      'en': 'Perfect Pour',
      'uk': 'Ідеальний налив',
      'ru': 'Идеальный налив',
    },
    'achievement_perfect_pour_subtitle': {
      'en': 'Score 100% in any quiz mode.',
      'uk': 'Набери 100% у будь-якому режимі тесту.',
      'ru': 'Набери 100% в любом режиме теста.',
    },
    'achievement_perfect_pour_reward': {
      'en': 'Unlocks Perfect Pour avatar',
      'uk': 'Відкриває аватар Perfect Pour',
      'ru': 'Открывает аватар Perfect Pour',
    },
    'achievement_gold_pour_title': {
      'en': 'Gold Pour',
      'uk': 'Золотий налив',
      'ru': 'Золотой налив',
    },
    'achievement_gold_pour_subtitle': {
      'en': 'Earn one gold award in a level.',
      'uk': 'Отримай одну золоту нагороду на рівні.',
      'ru': 'Получи одну золотую награду на уровне.',
    },
    'achievement_gold_pour_reward': {
      'en': 'Unlocks Gold Award Frame',
      'uk': 'Відкриває золоту рамку',
      'ru': 'Открывает золотую рамку',
    },
    'achievement_basic_campaign_complete_title': {
      'en': 'Basic Bar Graduate',
      'uk': 'Випускник базового бару',
      'ru': 'Выпускник базового бара',
    },
    'achievement_basic_campaign_complete_subtitle': {
      'en': 'Complete all 20 Basic Bar Academy levels.',
      'uk': 'Пройди всі 20 рівнів Basic Bar Academy.',
      'ru': 'Пройди все 20 уровней Basic Bar Academy.',
    },
    'achievement_basic_campaign_complete_reward': {
      'en': 'Unlocks Graduate Badge',
      'uk': 'Відкриває значок випускника',
      'ru': 'Открывает значок выпускника',
    },
    'achievement_diamond_bar_title': {
      'en': 'Diamond Bar',
      'uk': 'Діамантовий бар',
      'ru': 'Бриллиантовый бар',
    },
    'achievement_diamond_bar_subtitle': {
      'en': 'Earn gold on all Basic Academy levels.',
      'uk': 'Отримай золото на всіх рівнях Basic Academy.',
      'ru': 'Получи золото на всех уровнях Basic Academy.',
    },
    'achievement_diamond_bar_reward': {
      'en': 'Unlocks Diamond Bar Frame',
      'uk': 'Відкриває діамантову рамку',
      'ru': 'Открывает бриллиантовую рамку',
    },
    'achievement_add_friend_title': {
      'en': 'First Bar Friend',
      'uk': 'Перший барний друг',
      'ru': 'Первый барный друг',
    },
    'achievement_add_friend_subtitle': {
      'en': 'Add one friend when multiplayer arrives.',
      'uk': 'Додай одного друга, коли зʼявиться мультиплеєр.',
      'ru': 'Добавь одного друга, когда появится мультиплеер.',
    },
    'achievement_add_friend_reward': {
      'en': 'Coming soon with multiplayer',
      'uk': 'Скоро разом із мультиплеєром',
      'ru': 'Скоро вместе с мультиплеером',
    },
    'achievement_duel_win_title': {
      'en': 'First Duel Win',
      'uk': 'Перша перемога в дуелі',
      'ru': 'Первая победа в дуэли',
    },
    'achievement_duel_win_subtitle': {
      'en': 'Win your first multiplayer duel.',
      'uk': 'Виграй свою першу мультиплеєрну дуель.',
      'ru': 'Выиграй свою первую мультиплеерную дуэль.',
    },
    'achievement_duel_win_reward': {
      'en': 'Coming soon with multiplayer',
      'uk': 'Скоро разом із мультиплеєром',
      'ru': 'Скоро вместе с мультиплеером',
    },

    // Leaderboard
    'your_xp': {
      'en': 'Your XP',
      'uk': 'Твій XP',
      'ru': 'Твой XP',
    },
    'compare_progress': {
      'en':
          'Compare mixology XP, academy progress, and gold awards. Online ranking can be connected later.',
      'uk':
          'Порівнюй XP з міксології, прогрес академії та золоті нагороди. Онлайн-рейтинг можна підключити пізніше.',
      'ru':
          'Сравнивай XP по миксологии, прогресс академии и золотые награды. Онлайн-рейтинг можно подключить позже.',
    },
    'achievement_first_quiz_title': {
      'en': 'First Sip',
      'uk': 'Перший ковток',
      'ru': 'Первый глоток',
    },
    'achievement_first_quiz_subtitle': {
      'en': 'Complete your first quiz.',
      'uk': 'Пройди свій перший тест.',
      'ru': 'Пройди свой первый тест.',
    },
    'achievement_first_quiz_reward': {
      'en': 'Unlocks Copper Frame',
      'uk': 'Відкриває мідну рамку',
      'ru': 'Открывает медную рамку',
    },
    'levels': {
      'en': 'Levels',
      'uk': 'Рівні',
      'ru': 'Уровни',
    },
    'gold': {
      'en': 'Gold',
      'uk': 'Золото',
      'ru': 'Золото',
    },
    'lvl': {
      'en': 'LVL',
      'uk': 'РІВ',
      'ru': 'УР',
    },
    'you': {
      'en': 'You',
      'uk': 'Ти',
      'ru': 'Ты',
    },
    'mojito_apprentice': {
      'en': 'Mojito Apprentice',
      'uk': 'Учень мохіто',
      'ru': 'Ученик мохито',
    },
    'whiskey_specialist': {
      'en': 'Whiskey Specialist',
      'uk': 'Спеціаліст з віскі',
      'ru': 'Специалист по виски',
    },
    'citrus_expert': {
      'en': 'Citrus Expert',
      'uk': 'Експерт з цитрусів',
      'ru': 'Эксперт по цитрусам',
    },
    'daily_mixology_regular': {
      'en': 'Daily Mixology Regular',
      'uk': 'Постійний гість Daily Mixology',
      'ru': 'Постоянный участник Daily Mixology',
    },
    'bar_student': {
      'en': 'Bar Student',
      'uk': 'Студент бару',
      'ru': 'Студент бара',
    },
    'glassware_learner': {
      'en': 'Glassware Learner',
      'uk': 'Учень барного посуду',
      'ru': 'Ученик барной посуды',
    },
    'new_bartender': {
      'en': 'New Bartender',
      'uk': 'Новий бармен',
      'ru': 'Новый бармен',
    },
    'premium_campaign': {
      'en': 'Premium campaign',
      'uk': 'Premium-кампанія',
      'ru': 'Premium-кампания',
    },
    'comfort': {
      'en': 'Comfort',
      'uk': 'Комфорт',
      'ru': 'Комфорт',
    },
    'offline_no_ads': {
      'en': 'Offline + No Ads',
      'uk': 'Офлайн + без реклами',
      'ru': 'Офлайн + без рекламы',
    },
    'offline_no_ads_subtitle': {
      'en': 'Use the full encyclopedia offline and remove ads from the Potio experience.',
      'uk': 'Користуйся повною енциклопедією офлайн і прибери рекламу з Potio.',
      'ru': 'Используй полную энциклопедию офлайн и убери рекламу из Potio.',
    },
    'audio_settings': {
      'en': 'Audio Settings',
      'uk': 'Налаштування звуку',
      'ru': 'Настройки звука',
    },
    'sound_effects_subtitle': {
      'en': 'Button taps, correct/wrong answers, achievements',
      'uk': 'Натискання кнопок, правильні/неправильні відповіді, досягнення',
      'ru': 'Нажатия кнопок, правильные/неправильные ответы, достижения',
    },
    'effects_volume': {
      'en': 'Effects Volume',
      'uk': 'Гучність ефектів',
      'ru': 'Громкость эффектов',
    },
    'background_music': {
      'en': 'Background Music',
      'uk': 'Фонова музика',
      'ru': 'Фоновая музыка',
    },
    'background_music_subtitle': {
      'en': 'Potio background loop',
      'uk': 'Фонова музика Potio',
      'ru': 'Фоновая музыка Potio',
    },
    'music_volume': {
      'en': 'Music Volume',
      'uk': 'Гучність музики',
      'ru': 'Громкость музыки',
    },
    // Shared small labels
    'all': {
      'en': 'All',
      'uk': 'Усі',
      'ru': 'Все',
    },
    'selected': {
      'en': 'selected',
      'uk': 'вибрано',
      'ru': 'выбрано',
    },

    // Play screen
    'play': {
      'en': 'Play',
      'uk': 'Грати',
      'ru': 'Играть',
    },
    'play_subtitle': {
      'en': 'All game modes are free. Free users practise with the 50 basic drinks.',
      'uk': 'Усі режими гри безкоштовні. Безкоштовні користувачі тренуються з 50 базовими напоями.',
      'ru': 'Все игровые режимы бесплатны. Бесплатные пользователи тренируются с 50 базовыми напитками.',
    },
    'mode_1': {
      'en': 'Mode 1',
      'uk': 'Режим 1',
      'ru': 'Режим 1',
    },
    'mode_2': {
      'en': 'Mode 2',
      'uk': 'Режим 2',
      'ru': 'Режим 2',
    },
    'mode_3': {
      'en': 'Mode 3',
      'uk': 'Режим 3',
      'ru': 'Режим 3',
    },
    'mode_4': {
      'en': 'Mode 4',
      'uk': 'Режим 4',
      'ru': 'Режим 4',
    },
    'daily': {
      'en': 'Daily',
      'uk': 'Щодня',
      'ru': 'Ежедневно',
    },
    'future_online': {
      'en': 'Future online',
      'uk': 'Майбутній онлайн',
      'ru': 'Будущий онлайн',
    },
    'recipe_guess': {
      'en': 'Recipe Guess',
      'uk': 'Вгадай рецепт',
      'ru': 'Угадай рецепт',
    },
    'recipe_guess_subtitle': {
      'en': 'See ingredients and choose the correct drink.',
      'uk': 'Подивись на інгредієнти та обери правильний напій.',
      'ru': 'Посмотри на ингредиенты и выбери правильный напиток.',
    },
    'picture_match': {
      'en': 'Picture Match',
      'uk': 'Матч зображень',
      'ru': 'Матч изображений',
    },
    'picture_match_subtitle': {
      'en': 'Match the drink image to the correct name.',
      'uk': 'Зістав зображення напою з правильною назвою.',
      'ru': 'Сопоставь изображение напитка с правильным названием.',
    },
    'build_the_drink': {
      'en': 'Build the Drink',
      'uk': 'Збери напій',
      'ru': 'Собери напиток',
    },
    'build_the_drink_subtitle': {
      'en': 'Fill missing facts: glass, ice, method, garnish, or step.',
      'uk': 'Заповни пропущені факти: посуд, лід, метод, прикрасу або крок.',
      'ru': 'Заполни пропущенные факты: бокал, лёд, метод, украшение или шаг.',
    },
    'mixology_trivia': {
      'en': 'Mixology Trivia',
      'uk': 'Вікторина з міксології',
      'ru': 'Викторина по миксологии',
    },
    'mixology_trivia_subtitle': {
      'en': 'Answer questions about allergens, ingredients, techniques, and bar knowledge.',
      'uk': 'Відповідай на питання про алергени, інгредієнти, техніки та барні знання.',
      'ru': 'Отвечай на вопросы об аллергенах, ингредиентах, техниках и барных знаниях.',
    },
    'daily_mixology_play_subtitle': {
      'en': 'A free daily challenge for everyone.',
      'uk': 'Безкоштовне щоденне завдання для всіх.',
      'ru': 'Бесплатное ежедневное задание для всех.',
    },
    'duels': {
      'en': 'Duels',
      'uk': 'Дуелі',
      'ru': 'Дуэли',
    },
    'duels_subtitle': {
      'en': 'Coming soon. Online drink-knowledge duels will be added in a future update.',
      'uk': 'Скоро буде. Онлайн-дуелі на знання напоїв зʼявляться в майбутньому оновленні.',
      'ru': 'Скоро будет. Онлайн-дуэли на знание напитков появятся в будущем обновлении.',
    },
    'duels_locked_message': {
      'en': 'Duels are coming soon in a future multiplayer update.',
      'uk': 'Дуелі зʼявляться пізніше в майбутньому мультиплеєрному оновленні.',
      'ru': 'Дуэли появятся позже в будущем мультиплеерном обновлении.',
    },

    // Encyclopedia missing labels
    'image_placeholder': {
      'en': 'Image placeholder',
      'uk': 'Місце для зображення',
      'ru': 'Место для изображения',
    },
    'glass': {
      'en': 'Glass',
      'uk': 'Посуд',
      'ru': 'Бокал',
    },
    'ice': {
      'en': 'Ice',
      'uk': 'Лід',
      'ru': 'Лёд',
    },
    'method': {
      'en': 'Method',
      'uk': 'Метод',
      'ru': 'Метод',
    },
    'garnish': {
      'en': 'Garnish',
      'uk': 'Прикраса',
      'ru': 'Украшение',
    },
    'alcoholic': {
      'en': 'Alcoholic',
      'uk': 'Алкогольний',
      'ru': 'Алкогольный',
    },
    'mocktail': {
      'en': 'Mocktail',
      'uk': 'Безалкогольний',
      'ru': 'Безалкогольный',
    },
    'remove_from_favourites': {
      'en': 'Remove from favourites',
      'uk': 'Видалити з обраного',
      'ru': 'Удалить из избранного',
    },
    'add_to_favourites': {
      'en': 'Add to favourites',
      'uk': 'Додати до обраного',
      'ru': 'Добавить в избранное',
    },
    'no_drinks_match_filters': {
      'en': 'No drinks match these filters. Try changing alcohol type, difficulty, country, or favourites.',
      'uk': 'Жоден напій не відповідає цим фільтрам. Спробуй змінити тип алкоголю, складність, країну або обране.',
      'ru': 'Нет напитков, подходящих под эти фильтры. Попробуй изменить тип алкоголя, сложность, страну или избранное.',
    },
    'premium_drink': {
        'en': 'Premium Drink',
        'uk': 'Преміум-напій',
        'ru': 'Премиум-напиток',
      },
      'unlock_premium_recipe': {
        'en': 'Unlock Potio Premium to view ingredients, method, glassware, and test yourself on this recipe.',
        'uk': 'Відкрийте Potio Premium, щоб побачити інгредієнти, метод, посуд і пройти тест за цим рецептом.',
        'ru': 'Откройте Potio Premium, чтобы увидеть ингредиенты, метод, посуду и пройти тест по этому рецепту.',
      },
      'unlock_premium': {
        'en': 'Unlock Premium',
        'uk': 'Відкрити Преміум',
        'ru': 'Открыть Премиум',
      },
      'premium_recipe': {
        'en': 'Premium Recipe',
        'uk': 'Преміум Рецепт',
        'ru': 'Премиум Рецепт',
      },
  };
}