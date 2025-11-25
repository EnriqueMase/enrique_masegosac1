import 'package:enrique_masegosac1/config/resources/botones_colores.dart';
import 'package:flutter/material.dart';

class BotonesEstilo {
  static final ButtonStyle primaryButton = ElevatedButton.styleFrom(
    foregroundColor: const Color.fromARGB(255, 255, 255, 255),
    backgroundColor: const Color.fromARGB(255, 65, 172, 61),
    padding: const EdgeInsets.symmetric(
      horizontal: AppSizes.buttonHorizontalPadding,
      vertical: AppSizes.buttonVerticalPadding,
    ),

    textStyle: const TextStyle(fontSize: AppSizes.buttonFontSize),
  );

  static final ButtonStyle secondaryButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.colorSecundario,
    padding: const EdgeInsets.symmetric(
      horizontal: AppSizes.buttonHorizontalPadding,
      vertical: AppSizes.buttonVerticalPadding,
    ),
    textStyle: const TextStyle(
      fontSize: AppSizes.buttonFontSize,
      color: Colors.white,
    ),
  );

  static final ButtonStyle cancelButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.colordecancelar,
    padding: const EdgeInsets.symmetric(
      horizontal: AppSizes.buttonHorizontalPadding,
      vertical: AppSizes.buttonVerticalPadding,
    ),
    textStyle: const TextStyle(
      fontSize: AppSizes.buttonFontSize,
      color: Colors.white,
    ),
  );

  static final ButtonStyle imageButton = OutlinedButton.styleFrom(
    padding: const EdgeInsets.symmetric(
      horizontal: AppSizes.buttonHorizontalPadding,
      vertical: AppSizes.buttonVerticalPadding,
    ),
    side: BorderSide(color: AppColors.colorPrincipal),
  );
}
