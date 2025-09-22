import 'package:flutter/material.dart';
import '../../widgets/appbar.dart';

class UserFormScreen extends StatefulWidget {
  const UserFormScreen({super.key});

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String patternEmail = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';

  // Listas para profilees y statuss
  final List<String> _profilees = ['Administrador', 'Usuario', 'Invitado'];
  final List<String> _statuss = ['Activo', 'Inactivo', 'Pendiente'];

  // Valores seleccionados
  String? _profileSeleccionado;
  String? _statusSeleccionado;

  void _register() {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Las contraseñas no coinciden')),
        );
        return;
      }

      // Validar que se haya seleccionado un profile y status
      if (_profileSeleccionado == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor seleccione un profile')),
        );
        return;
      }

      if (_statusSeleccionado == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor seleccione un status')),
        );
        return;
      }

      final userData = {
        'username': _usernameController.text,
        'password': _passwordController.text,
        'email': _emailController.text,
        'profile': _profileSeleccionado,
        'status': _statusSeleccionado,
      };

      Navigator.pop(context, userData);
    }
  }

  void _cancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const CustomAppBar(title: 'Registrar Usuario', showBackButton: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Image.asset(
                'assets/img/logos/stamp.webp',
                height: 100,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Usuario',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un usuario';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un email';
                  }
                  if (!RegExp(patternEmail).hasMatch(value)) {
                    return 'Ingrese un email válido correo@gmail.com';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Dropdown para seleccionar profile
              DropdownButtonFormField<String>(
                value: _profileSeleccionado,
                decoration: const InputDecoration(
                  labelText: 'profile',
                  prefixIcon: Icon(Icons.assignment_ind),
                  border: OutlineInputBorder(),
                ),
                items: _profilees.map((String profile) {
                  return DropdownMenuItem<String>(
                    value: profile,
                    child: Text(profile),
                  );
                }).toList(),
                onChanged: (String? nuevoValor) {
                  setState(() {
                    _profileSeleccionado = nuevoValor;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor seleccione un profile';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una contraseña';
                  }
                  if (value.length < 6) {
                    return 'La contraseña debe tener al menos 6 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Confirmar Contraseña',
                  prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor confirme su contraseña';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Dropdown para seleccionar status
              DropdownButtonFormField<String>(
                value: _statusSeleccionado,
                decoration: const InputDecoration(
                  labelText: 'status',
                  prefixIcon: Icon(Icons.toggle_on),
                  border: OutlineInputBorder(),
                ),
                items: _statuss.map((String status) {
                  return DropdownMenuItem<String>(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (String? nuevoValor) {
                  setState(() {
                    _statusSeleccionado = nuevoValor;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor seleccione un status';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _register,
                      child: const Text('Registrar'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _cancel,
                      child: const Text('Cancelar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
