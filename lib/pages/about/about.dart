import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App - About',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
      home: const PageAbout(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PageAbout extends StatefulWidget {
  const PageAbout({super.key});
  @override
  State<PageAbout> createState() => _PageAboutState();
}

class _PageAboutState extends State<PageAbout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () => print('Agregar información'),
            tooltip: 'Agregar información',
          ),
        ],
      ),
      body: const Center(
        child: Text('Acerca de'),
      ),
    );
  }
}
