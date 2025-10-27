class Validators {
  static String? validateEmpty(String? value, [String fieldName = 'campo']) {
    if (value == null || value.trim().isEmpty) {
      return 'Por favor ingresa tu $fieldName';
    }
    return null;
  }

  static String? validatePasswordMatch(String? password, String? confirm) {
    if (password == null || password.isEmpty) {
      return 'Por favor ingresa una contraseña';
    }
    if (confirm == null || confirm.isEmpty) {
      return 'Por favor repite la contraseña';
    }
    if (password != confirm) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }

  static String? validateAge(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Por favor ingresa tu edad';
    }
    final n = int.tryParse(value.trim());
    if (n == null) {
      return 'La edad debe ser un número';
    }
    if (n <= 0) {
      return 'Ingresa una edad válida';
    }
    return null;
  }
}
