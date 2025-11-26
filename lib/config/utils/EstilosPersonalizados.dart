import 'package:flutter/material.dart';
import 'package:enrique_masegosac1/config/resources/Botones/botones_estilo.dart';

class EstilosPersonalizados {
  // Colores personalizados
  static ButtonStyle get primaryButton => BotonesEstilo.primary;
  static ButtonStyle get secondaryButton => BotonesEstilo.secondary;
  static ButtonStyle get cancelButton => BotonesEstilo.cancel;
  static ButtonStyle get imageButton => BotonesEstilo.outlined;

  // Tamaño por defecto del logo
  static const double logoImageWidth = 150.0;
  static const double logoImageHeight = 150.0;

  // Widget por defecto del logo
  static Widget logoImage({
    double width = logoImageWidth,
    double height = logoImageHeight,
    BoxFit fit = BoxFit.contain,
  }) {
    return Image.asset('assets/images/Logo.png', fit: fit);
  }
}
