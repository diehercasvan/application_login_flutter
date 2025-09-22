import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App - Notifications',
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
      home: const PageNotifications(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PageNotifications extends StatefulWidget {
  const PageNotifications({super.key});
  @override
  State<PageNotifications> createState() => _PageNotificationsState();
}

class _PageNotificationsState extends State<PageNotifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificaciones'),
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
        child: Text('Notificaciones'),
      ),
    );
  }
}
