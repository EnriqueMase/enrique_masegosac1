import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color.fromARGB(255, 8, 179, 2);
  static const Color secondaryColor = Color.fromARGB(255, 153, 117, 173);
  static const Color cancelColor = Color.fromARGB(255, 92, 57, 57);
  static const Color errorColor = Colors.red;
  static const Color successColor = Colors.green;
}

class AppSizes {
  // Button sizes
  static const double buttonHorizontalPadding = 40.0;
  static const double buttonVerticalPadding = 15.0;
  static const double buttonFontSize = 18.0;

  // Spacing
  static const double defaultSpacing = 16.0;
  static const double smallSpacing = 8.0;
  static const double largeSpacing = 24.0;

  // Avatar sizes
  static const double avatarRadius = 50.0;
  static const double avatarIconSize = 48.0;
}

class AppStrings {
  // Titles
  static const String appTitle = "Lord Team";
  static const String registerTitle = "Registrarse";
  static const String loginTitle = "Iniciar Sesión";

  // Button texts
  static const String registerButton = "Registrarse";
  static const String loginButton = "Iniciar Sesión";
  static const String cancelButton = "Cancelar";
  static const String addImageButton = "Añadir imagen";
  static const String takePhotoButton = "Tomar foto";

  // Form labels
  static const String nameLabel = "Nombre";
  static const String passwordLabel = "Contraseña";
  static const String confirmPasswordLabel = "Repite la contraseña";
  static const String ageLabel = "Edad";
  static const String birthplaceLabel = "Lugar de Nacimiento";

  // Messages
  static const String termsAndConditions = "Aceptas los términos y condiciones";
  static const String successMessage = "Registro exitoso";
  static const String errorMessage = "Ha ocurrido un error";
}
