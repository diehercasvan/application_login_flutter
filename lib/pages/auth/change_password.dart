import 'package:flutter/material.dart';
import '../../widgets/appbar.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const CustomAppBar(title: 'Cambiar Contraseña', showBackButton: true),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text('Pantalla de cambio de contraseña'),
          ],
        ),
      ),
    );
  }
}
