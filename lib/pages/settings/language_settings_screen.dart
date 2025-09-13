import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/settings_provider.dart';

class LanguageSettingsScreen extends StatelessWidget {
  const LanguageSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración de Idioma'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _LanguageSelectionSection(),
            SizedBox(height: 24),
            _LanguageInfoSection(),
          ],
        ),
      ),
    );
  }
}

class _LanguageSelectionSection extends StatelessWidget {
  const _LanguageSelectionSection();

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final currentLanguage = settingsProvider.settings.language;

    const languageOptions = [
      {
        'code': 'es',
        'name': 'Español',
        'nativeName': 'Español',
        'flag': '🇪🇸'
      },
      {
        'code': 'en',
        'name': 'English',
        'nativeName': 'English',
        'flag': '🇺🇸'
      },
      {
        'code': 'fr',
        'name': 'Français',
        'nativeName': 'Français',
        'flag': '🇫🇷'
      },
      {
        'code': 'de',
        'name': 'Deutsch',
        'nativeName': 'Deutsch',
        'flag': '🇩🇪'
      },
      {
        'code': 'pt',
        'name': 'Português',
        'nativeName': 'Português',
        'flag': '🇧🇷'
      },
      {
        'code': 'it',
        'name': 'Italiano',
        'nativeName': 'Italiano',
        'flag': '🇮🇹'
      },
    ];

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Seleccionar Idioma',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Elige el idioma preferido para la aplicación',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: languageOptions.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final language = languageOptions[index];
                final isSelected = currentLanguage == language['code'];

                return _LanguageOption(
                  flag: language['flag'] as String,
                  name: language['name'] as String,
                  nativeName: language['nativeName'] as String,
                  isSelected: isSelected,
                  onTap: () {
                    settingsProvider.changeLanguage(language['code'] as String);
                    _showLanguageChangeDialog(
                        context, language['name'] as String);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageChangeDialog(BuildContext context, String languageName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Idioma Cambiado'),
        content: Text(
          'El idioma se ha cambiado a $languageName. '
          'Algunos cambios pueden requerir reiniciar la aplicación.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Entendido'),
          ),
        ],
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String flag;
  final String name;
  final String nativeName;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.flag,
    required this.name,
    required this.nativeName,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        flag,
        style: const TextStyle(fontSize: 24),
      ),
      title: Text(
        name,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: isSelected ? Theme.of(context).primaryColor : null,
        ),
      ),
      subtitle: Text(nativeName),
      trailing: isSelected
          ? Icon(
              Icons.check_circle,
              color: Theme.of(context).primaryColor,
            )
          : null,
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
    );
  }
}

class _LanguageInfoSection extends StatelessWidget {
  const _LanguageInfoSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Información de Idiomas',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Soporte de idiomas en la aplicación',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            _buildLanguageInfoItem(
              icon: Icons.translate,
              title: 'Idiomas Disponibles',
              subtitle:
                  'Español, English, Français, Deutsch, Português, Italiano',
            ),
            const SizedBox(height: 12),
            _buildLanguageInfoItem(
              icon: Icons.auto_awesome,
              title: 'Detección Automática',
              subtitle: 'La app intenta detectar el idioma del dispositivo',
            ),
            const SizedBox(height: 12),
            _buildLanguageInfoItem(
              icon: Icons.update,
              title: 'Actualizaciones',
              subtitle: 'Más idiomas serán añadidos en futuras actualizaciones',
            ),
            const SizedBox(height: 16),
            const Text(
              '¿No encuentras tu idioma?',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Contáctanos para sugerir nuevos idiomas o ayudar '
              'con las traducciones de la aplicación.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () => _showContactDialog(context),
              child: const Text('Contactar Soporte'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageInfoItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.blue),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Contactar Soporte'),
        content: const Text(
          'Para sugerir nuevos idiomas o ayudar con traducciones, '
          'por favor envía un email a soporte@miapp.com\n\n'
          'Incluye información sobre el idioma que te gustaría ver '
          'en la aplicación.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
          TextButton(
            onPressed: () {
              // Aquí podrías abrir el cliente de email
              Navigator.pop(context);
            },
            child: const Text('Abrir Email'),
          ),
        ],
      ),
    );
  }
}
