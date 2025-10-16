import 'package:flutter/material.dart';

class CustomStyles {
  // Tamaño por defecto del logo
  static const double logoImageWidth = 150.0;
  static const double logoImageHeight = 150.0;

  // Widget por defecto del logo
  static Widget logoImage({
    double width = logoImageWidth,
    double height = logoImageHeight,
    BoxFit fit = BoxFit.contain,
  }) {
    return Image.asset(
      'assets/logo.png', // Asegúrate que esta ruta es correcta y esté declarada en pubspec.yaml
      width: width,
      height: height,
      fit: fit,
    );
  }
}
