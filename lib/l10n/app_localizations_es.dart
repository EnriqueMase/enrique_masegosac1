// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'App de Lord Team';

  @override
  String get loginWelcome => 'Bienvenido a la App de Lord Team';

  @override
  String get loginUserLabel => 'Nombre de usuario';

  @override
  String get loginUserHint => 'Ingresa tu nombre de usuario';

  @override
  String get loginPasswordLabel => 'Contraseña';

  @override
  String get loginPasswordHint => 'Ingresa tu contraseña';

  @override
  String get loginButton => 'Iniciar sesión';

  @override
  String get registerButton => 'Registrarse';

  @override
  String get forgotPassword => '¿Has olvidado tu usuario o contraseña?';

  @override
  String get googleSignInButton => 'Iniciar sesión con Google';

  @override
  String get loginEmptyUserOrPassword =>
      'El nombre de usuario y la contraseña no pueden estar vacíos';

  @override
  String get loginUserNotFoundOrWrongPassword =>
      'Usuario no encontrado o contraseña incorrecta';

  @override
  String get loginUserNotFound => 'Usuario no encontrado';

  @override
  String get recoverPasswordTitle => 'Recuperar contraseña';

  @override
  String get recoverPasswordUserLabel => 'Usuario';

  @override
  String get recoverPasswordUserHint => 'Ingresa tu nombre de usuario';

  @override
  String get recoverPasswordCancel => 'Cancelar';

  @override
  String get recoverPasswordSend => 'Enviar';

  @override
  String get registerTitle => 'Registrarse';

  @override
  String get registerSubtitle => 'Completa tus datos para registrarte';

  @override
  String get registerNameLabel => 'Nombre';

  @override
  String get registerPasswordLabel => 'Contraseña';

  @override
  String get registerConfirmPasswordLabel => 'Confirmar contraseña';

  @override
  String get registerTreatmentLabel => 'Tratamiento';

  @override
  String get registerTreatmentSr => 'Sr.';

  @override
  String get registerTreatmentSra => 'Sra.';

  @override
  String get registerTreatmentOtro => 'Otro';

  @override
  String get registerAgeLabel => 'Edad';

  @override
  String get registerBirthPlaceLabel => 'Lugar de nacimiento';

  @override
  String get registerEmailLabel => 'Correo electrónico';

  @override
  String get registerPhoneLabel => 'Teléfono';

  @override
  String get registerImageButton => 'Seleccionar imagen';

  @override
  String get registerTermsText => 'Acepto los términos y condiciones';

  @override
  String get registerMustAcceptTerms =>
      'Debes aceptar los términos y condiciones';

  @override
  String get registerCancel => 'Cancelar';

  @override
  String get registerSuccess => 'Usuario registrado correctamente';

  @override
  String get homeTab => 'Home';

  @override
  String get ordersTab => 'Pedidos';

  @override
  String get meTab => 'Yo';

  @override
  String get contactTab => 'Contacto';

  @override
  String get homeTitle => 'Home';

  @override
  String get homeWelcomePrefix => 'Bienvenido,';

  @override
  String get homeEmpty => 'Página de compras';

  @override
  String get ordersTitle => 'Mis pedidos';

  @override
  String get ordersEmpty => 'Todavía no hay pedidos registrados.';

  @override
  String get profileTitle => 'Mi perfil';

  @override
  String get profileEditButton => 'Editar perfil';

  @override
  String get contactTitle => 'Contacto';

  @override
  String get contactIntro =>
      'Si tienes alguna duda o incidencia, rellena el formulario:';

  @override
  String get contactNameLabel => 'Nombre';

  @override
  String get contactEmailLabel => 'Correo electrónico';

  @override
  String get contactMessageLabel => 'Mensaje';

  @override
  String get contactSendButton => 'Enviar';

  @override
  String get contactSentSnackbar => 'Mensaje enviado (simulado)';

  @override
  String get adminPanelTitle => 'Panel administrador';

  @override
  String get adminInfoTitle => 'Información del administrador';

  @override
  String get adminOptionsTitle =>
      'Opciones del administrador (pendientes de implementar)';

  @override
  String get adminUsersOption => 'Gestión de usuarios';

  @override
  String get adminProductsOption => 'Gestión de productos';

  @override
  String get adminOrdersOption => 'Gestión de pedidos';
}
