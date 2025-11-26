import 'package:flutter/material.dart';
import 'package:enrique_masegosac1/config/resources/Botones/botones_colores.dart';
import 'package:enrique_masegosac1/config/resources/Botones/botones_tamaño.dart';
import 'package:enrique_masegosac1/config/resources/Texto/texto_estilos.dart';

class BotonesEstilo {
  /// Botón principal (elevated)
  static final ButtonStyle primary = ElevatedButton.styleFrom(
    backgroundColor: ButtonColors.Principal,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(
      horizontal: ButtonSizes.paddingHorizontal,
      vertical: ButtonSizes.paddingVertical,
    ),
    textStyle: AppTextStyles.button,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(ButtonSizes.borderRadius),
    ),
  );

  /// Botón secundario (elevated morado)
  static final ButtonStyle secondary = ElevatedButton.styleFrom(
    backgroundColor: ButtonColors.Secundario,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(
      horizontal: ButtonSizes.paddingHorizontal,
      vertical: ButtonSizes.paddingVertical,
    ),
    textStyle: AppTextStyles.button,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(ButtonSizes.borderRadius),
    ),
  );

  /// Botón de cancelar (rojo oscuro)
  static final ButtonStyle cancel = ElevatedButton.styleFrom(
    backgroundColor: ButtonColors.Cancelar,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(
      horizontal: ButtonSizes.paddingHorizontal,
      vertical: ButtonSizes.paddingVertical,
    ),
    textStyle: AppTextStyles.button,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(ButtonSizes.borderRadius),
    ),
  );

  /// Botón de imagen / acción secundaria (outlined)
  static final ButtonStyle outlined = OutlinedButton.styleFrom(
    padding: const EdgeInsets.symmetric(
      horizontal: ButtonSizes.paddingHorizontal,
      vertical: ButtonSizes.paddingVertical,
    ),
    textStyle: AppTextStyles.button,
    side: const BorderSide(color: ButtonColors.Principal),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(ButtonSizes.borderRadius),
    ),
  );
}
