import 'package:flutter/material.dart';
import 'package:enrique_masegosac1/config/resources/Texto/texto_colores.dart';
import 'package:enrique_masegosac1/config/resources/Texto/texto_tamaño.dart';

class AppTextStyles {
  static const TextStyle h1 = TextStyle(
    fontSize: TextSizes.h1,
    fontWeight: FontWeight.bold,
    color: TextColors.Principal,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: TextSizes.h2,
    fontWeight: FontWeight.w600,
    color: TextColors.Principal,
  );

  static const TextStyle body = TextStyle(
    fontSize: TextSizes.body,
    color: TextColors.Principal,
  );

  static const TextStyle bodySecondary = TextStyle(
    fontSize: TextSizes.body,
    color: TextColors.Secundario,
  );

  static const TextStyle caption = TextStyle(
    fontSize: TextSizes.caption,
    color: TextColors.Secundario,
  );

  static const TextStyle button = TextStyle(
    fontSize: TextSizes.button,
    fontWeight: FontWeight.w600,
    color: TextColors.onPrimary,
  );
}
