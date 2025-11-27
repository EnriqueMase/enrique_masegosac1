// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'My App';

  @override
  String get login => 'Login';

  @override
  String get loginTitle => 'Sign in';

  @override
  String get username => 'Username';

  @override
  String get password => 'Password';

  @override
  String get forgotPassword => 'Forgot your password?';

  @override
  String get signIn => 'Sign in';

  @override
  String get signInWithGoogle => 'Sign in with Google';

  @override
  String get noAccount => 'Don\'t have an account?';

  @override
  String get register => 'Register';

  @override
  String get registerTitle => 'Register';

  @override
  String get recoverPassword => 'Recover password';

  @override
  String get recoverPasswordTitle => 'Recover Password';

  @override
  String get send => 'Send';

  @override
  String get cancel => 'Cancel';

  @override
  String userNotFound(Object username) {
    return 'User $username not found';
  }

  @override
  String userAndPassword(Object password, Object username) {
    return 'User: $username\nPassword: $password';
  }

  @override
  String userExists(Object username) {
    return 'User $username already exists';
  }

  @override
  String get menu => 'Menu';

  @override
  String get settings => 'Settings';

  @override
  String get logout => 'Logout';

  @override
  String get exitApp => 'Exit app';

  @override
  String get exitAppTitle => 'Exit application';

  @override
  String get exitAppConfirm => 'Are you sure you want to exit?';

  @override
  String get exit => 'Exit';

  @override
  String get language => 'Language';

  @override
  String get spanish => 'Spanish';

  @override
  String get english => 'English';

  @override
  String get gender => 'Gender';

  @override
  String get mr => 'Mr';

  @override
  String get mrs => 'Mrs';

  @override
  String get other => 'Other';

  @override
  String get age => 'Age';

  @override
  String get birthPlace => 'Place of birth';

  @override
  String get email => 'Email';

  @override
  String get phone => 'Phone';

  @override
  String get selectImage => 'Select image';

  @override
  String get registrationCompleted => 'Registration completed';

  @override
  String get addImage => 'Add image';

  @override
  String get uploadImage => 'Upload image';

  @override
  String get takePhoto => 'Camera';

  @override
  String get name => 'Name';

  @override
  String get description => 'Description';

  @override
  String get price => 'Price';

  @override
  String get stock => 'Stock';

  @override
  String get imagePath => 'Image path (asset)';

  @override
  String get requiredField => 'Required';

  @override
  String get confirm => 'Confirm';

  @override
  String get confirmPassword => 'Repeat password';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get block => 'Block';

  @override
  String get unblock => 'Unblock';

  @override
  String get active => 'Active';

  @override
  String get blocked => 'Blocked';

  @override
  String get save => 'Save';

  @override
  String get create => 'Create';

  @override
  String get add => 'Add';

  @override
  String get enterYourName => 'Enter your name';

  @override
  String get enterAMessage => 'Enter a message';

  @override
  String get termsAndConditionsLabel => 'Accept terms and conditions';

  @override
  String get mustAcceptTerms => 'You must accept the terms and conditions';

  @override
  String get store => 'Store';

  @override
  String get home => 'Home';

  @override
  String get me => 'Me';

  @override
  String get adminPanel => 'Administration Panel';

  @override
  String get userManagement => 'User Management';

  @override
  String get productManagement => 'Product Management';

  @override
  String get orderManagement => 'Order Management';

  @override
  String adminWelcome(Object username) {
    return 'Administrator $username';
  }

  @override
  String get createUser => 'Create user';

  @override
  String editUser(Object username) {
    return 'Edit user: $username';
  }

  @override
  String get isAdmin => 'Is administrator';

  @override
  String get userName => 'Username';

  @override
  String get noUsersToManage => 'No users to manage';

  @override
  String get status => 'Status';

  @override
  String get createProduct => 'Create product';

  @override
  String editProduct(Object productName) {
    return 'Edit product: $productName';
  }

  @override
  String get productId => 'Product ID';

  @override
  String get noProducts => 'No products';

  @override
  String get order => 'Order';

  @override
  String get orders => 'Orders';

  @override
  String get myOrders => 'My orders';

  @override
  String orderId(Object id) {
    return 'Order $id';
  }

  @override
  String get date => 'Date';

  @override
  String get total => 'Total';

  @override
  String get ordered => 'Ordered';

  @override
  String get inProduction => 'In Production';

  @override
  String get inDelivery => 'In Delivery';

  @override
  String get delivered => 'Delivered';

  @override
  String get user => 'User';

  @override
  String get quantity => 'Quantity';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get noOrders => 'No orders';

  @override
  String get noOrdersYet => 'You don\'t have any orders yet';

  @override
  String get noRegisteredOrders => 'No registered orders';

  @override
  String get welcome => 'Welcome';

  @override
  String welcomeUser(Object username) {
    return 'Welcome $username';
  }

  @override
  String get makePurchase => 'Make purchase';

  @override
  String get confirmPurchase => 'Confirm purchase';

  @override
  String get confirmPurchaseQuestion =>
      'Are you sure you want to make the purchase?';

  @override
  String get purchaseSuccess => 'Purchase completed successfully';

  @override
  String get purchaseError => 'Error making purchase';

  @override
  String get insufficientStock => 'Insufficient stock';

  @override
  String get contact => 'Contact';

  @override
  String get message => 'Message';

  @override
  String get sendMessage => 'Send';

  @override
  String get messageSent => 'Message sent (simulated)';

  @override
  String get companyInfoTitle => 'Company info';

  @override
  String get companyNameLabel => 'Company';

  @override
  String get companyAddressLabel => 'Address';

  @override
  String get myProfile => 'My Profile';
}
