import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In es, this message translates to:
  /// **'App de Lord Team'**
  String get appTitle;

  /// No description provided for @loginWelcome.
  ///
  /// In es, this message translates to:
  /// **'Bienvenido a la App de Lord Team'**
  String get loginWelcome;

  /// No description provided for @loginUserLabel.
  ///
  /// In es, this message translates to:
  /// **'Nombre de usuario'**
  String get loginUserLabel;

  /// No description provided for @loginUserHint.
  ///
  /// In es, this message translates to:
  /// **'Ingresa tu nombre de usuario'**
  String get loginUserHint;

  /// No description provided for @loginPasswordLabel.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get loginPasswordLabel;

  /// No description provided for @loginPasswordHint.
  ///
  /// In es, this message translates to:
  /// **'Ingresa tu contraseña'**
  String get loginPasswordHint;

  /// No description provided for @loginButton.
  ///
  /// In es, this message translates to:
  /// **'Iniciar sesión'**
  String get loginButton;

  /// No description provided for @registerButton.
  ///
  /// In es, this message translates to:
  /// **'Registrarse'**
  String get registerButton;

  /// No description provided for @forgotPassword.
  ///
  /// In es, this message translates to:
  /// **'¿Has olvidado tu usuario o contraseña?'**
  String get forgotPassword;

  /// No description provided for @googleSignInButton.
  ///
  /// In es, this message translates to:
  /// **'Iniciar sesión con Google'**
  String get googleSignInButton;

  /// No description provided for @loginEmptyUserOrPassword.
  ///
  /// In es, this message translates to:
  /// **'El nombre de usuario y la contraseña no pueden estar vacíos'**
  String get loginEmptyUserOrPassword;

  /// No description provided for @loginUserNotFoundOrWrongPassword.
  ///
  /// In es, this message translates to:
  /// **'Usuario no encontrado o contraseña incorrecta'**
  String get loginUserNotFoundOrWrongPassword;

  /// No description provided for @loginUserNotFound.
  ///
  /// In es, this message translates to:
  /// **'Usuario no encontrado'**
  String get loginUserNotFound;

  /// No description provided for @recoverPasswordTitle.
  ///
  /// In es, this message translates to:
  /// **'Recuperar contraseña'**
  String get recoverPasswordTitle;

  /// No description provided for @recoverPasswordUserLabel.
  ///
  /// In es, this message translates to:
  /// **'Usuario'**
  String get recoverPasswordUserLabel;

  /// No description provided for @recoverPasswordUserHint.
  ///
  /// In es, this message translates to:
  /// **'Ingresa tu nombre de usuario'**
  String get recoverPasswordUserHint;

  /// No description provided for @recoverPasswordCancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get recoverPasswordCancel;

  /// No description provided for @recoverPasswordSend.
  ///
  /// In es, this message translates to:
  /// **'Enviar'**
  String get recoverPasswordSend;

  /// No description provided for @registerTitle.
  ///
  /// In es, this message translates to:
  /// **'Registrarse'**
  String get registerTitle;

  /// No description provided for @registerSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Completa tus datos para registrarte'**
  String get registerSubtitle;

  /// No description provided for @registerNameLabel.
  ///
  /// In es, this message translates to:
  /// **'Nombre'**
  String get registerNameLabel;

  /// No description provided for @registerPasswordLabel.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get registerPasswordLabel;

  /// No description provided for @registerConfirmPasswordLabel.
  ///
  /// In es, this message translates to:
  /// **'Confirmar contraseña'**
  String get registerConfirmPasswordLabel;

  /// No description provided for @registerTreatmentLabel.
  ///
  /// In es, this message translates to:
  /// **'Tratamiento'**
  String get registerTreatmentLabel;

  /// No description provided for @registerTreatmentSr.
  ///
  /// In es, this message translates to:
  /// **'Sr.'**
  String get registerTreatmentSr;

  /// No description provided for @registerTreatmentSra.
  ///
  /// In es, this message translates to:
  /// **'Sra.'**
  String get registerTreatmentSra;

  /// No description provided for @registerTreatmentOtro.
  ///
  /// In es, this message translates to:
  /// **'Otro'**
  String get registerTreatmentOtro;

  /// No description provided for @registerAgeLabel.
  ///
  /// In es, this message translates to:
  /// **'Edad'**
  String get registerAgeLabel;

  /// No description provided for @registerBirthPlaceLabel.
  ///
  /// In es, this message translates to:
  /// **'Lugar de nacimiento'**
  String get registerBirthPlaceLabel;

  /// No description provided for @registerEmailLabel.
  ///
  /// In es, this message translates to:
  /// **'Correo electrónico'**
  String get registerEmailLabel;

  /// No description provided for @registerPhoneLabel.
  ///
  /// In es, this message translates to:
  /// **'Teléfono'**
  String get registerPhoneLabel;

  /// No description provided for @registerImageButton.
  ///
  /// In es, this message translates to:
  /// **'Seleccionar imagen'**
  String get registerImageButton;

  /// No description provided for @registerTermsText.
  ///
  /// In es, this message translates to:
  /// **'Acepto los términos y condiciones'**
  String get registerTermsText;

  /// No description provided for @registerMustAcceptTerms.
  ///
  /// In es, this message translates to:
  /// **'Debes aceptar los términos y condiciones'**
  String get registerMustAcceptTerms;

  /// No description provided for @registerCancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get registerCancel;

  /// No description provided for @registerSuccess.
  ///
  /// In es, this message translates to:
  /// **'Usuario registrado correctamente'**
  String get registerSuccess;

  /// No description provided for @homeTab.
  ///
  /// In es, this message translates to:
  /// **'Home'**
  String get homeTab;

  /// No description provided for @ordersTab.
  ///
  /// In es, this message translates to:
  /// **'Pedidos'**
  String get ordersTab;

  /// No description provided for @meTab.
  ///
  /// In es, this message translates to:
  /// **'Yo'**
  String get meTab;

  /// No description provided for @contactTab.
  ///
  /// In es, this message translates to:
  /// **'Contacto'**
  String get contactTab;

  /// No description provided for @homeTitle.
  ///
  /// In es, this message translates to:
  /// **'Home'**
  String get homeTitle;

  /// No description provided for @homeWelcomePrefix.
  ///
  /// In es, this message translates to:
  /// **'Bienvenido,'**
  String get homeWelcomePrefix;

  /// No description provided for @homeEmpty.
  ///
  /// In es, this message translates to:
  /// **'Página de compras'**
  String get homeEmpty;

  /// No description provided for @ordersTitle.
  ///
  /// In es, this message translates to:
  /// **'Mis pedidos'**
  String get ordersTitle;

  /// No description provided for @ordersEmpty.
  ///
  /// In es, this message translates to:
  /// **'Todavía no hay pedidos registrados.'**
  String get ordersEmpty;

  /// No description provided for @profileTitle.
  ///
  /// In es, this message translates to:
  /// **'Mi perfil'**
  String get profileTitle;

  /// No description provided for @profileEditButton.
  ///
  /// In es, this message translates to:
  /// **'Editar perfil'**
  String get profileEditButton;

  /// No description provided for @contactTitle.
  ///
  /// In es, this message translates to:
  /// **'Contacto'**
  String get contactTitle;

  /// No description provided for @contactIntro.
  ///
  /// In es, this message translates to:
  /// **'Si tienes alguna duda o incidencia, rellena el formulario:'**
  String get contactIntro;

  /// No description provided for @contactNameLabel.
  ///
  /// In es, this message translates to:
  /// **'Nombre'**
  String get contactNameLabel;

  /// No description provided for @contactEmailLabel.
  ///
  /// In es, this message translates to:
  /// **'Correo electrónico'**
  String get contactEmailLabel;

  /// No description provided for @contactMessageLabel.
  ///
  /// In es, this message translates to:
  /// **'Mensaje'**
  String get contactMessageLabel;

  /// No description provided for @contactSendButton.
  ///
  /// In es, this message translates to:
  /// **'Enviar'**
  String get contactSendButton;

  /// No description provided for @contactSentSnackbar.
  ///
  /// In es, this message translates to:
  /// **'Mensaje enviado (simulado)'**
  String get contactSentSnackbar;

  /// No description provided for @adminPanelTitle.
  ///
  /// In es, this message translates to:
  /// **'Panel administrador'**
  String get adminPanelTitle;

  /// No description provided for @adminInfoTitle.
  ///
  /// In es, this message translates to:
  /// **'Información del administrador'**
  String get adminInfoTitle;

  /// No description provided for @adminOptionsTitle.
  ///
  /// In es, this message translates to:
  /// **'Opciones del administrador (pendientes de implementar)'**
  String get adminOptionsTitle;

  /// No description provided for @adminUsersOption.
  ///
  /// In es, this message translates to:
  /// **'Gestión de usuarios'**
  String get adminUsersOption;

  /// No description provided for @adminProductsOption.
  ///
  /// In es, this message translates to:
  /// **'Gestión de productos'**
  String get adminProductsOption;

  /// No description provided for @adminOrdersOption.
  ///
  /// In es, this message translates to:
  /// **'Gestión de pedidos'**
  String get adminOrdersOption;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
