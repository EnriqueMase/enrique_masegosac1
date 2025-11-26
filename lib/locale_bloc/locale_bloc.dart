import 'package:enrique_masegosac1/locale_bloc/locale_events.dart';
import 'package:enrique_masegosac1/locale_bloc/locale_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc() : super(LocaleInitial()) {
    on<ChangeLanguage>(_onChangeLanguage);
  }

  _onChangeLanguage(ChangeLanguage event, Emitter<LocaleState> emit) {
    emit(LocaleChanged(language: event.selectedLanguage));
  }
}
