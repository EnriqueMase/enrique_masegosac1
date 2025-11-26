import 'package:enrique_masegosac1/config/utils/lenguajes.dart';
import 'package:equatable/equatable.dart';

sealed class LocaleState extends Equatable {
  final Language selectedLanguage;
  const LocaleState({Language? language})
    : selectedLanguage = language ?? Language.spanish;

  @override
  List<Object> get props => [selectedLanguage];
}

final class LocaleInitial extends LocaleState {}

final class LocaleChanged extends LocaleState {
  const LocaleChanged({super.language});
}
