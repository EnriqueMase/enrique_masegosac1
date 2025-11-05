import 'package:flutter/material.dart';
import 'package:enrique_masegosac1/config/utils/button_color.dart';

class ButtonStyles {
  static final ButtonStyle primaryButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primaryColor,
    padding: const EdgeInsets.symmetric(
      horizontal: AppSizes.buttonHorizontalPadding,
      vertical: AppSizes.buttonVerticalPadding,
    ),
    textStyle: const TextStyle(
      fontSize: AppSizes.buttonFontSize,
      color: Colors.white,
    ),
  );

  static final ButtonStyle secondaryButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.secondaryColor,
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
    backgroundColor: AppColors.cancelColor,
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
    side: BorderSide(color: AppColors.primaryColor),
  );
}
