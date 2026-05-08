class AppConstants {
  // App Info
  static const String appName = 'MindBridge';
  static const String appVersion = '1.0.0';
  static const String appTagline = 'You are never alone in this journey';

  // API Endpoints
  static const String baseUrl = 'https://api.mindbridge.app/v1';
  static const String wsUrl = 'wss://ws.mindbridge.app/v1';
  static const String aiEndpoint = '$baseUrl/ai';
  static const String matchEndpoint = '$baseUrl/match';
  static const String sessionEndpoint = '$baseUrl/session';
  static const String journalEndpoint = '$baseUrl/journal';
  static const String communityEndpoint = '$baseUrl/community';

  // Hive Boxes
  static const String userBox = 'user_box';
  static const String journalBox = 'journal_box';
  static const String sessionBox = 'session_box';
  static const String moodBox = 'mood_box';
  static const String settingsBox = 'settings_box';
  static const String cacheBox = 'cache_box';

  // Secure Storage Keys
  static const String authTokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userIdKey = 'user_id';
  static const String pinKey = 'app_pin';

  // Mood Levels
  static const int moodCrisis = 1;
  static const int moodVeryLow = 2;
  static const int moodLow = 3;
  static const int moodNeutral = 4;
  static const int moodGood = 5;
  static const int moodGreat = 6;
  static const int moodExcellent = 7;

  // Safety Thresholds
  static const double crisisThreshold = 0.75;
  static const double warningThreshold = 0.50;
  static const double lowRiskThreshold = 0.25;

  // Session Limits
  static const int maxSessionDuration = 120; // minutes
  static const int minSessionDuration = 15; // minutes
  static const int maxDailyFreeSessions = 2;
  static const int maxMessageLength = 1000;

  // Crisis Resources
  static const String crisisHotline = '988'; // US Suicide & Crisis Lifeline
  static const String crisisText = 'Text HOME to 741741';
  static const String crisisWebsite = 'https://988lifeline.org';

  // AI Model
  static const String aiModel = 'gemini-pro';
  static const int aiMaxTokens = 2048;
  static const double aiTemperature = 0.7;

  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration matchTimeout = Duration(minutes: 5);

  // Pagination
  static const int pageSize = 20;

  // Peer Support Categories
  static const List<String> supportCategories = [
    'Anxiety & Panic Attacks',
    'Depression & Low Mood',
    'Grief & Loss',
    'Relationship Issues',
    'Work & Burnout',
    'Trauma & PTSD',
    'Addiction Recovery',
    'Eating Disorders',
    'Self-Harm Recovery',
    'Loneliness & Isolation',
    'LGBTQ+ Struggles',
    'Family Conflicts',
    'Financial Stress',
    'Chronic Illness',
    'Identity & Purpose',
  ];

  // Journal Prompts
  static const List<String> journalPrompts = [
    'What are three things you\'re grateful for today?',
    'Describe a moment today when you felt at peace.',
    'What emotion is strongest right now? Where do you feel it in your body?',
    'What would you tell your past self about this struggle?',
    'What small win can you celebrate today, no matter how tiny?',
    'Who has shown you kindness recently?',
    'What are you afraid of, and what would courage look like here?',
    'Describe your perfect healing day.',
    'What boundary do you need to set for your wellbeing?',
    'Write a letter to the version of you who is fully healed.',
  ];

  // Breathing Exercises
  static const Map<String, Map<String, dynamic>> breathingExercises = {
    'Box Breathing': {
      'inhale': 4,
      'hold1': 4,
      'exhale': 4,
      'hold2': 4,
      'description': 'Used by Navy SEALs to calm the nervous system',
    },
    '4-7-8 Breathing': {
      'inhale': 4,
      'hold1': 7,
      'exhale': 8,
      'hold2': 0,
      'description': 'Dr. Weil\'s anxiety relief technique',
    },
    'Calming Breath': {
      'inhale': 4,
      'hold1': 0,
      'exhale': 6,
      'hold2': 0,
      'description': 'Simple calming for everyday stress',
    },
  };
}
