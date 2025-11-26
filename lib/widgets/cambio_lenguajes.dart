import 'package:enrique_masegosac1/config/resources/Botones/botones_colores.dart';
import 'package:enrique_masegosac1/config/utils/lenguajes.dart';
import 'package:enrique_masegosac1/locale_bloc/locale_bloc.dart';
import 'package:enrique_masegosac1/locale_bloc/locale_events.dart';
import 'package:enrique_masegosac1/locale_bloc/locale_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget buildLanguageSwitch(
  BuildContext context,
  ThemeData theme,
  LocaleState state,
) {
  return TextButton(
    onPressed: () {
      context.read<LocaleBloc>().add(
        ChangeLanguage(
          state.selectedLanguage == Language.spanish
              ? Language.english
              : Language.spanish,
        ),
      );
    },
    child: RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "ES",
            style: TextStyle(
              fontSize: 18,
              color: state.selectedLanguage == Language.spanish
                  ? ButtonColors.Principal
                  : ButtonColors.Secundario,
            ),
          ),
          const TextSpan(
            text: " | ",
            style: TextStyle(fontSize: 18, color: ButtonColors.Principal),
          ),
          TextSpan(
            text: "EN",
            style: TextStyle(
              fontSize: 18,
              color: state.selectedLanguage == Language.english
                  ? ButtonColors.Principal
                  : ButtonColors.Secundario,
            ),
          ),
        ],
      ),
    ),
  );
}
