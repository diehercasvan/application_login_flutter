import 'package:flutter/foundation.dart';
import '../models/settings_model.dart';

class SettingsProvider with ChangeNotifier {
  AppSettings _settings = AppSettings(
    isDarkMode: false,
    notificationsEnabled: true,
    biometricAuthEnabled: false,
    language: 'es',
    themeColor: 'blue',
  );

  AppSettings get settings => _settings;

  void updateSettings(AppSettings newSettings) {
    _settings = newSettings;
    notifyListeners();
    _saveSettings();
  }

  void toggleDarkMode() {
    _settings = _settings.copyWith(isDarkMode: !_settings.isDarkMode);
    notifyListeners();
    _saveSettings();
  }

  void toggleNotifications() {
    _settings = _settings.copyWith(
      notificationsEnabled: !_settings.notificationsEnabled,
    );
    notifyListeners();
    _saveSettings();
  }

  void toggleBiometricAuth() {
    _settings = _settings.copyWith(
      biometricAuthEnabled: !_settings.biometricAuthEnabled,
    );
    notifyListeners();
    _saveSettings();
  }

  void changeLanguage(String language) {
    _settings = _settings.copyWith(language: language);
    notifyListeners();
    _saveSettings();
  }

  void changeThemeColor(String color) {
    _settings = _settings.copyWith(themeColor: color);
    notifyListeners();
    _saveSettings();
  }

  // Simulación de guardado
  void _saveSettings() {
    if (kDebugMode) {
      print('Settings guardados: ${_settings.toMap()}');
    }
  }

  // Simulación de carga
  Future<void> loadSettings() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (kDebugMode) {
      print('Settings cargados');
    }
  }
}
