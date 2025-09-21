import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/settings_provider.dart';
import '../../widgets/settings_option.dart';
import 'change_password_screen.dart';
import 'change_email_screen.dart';
import 'theme_settings_screen.dart';
import 'language_settings_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sección: Cuenta
            _buildSectionHeader('Cuenta'),
            SettingsOption(
              icon: Icons.email,
              title: 'Cambiar Email',
              subtitle: 'Actualiza tu dirección de correo electrónico',
              onTap: () => _navigateTo(context, const ChangeEmailScreen()),
            ),
            SettingsOption(
              icon: Icons.lock,
              title: 'Cambiar Contraseña',
              subtitle: 'Establece una nueva contraseña segura',
              onTap: () => _navigateTo(context, const ChangePasswordScreen()),
            ),
            const SizedBox(height: 16),

            // Sección: Apariencia
            _buildSectionHeader('Apariencia'),
            SettingsOption(
              icon: Icons.color_lens,
              title: 'Tema de la App',
              subtitle: 'Personaliza colores y aspecto',
              onTap: () => _navigateTo(context, const ThemeSettingsScreen()),
            ),
            SettingsOption(
              icon: Icons.language,
              title: 'Idioma',
              subtitle: 'Selecciona el idioma de la aplicación',
              onTap: () => _navigateTo(context, const LanguageSettingsScreen()),
            ),
            const SizedBox(height: 16),

            // Sección: Privacidad y Seguridad
            _buildSectionHeader('Privacidad y Seguridad'),
            Consumer<SettingsProvider>(
              builder: (context, settingsProvider, child) {
                return SettingsOption(
                  icon: Icons.fingerprint,
                  title: 'Autenticación Biométrica',
                  subtitle: 'Usar huella digital o reconocimiento facial',
                  trailing: Switch(
                    value: settingsProvider.settings.biometricAuthEnabled,
                    onChanged: (value) =>
                        settingsProvider.toggleBiometricAuth(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),

            // Sección: Notificaciones
            _buildSectionHeader('Notificaciones'),
            Consumer<SettingsProvider>(
              builder: (context, settingsProvider, child) {
                return SettingsOption(
                  icon: Icons.notifications,
                  title: 'Notificaciones',
                  subtitle: 'Permitir notificaciones de la app',
                  trailing: Switch(
                    value: settingsProvider.settings.notificationsEnabled,
                    onChanged: (value) =>
                        settingsProvider.toggleNotifications(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),

            // Sección: Acerca de
            _buildSectionHeader('Acerca de'),
            SettingsOption(
              icon: Icons.info,
              title: 'Acerca de la App',
              subtitle: 'Información de versión y desarrolladores',
              onTap: () => _showAboutDialog(context),
            ),
            SettingsOption(
              icon: Icons.security,
              title: 'Política de Privacidad',
              subtitle: 'Cómo manejamos tus datos',
              onTap: () => _showPrivacyPolicy(context),
            ),
            SettingsOption(
              icon: Icons.description,
              title: 'Términos de Servicio',
              subtitle: 'Términos y condiciones de uso',
              onTap: () => _showTermsOfService(context),
            ),

            const SizedBox(height: 32),
            _buildAppVersion(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildAppVersion() {
    return const Center(
      child: Text(
        'Versión 1.0.0',
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Acerca de'),
        content: const SingleChildScrollView(
          child: Text(
            'Mi App Flutter\n\n'
            'Versión: 1.0.0\n'
            'Desarrollado con ❤️ usando Flutter\n\n'
            'Una aplicación demo para mostrar capacidades '
            'de Flutter en desarrollo multiplataforma.',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  void _showPrivacyPolicy(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Política de Privacidad'),
        content: const SingleChildScrollView(
          child: Text(
            'POLÍTICA DE PRIVACIDAD\n\n'
            'Respetamos tu privacidad. Esta aplicación recoge únicamente '
            'la información necesaria para su funcionamiento.\n\n'
            '• Tus datos personales se almacenan localmente\n'
            '• No compartimos información con terceros\n'
            '• Usamos encriptación para proteger tus datos\n'
            '• Puedes solicitar eliminar tus datos en cualquier momento',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  void _showTermsOfService(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Términos de Servicio'),
        content: const SingleChildScrollView(
          child: Text(
            'TÉRMINOS DE SERVICIO\n\n'
            'Al usar esta aplicación, aceptas los siguientes términos:\n\n'
            '1. Uso adecuado de la aplicación\n'
            '2. Respeto a los derechos de propiedad intelectual\n'
            '3. Responsabilidad sobre tu cuenta y contraseña\n'
            '4. Cumplimiento con las leyes locales\n'
            '5. Aceptación de actualizaciones y cambios\n\n'
            'Nos reservamos el derecho de modificar estos términos '
            'en cualquier momento.',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }
}
