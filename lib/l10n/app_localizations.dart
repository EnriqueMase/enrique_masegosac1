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
    Locale('es')
  ];

  /// No description provided for @appTitle.
  ///
  /// In es, this message translates to:
  /// **'Mi Aplicación'**
  String get appTitle;

  /// No description provided for @login.
  ///
  /// In es, this message translates to:
  /// **'Iniciar sesión'**
  String get login;

  /// No description provided for @loginTitle.
  ///
  /// In es, this message translates to:
  /// **'Inicio de sesión'**
  String get loginTitle;

  /// No description provided for @username.
  ///
  /// In es, this message translates to:
  /// **'Usuario'**
  String get username;

  /// No description provided for @password.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get password;

  /// No description provided for @forgotPassword.
  ///
  /// In es, this message translates to:
  /// **'¿Has olvidado tu contraseña?'**
  String get forgotPassword;

  /// No description provided for @signIn.
  ///
  /// In es, this message translates to:
  /// **'Iniciar sesión'**
  String get signIn;

  /// No description provided for @signInWithGoogle.
  ///
  /// In es, this message translates to:
  /// **'Iniciar sesión con Google'**
  String get signInWithGoogle;

  /// No description provided for @noAccount.
  ///
  /// In es, this message translates to:
  /// **'¿No tienes cuenta?'**
  String get noAccount;

  /// No description provided for @register.
  ///
  /// In es, this message translates to:
  /// **'Regístrate'**
  String get register;

  /// No description provided for @registerTitle.
  ///
  /// In es, this message translates to:
  /// **'Registrarse'**
  String get registerTitle;

  /// No description provided for @recoverPassword.
  ///
  /// In es, this message translates to:
  /// **'Recuperar contraseña'**
  String get recoverPassword;

  /// No description provided for @recoverPasswordTitle.
  ///
  /// In es, this message translates to:
  /// **'Recuperar Contraseña'**
  String get recoverPasswordTitle;

  /// No description provided for @send.
  ///
  /// In es, this message translates to:
  /// **'Enviar'**
  String get send;

  /// No description provided for @cancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// No description provided for @userNotFound.
  ///
  /// In es, this message translates to:
  /// **'Usuario {username} no encontrado'**
  String userNotFound(Object username);

  /// No description provided for @userAndPassword.
  ///
  /// In es, this message translates to:
  /// **'Usuario: {username}\nContraseña: {password}'**
  String userAndPassword(Object password, Object username);

  /// No description provided for @userExists.
  ///
  /// In es, this message translates to:
  /// **'El usuario {username} ya existe'**
  String userExists(Object username);

  /// No description provided for @menu.
  ///
  /// In es, this message translates to:
  /// **'Menú'**
  String get menu;

  /// No description provided for @settings.
  ///
  /// In es, this message translates to:
  /// **'Ajustes'**
  String get settings;

  /// No description provided for @logout.
  ///
  /// In es, this message translates to:
  /// **'Cerrar sesión'**
  String get logout;

  /// No description provided for @exitApp.
  ///
  /// In es, this message translates to:
  /// **'Salir de la aplicación'**
  String get exitApp;

  /// No description provided for @exitAppTitle.
  ///
  /// In es, this message translates to:
  /// **'Salir de la aplicación'**
  String get exitAppTitle;

  /// No description provided for @exitAppConfirm.
  ///
  /// In es, this message translates to:
  /// **'¿Estás seguro de que quieres salir?'**
  String get exitAppConfirm;

  /// No description provided for @exit.
  ///
  /// In es, this message translates to:
  /// **'Salir'**
  String get exit;

  /// No description provided for @language.
  ///
  /// In es, this message translates to:
  /// **'Idioma'**
  String get language;

  /// No description provided for @spanish.
  ///
  /// In es, this message translates to:
  /// **'Español'**
  String get spanish;

  /// No description provided for @english.
  ///
  /// In es, this message translates to:
  /// **'Inglés'**
  String get english;

  /// No description provided for @gender.
  ///
  /// In es, this message translates to:
  /// **'Género'**
  String get gender;

  /// No description provided for @mr.
  ///
  /// In es, this message translates to:
  /// **'Sr'**
  String get mr;

  /// No description provided for @mrs.
  ///
  /// In es, this message translates to:
  /// **'Sra'**
  String get mrs;

  /// No description provided for @other.
  ///
  /// In es, this message translates to:
  /// **'Otro'**
  String get other;

  /// No description provided for @age.
  ///
  /// In es, this message translates to:
  /// **'Edad'**
  String get age;

  /// No description provided for @birthPlace.
  ///
  /// In es, this message translates to:
  /// **'Lugar de nacimiento'**
  String get birthPlace;

  /// No description provided for @email.
  ///
  /// In es, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @phone.
  ///
  /// In es, this message translates to:
  /// **'Teléfono'**
  String get phone;

  /// No description provided for @selectImage.
  ///
  /// In es, this message translates to:
  /// **'Seleccionar imagen'**
  String get selectImage;

  /// No description provided for @registrationCompleted.
  ///
  /// In es, this message translates to:
  /// **'Registro completado'**
  String get registrationCompleted;

  /// No description provided for @name.
  ///
  /// In es, this message translates to:
  /// **'Nombre'**
  String get name;

  /// No description provided for @description.
  ///
  /// In es, this message translates to:
  /// **'Descripción'**
  String get description;

  /// No description provided for @price.
  ///
  /// In es, this message translates to:
  /// **'Precio'**
  String get price;

  /// No description provided for @stock.
  ///
  /// In es, this message translates to:
  /// **'Stock'**
  String get stock;

  /// No description provided for @imagePath.
  ///
  /// In es, this message translates to:
  /// **'Ruta imagen (asset)'**
  String get imagePath;

  /// No description provided for @requiredField.
  ///
  /// In es, this message translates to:
  /// **'Obligatorio'**
  String get requiredField;

  /// No description provided for @confirm.
  ///
  /// In es, this message translates to:
  /// **'Confirmar'**
  String get confirm;

  /// No description provided for @edit.
  ///
  /// In es, this message translates to:
  /// **'Editar'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In es, this message translates to:
  /// **'Eliminar'**
  String get delete;

  /// No description provided for @block.
  ///
  /// In es, this message translates to:
  /// **'Bloquear'**
  String get block;

  /// No description provided for @unblock.
  ///
  /// In es, this message translates to:
  /// **'Desbloquear'**
  String get unblock;

  /// No description provided for @active.
  ///
  /// In es, this message translates to:
  /// **'Activo'**
  String get active;

  /// No description provided for @blocked.
  ///
  /// In es, this message translates to:
  /// **'Bloqueado'**
  String get blocked;

  /// No description provided for @save.
  ///
  /// In es, this message translates to:
  /// **'Guardar'**
  String get save;

  /// No description provided for @create.
  ///
  /// In es, this message translates to:
  /// **'Crear'**
  String get create;

  /// No description provided for @add.
  ///
  /// In es, this message translates to:
  /// **'Añadir'**
  String get add;

  /// No description provided for @enterYourName.
  ///
  /// In es, this message translates to:
  /// **'Introduce tu nombre'**
  String get enterYourName;

  /// No description provided for @enterAMessage.
  ///
  /// In es, this message translates to:
  /// **'Introduce un mensaje'**
  String get enterAMessage;

  /// No description provided for @home.
  ///
  /// In es, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @me.
  ///
  /// In es, this message translates to:
  /// **'Yo'**
  String get me;

  /// No description provided for @adminPanel.
  ///
  /// In es, this message translates to:
  /// **'Panel de administración'**
  String get adminPanel;

  /// No description provided for @userManagement.
  ///
  /// In es, this message translates to:
  /// **'Gestión de usuarios'**
  String get userManagement;

  /// No description provided for @productManagement.
  ///
  /// In es, this message translates to:
  /// **'Gestión de productos'**
  String get productManagement;

  /// No description provided for @orderManagement.
  ///
  /// In es, this message translates to:
  /// **'Gestión de pedidos'**
  String get orderManagement;

  /// No description provided for @adminWelcome.
  ///
  /// In es, this message translates to:
  /// **'Administrador {username}'**
  String adminWelcome(Object username);

  /// No description provided for @createUser.
  ///
  /// In es, this message translates to:
  /// **'Crear usuario'**
  String get createUser;

  /// No description provided for @editUser.
  ///
  /// In es, this message translates to:
  /// **'Editar usuario: {username}'**
  String editUser(Object username);

  /// No description provided for @isAdmin.
  ///
  /// In es, this message translates to:
  /// **'Es administrador'**
  String get isAdmin;

  /// No description provided for @userName.
  ///
  /// In es, this message translates to:
  /// **'Nombre de usuario'**
  String get userName;

  /// No description provided for @noUsersToManage.
  ///
  /// In es, this message translates to:
  /// **'No hay usuarios que gestionar'**
  String get noUsersToManage;

  /// No description provided for @status.
  ///
  /// In es, this message translates to:
  /// **'Estado'**
  String get status;

  /// No description provided for @createProduct.
  ///
  /// In es, this message translates to:
  /// **'Crear producto'**
  String get createProduct;

  /// No description provided for @editProduct.
  ///
  /// In es, this message translates to:
  /// **'Editar producto: {productName}'**
  String editProduct(Object productName);

  /// No description provided for @productId.
  ///
  /// In es, this message translates to:
  /// **'ID producto'**
  String get productId;

  /// No description provided for @noProducts.
  ///
  /// In es, this message translates to:
  /// **'No hay productos'**
  String get noProducts;

  /// No description provided for @order.
  ///
  /// In es, this message translates to:
  /// **'Pedido'**
  String get order;

  /// No description provided for @orders.
  ///
  /// In es, this message translates to:
  /// **'Pedidos'**
  String get orders;

  /// No description provided for @myOrders.
  ///
  /// In es, this message translates to:
  /// **'Mis pedidos'**
  String get myOrders;

  /// No description provided for @orderId.
  ///
  /// In es, this message translates to:
  /// **'Pedido {id}'**
  String orderId(Object id);

  /// No description provided for @date.
  ///
  /// In es, this message translates to:
  /// **'Fecha'**
  String get date;

  /// No description provided for @total.
  ///
  /// In es, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @ordered.
  ///
  /// In es, this message translates to:
  /// **'Pedido'**
  String get ordered;

  /// No description provided for @inProduction.
  ///
  /// In es, this message translates to:
  /// **'En Producción'**
  String get inProduction;

  /// No description provided for @inDelivery.
  ///
  /// In es, this message translates to:
  /// **'En Reparto'**
  String get inDelivery;

  /// No description provided for @delivered.
  ///
  /// In es, this message translates to:
  /// **'Entregado'**
  String get delivered;

  /// No description provided for @user.
  ///
  /// In es, this message translates to:
  /// **'Usuario'**
  String get user;

  /// No description provided for @quantity.
  ///
  /// In es, this message translates to:
  /// **'Cantidad'**
  String get quantity;

  /// No description provided for @subtotal.
  ///
  /// In es, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// No description provided for @noOrders.
  ///
  /// In es, this message translates to:
  /// **'No hay pedidos'**
  String get noOrders;

  /// No description provided for @noOrdersYet.
  ///
  /// In es, this message translates to:
  /// **'No tienes ningún pedido aún'**
  String get noOrdersYet;

  /// No description provided for @noRegisteredOrders.
  ///
  /// In es, this message translates to:
  /// **'No hay pedidos registrados'**
  String get noRegisteredOrders;

  /// No description provided for @welcome.
  ///
  /// In es, this message translates to:
  /// **'Bienvenido'**
  String get welcome;

  /// No description provided for @welcomeUser.
  ///
  /// In es, this message translates to:
  /// **'Bienvenido {username}'**
  String welcomeUser(Object username);

  /// No description provided for @makePurchase.
  ///
  /// In es, this message translates to:
  /// **'Realizar compra'**
  String get makePurchase;

  /// No description provided for @confirmPurchase.
  ///
  /// In es, this message translates to:
  /// **'Confirmar compra'**
  String get confirmPurchase;

  /// No description provided for @confirmPurchaseQuestion.
  ///
  /// In es, this message translates to:
  /// **'¿Estás seguro de que quieres realizar la compra?'**
  String get confirmPurchaseQuestion;

  /// No description provided for @purchaseSuccess.
  ///
  /// In es, this message translates to:
  /// **'Compra realizada con éxito'**
  String get purchaseSuccess;

  /// No description provided for @purchaseError.
  ///
  /// In es, this message translates to:
  /// **'Error al realizar la compra'**
  String get purchaseError;

  /// No description provided for @insufficientStock.
  ///
  /// In es, this message translates to:
  /// **'Stock insuficiente'**
  String get insufficientStock;

  /// No description provided for @contact.
  ///
  /// In es, this message translates to:
  /// **'Contacto'**
  String get contact;

  /// No description provided for @message.
  ///
  /// In es, this message translates to:
  /// **'Mensaje'**
  String get message;

  /// No description provided for @sendMessage.
  ///
  /// In es, this message translates to:
  /// **'Enviar'**
  String get sendMessage;

  /// No description provided for @messageSent.
  ///
  /// In es, this message translates to:
  /// **'Mensaje enviado (simulado)'**
  String get messageSent;

  /// No description provided for @myProfile.
  ///
  /// In es, this message translates to:
  /// **'Mi perfil'**
  String get myProfile;
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
      'that was used.');
}
