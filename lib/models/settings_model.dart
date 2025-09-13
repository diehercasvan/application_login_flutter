class AppSettings {
  final bool isDarkMode;
  final bool notificationsEnabled;
  final bool biometricAuthEnabled;
  final String language;
  final String themeColor;

  AppSettings({
    required this.isDarkMode,
    required this.notificationsEnabled,
    required this.biometricAuthEnabled,
    required this.language,
    required this.themeColor,
  });

  AppSettings copyWith({
    bool? isDarkMode,
    bool? notificationsEnabled,
    bool? biometricAuthEnabled,
    String? language,
    String? themeColor,
  }) {
    return AppSettings(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      biometricAuthEnabled: biometricAuthEnabled ?? this.biometricAuthEnabled,
      language: language ?? this.language,
      themeColor: themeColor ?? this.themeColor,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isDarkMode': isDarkMode,
      'notificationsEnabled': notificationsEnabled,
      'biometricAuthEnabled': biometricAuthEnabled,
      'language': language,
      'themeColor': themeColor,
    };
  }

  static AppSettings fromMap(Map<String, dynamic> map) {
    return AppSettings(
      isDarkMode: map['isDarkMode'] ?? false,
      notificationsEnabled: map['notificationsEnabled'] ?? true,
      biometricAuthEnabled: map['biometricAuthEnabled'] ?? false,
      language: map['language'] ?? 'es',
      themeColor: map['themeColor'] ?? 'blue',
    );
  }
}
