// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Lord Team App';

  @override
  String get loginWelcome => 'Welcome to the Lord Team App';

  @override
  String get loginUserLabel => 'Username';

  @override
  String get loginUserHint => 'Enter your username';

  @override
  String get loginPasswordLabel => 'Password';

  @override
  String get loginPasswordHint => 'Enter your password';

  @override
  String get loginButton => 'Sign in';

  @override
  String get registerButton => 'Sign up';

  @override
  String get forgotPassword => 'Forgot your username or password?';

  @override
  String get googleSignInButton => 'Sign in with Google';

  @override
  String get loginEmptyUserOrPassword =>
      'Username and password cannot be empty';

  @override
  String get loginUserNotFoundOrWrongPassword =>
      'User not found or wrong password';

  @override
  String get loginUserNotFound => 'User not found';

  @override
  String get recoverPasswordTitle => 'Recover password';

  @override
  String get recoverPasswordUserLabel => 'User';

  @override
  String get recoverPasswordUserHint => 'Enter your username';

  @override
  String get recoverPasswordCancel => 'Cancel';

  @override
  String get recoverPasswordSend => 'Send';

  @override
  String get registerTitle => 'Sign up';

  @override
  String get registerSubtitle => 'Fill in your details to sign up';

  @override
  String get registerNameLabel => 'Name';

  @override
  String get registerPasswordLabel => 'Password';

  @override
  String get registerConfirmPasswordLabel => 'Confirm password';

  @override
  String get registerTreatmentLabel => 'Treatment';

  @override
  String get registerTreatmentSr => 'Mr.';

  @override
  String get registerTreatmentSra => 'Ms.';

  @override
  String get registerTreatmentOtro => 'Other';

  @override
  String get registerAgeLabel => 'Age';

  @override
  String get registerBirthPlaceLabel => 'Place of birth';

  @override
  String get registerEmailLabel => 'Email';

  @override
  String get registerPhoneLabel => 'Phone';

  @override
  String get registerImageButton => 'Select image';

  @override
  String get registerTermsText => 'I accept the terms and conditions';

  @override
  String get registerMustAcceptTerms =>
      'You must accept the terms and conditions';

  @override
  String get registerCancel => 'Cancel';

  @override
  String get registerSuccess => 'User successfully registered';

  @override
  String get homeTab => 'Home';

  @override
  String get ordersTab => 'Orders';

  @override
  String get meTab => 'Me';

  @override
  String get contactTab => 'Contact';

  @override
  String get homeTitle => 'Home';

  @override
  String get homeWelcomePrefix => 'Welcome,';

  @override
  String get homeEmpty => 'Shopping page';

  @override
  String get ordersTitle => 'My orders';

  @override
  String get ordersEmpty => 'You have no orders yet.';

  @override
  String get profileTitle => 'My profile';

  @override
  String get profileEditButton => 'Edit profile';

  @override
  String get contactTitle => 'Contact';

  @override
  String get contactIntro =>
      'If you have any questions or issues, fill in the form:';

  @override
  String get contactNameLabel => 'Name';

  @override
  String get contactEmailLabel => 'Email';

  @override
  String get contactMessageLabel => 'Message';

  @override
  String get contactSendButton => 'Send';

  @override
  String get contactSentSnackbar => 'Message sent (simulated)';

  @override
  String get adminPanelTitle => 'Admin panel';

  @override
  String get adminInfoTitle => 'Administrator information';

  @override
  String get adminOptionsTitle =>
      'Administrator options (pending implementation)';

  @override
  String get adminUsersOption => 'User management';

  @override
  String get adminProductsOption => 'Product management';

  @override
  String get adminOrdersOption => 'Order management';
}
