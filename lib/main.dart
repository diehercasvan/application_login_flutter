import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/settings_provider.dart';
import 'pages/splash/splash_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SettingsProvider()..loadSettings(),
        ),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, child) {
          return MaterialApp(
            title: 'Flutter Demo App',
            theme: _buildTheme(settingsProvider, false),
            darkTheme: _buildTheme(settingsProvider, true),
            themeMode: settingsProvider.settings.isDarkMode
                ? ThemeMode.dark
                : ThemeMode.light,
            home: const SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

ThemeData _buildTheme(SettingsProvider settingsProvider, bool isDark) {
  Color primaryColor;

  // Usar el color del theme desde el provider
  switch (settingsProvider.settings.themeColor) {
    case 'blue':
      primaryColor = Colors.blue;
      break;
    case 'green':
      primaryColor = Colors.green;
      break;
    case 'purple':
      primaryColor = Colors.purple;
      break;
    case 'orange':
      primaryColor = Colors.orange;
      break;
    case 'red':
      primaryColor = Colors.red;
      break;
    case 'pink':
      primaryColor = Colors.pink;
      break;
    default:
      primaryColor = Colors.blue;
  }

  final brightness = isDark ? Brightness.dark : Brightness.light;

  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: brightness,
    ),
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 2,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: brightness == Brightness.dark ? Colors.white : Colors.black,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: brightness == Brightness.dark ? Colors.white70 : Colors.black87,
      ),
    ),
  );
}
