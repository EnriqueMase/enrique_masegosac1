// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Mi Aplicación';

  @override
  String get login => 'Iniciar sesión';

  @override
  String get loginTitle => 'Inicio de sesión';

  @override
  String get username => 'Usuario';

  @override
  String get password => 'Contraseña';

  @override
  String get forgotPassword => '¿Has olvidado tu contraseña?';

  @override
  String get signIn => 'Iniciar sesión';

  @override
  String get signInWithGoogle => 'Iniciar sesión con Google';

  @override
  String get noAccount => '¿No tienes cuenta?';

  @override
  String get register => 'Regístrate';

  @override
  String get registerTitle => 'Registrarse';

  @override
  String get recoverPassword => 'Recuperar contraseña';

  @override
  String get recoverPasswordTitle => 'Recuperar Contraseña';

  @override
  String get send => 'Enviar';

  @override
  String get cancel => 'Cancelar';

  @override
  String userNotFound(Object username) {
    return 'Usuario \"$username\" no encontrado';
  }

  @override
  String userAndPassword(Object password, Object username) {
    return 'Usuario: $username\nContraseña: $password';
  }

  @override
  String get gender => 'Género';

  @override
  String get mr => 'Sr';

  @override
  String get mrs => 'Sra';

  @override
  String get other => 'Otro';

  @override
  String get age => 'Edad';

  @override
  String get birthPlace => 'Lugar de nacimiento';

  @override
  String get email => 'Email';

  @override
  String get phone => 'Teléfono';

  @override
  String get selectImage => 'Seleccionar imagen';

  @override
  String get registrationCompleted => 'Registro completado';

  @override
  String userExists(Object username) {
    return 'El usuario \"$username\" ya existe';
  }

  @override
  String get name => 'Nombre';

  @override
  String get description => 'Descripción';

  @override
  String get price => 'Precio';

  @override
  String get stock => 'Stock';

  @override
  String get imagePath => 'Ruta imagen (asset)';

  @override
  String get requiredField => 'Obligatorio';

  @override
  String get confirm => 'Confirmar';

  @override
  String get edit => 'Editar';

  @override
  String get delete => 'Eliminar';

  @override
  String get block => 'Bloquear';

  @override
  String get unblock => 'Desbloquear';

  @override
  String get active => 'Activo';

  @override
  String get blocked => 'Bloqueado';

  @override
  String get save => 'Guardar';

  @override
  String get create => 'Crear';

  @override
  String get add => 'Añadir';

  @override
  String get adminPanel => 'Panel de administración';

  @override
  String get userManagement => 'Gestión de usuarios';

  @override
  String get productManagement => 'Gestión de productos';

  @override
  String get orderManagement => 'Gestión de pedidos';

  @override
  String adminWelcome(Object username) {
    return 'Administrador $username';
  }

  @override
  String get createUser => 'Crear usuario';

  @override
  String editUser(Object username) {
    return 'Editar usuario: $username';
  }

  @override
  String get isAdmin => 'Es administrador';

  @override
  String get userName => 'Nombre de usuario';

  @override
  String get noUsersToManage => 'No hay usuarios que gestionar';

  @override
  String get status => 'Estado';

  @override
  String get createProduct => 'Crear producto';

  @override
  String editProduct(Object productName) {
    return 'Editar producto: $productName';
  }

  @override
  String get productId => 'ID producto';

  @override
  String get noProducts => 'No hay productos';

  @override
  String get order => 'Pedido';

  @override
  String get orders => 'Pedidos';

  @override
  String get myOrders => 'Mis pedidos';

  @override
  String orderId(Object id) {
    return 'Pedido $id';
  }

  @override
  String get date => 'Fecha';

  @override
  String get total => 'Total';

  @override
  String get ordered => 'Pedido';

  @override
  String get inProduction => 'En Producción';

  @override
  String get inDelivery => 'En Reparto';

  @override
  String get delivered => 'Entregado';

  @override
  String get user => 'Usuario';

  @override
  String get quantity => 'Cantidad';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get noOrders => 'No hay pedidos';

  @override
  String get noOrdersYet => 'No tienes ningún pedido aún';

  @override
  String get noRegisteredOrders => 'No hay pedidos registrados';

  @override
  String get welcome => 'Bienvenido';

  @override
  String welcomeUser(Object username) {
    return 'Bienvenido $username';
  }

  @override
  String get makePurchase => 'Realizar compra';

  @override
  String get confirmPurchase => 'Confirmar compra';

  @override
  String get confirmPurchaseQuestion =>
      '¿Estás seguro de que quieres realizar la compra?';

  @override
  String get purchaseSuccess => 'Compra realizada con éxito';

  @override
  String get purchaseError => 'Error al realizar la compra';

  @override
  String get insufficientStock => 'Stock insuficiente';

  @override
  String get contact => 'Contacto';

  @override
  String get message => 'Mensaje';

  @override
  String get sendMessage => 'Enviar';

  @override
  String get messageSent => 'Mensaje enviado (simulado)';

  @override
  String get myProfile => 'Mi perfil';
}
