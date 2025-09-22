import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App - Help',
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
      home: const PageHelp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PageHelp extends StatefulWidget {
  const PageHelp({super.key});
  @override
  State<PageHelp> createState() => _PageHelpState();
}

class _PageHelpState extends State<PageHelp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayuda'),
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
        child: Text('Ayuda'),
      ),
    );
  }
}
