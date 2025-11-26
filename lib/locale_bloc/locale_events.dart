import 'package:enrique_masegosac1/config/utils/lenguajes.dart';
import 'package:equatable/equatable.dart';

sealed class LocaleEvent extends Equatable {
  const LocaleEvent();

  @override
  List<Object> get props => [];
}

class ChangeLanguage extends LocaleEvent {
  final Language selectedLanguage;

  const ChangeLanguage(this.selectedLanguage);

  @override
  List<Object> get props => [selectedLanguage];
}
