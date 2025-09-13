class ValidationUtils {
  // Expresiones regulares para validación
  static final RegExp nameRegex = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]{3,50}$');
  static final RegExp emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  static final RegExp passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
  static final RegExp phoneRegex = RegExp(r'^[0-9]{10,15}$');
  static final RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9_]{3,20}$');

  // Métodos de validación estáticos
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'El nombre es obligatorio';
    }
    if (!nameRegex.hasMatch(value)) {
      return 'El nombre debe tener entre 3 y 50 caracteres (solo letras y espacios)';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'El email es obligatorio';
    }
    if (!emailRegex.hasMatch(value)) {
      return 'Ingrese un email válido (ejemplo: usuario@dominio.com)';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña es obligatoria';
    }
    if (!passwordRegex.hasMatch(value)) {
      return 'La contraseña debe tener:\n• Mínimo 8 caracteres\n• Una mayúscula\n• Una minúscula\n• Un número\n• Un carácter especial (@\$!%*?&)';
    }
    return null;
  }

  static String? validateConfirmPassword(
      String? value, String originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Confirme su contraseña';
    }
    if (value != originalPassword) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'El teléfono es obligatorio';
    }
    if (!phoneRegex.hasMatch(value)) {
      return 'Ingrese un número de teléfono válido (10-15 dígitos)';
    }
    return null;
  }

  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'El usuario es obligatorio';
    }
    if (!usernameRegex.hasMatch(value)) {
      return 'El usuario debe tener entre 3-20 caracteres\n(solo letras, números y guiones bajos)';
    }
    return null;
  }

  // Método para validar múltiples campos
  static Map<String, String> validateAllFields(Map<String, String> fields) {
    final errors = <String, String>{};

    if (fields.containsKey('name')) {
      final error = validateName(fields['name']);
      if (error != null) errors['name'] = error;
    }

    if (fields.containsKey('email')) {
      final error = validateEmail(fields['email']);
      if (error != null) errors['email'] = error;
    }

    if (fields.containsKey('password')) {
      final error = validatePassword(fields['password']);
      if (error != null) errors['password'] = error;
    }

    return errors;
  }
}
