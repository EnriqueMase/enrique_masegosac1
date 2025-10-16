import 'package:enrique_masegosac1/models/user.dart';

class LogicaUsuarios {
  static final LogicaUsuarios _instancia = LogicaUsuarios._internal();
  final List<User> _usuarios = [];
  static User? _usuarioActual;

  factory LogicaUsuarios() {
    return _instancia;
  }
  void setUsuarioActual(User usuario) {
    _usuarioActual = usuario;
  }

  User? getUsuarioActual() {
    return _usuarioActual;
  }

  void cerrarSesion() {
    _usuarioActual = null;
  }

  void imprimirUsuarios() {
    print("=== LISTA DE USUARIOS REGISTRADOS ===");
    for (var usuario in _usuarios) {
      print("Nombre: ${usuario.nombre}, Contraseña: ${usuario.contrasena}");
    }
    print("Total de usuarios: ${_usuarios.length}");
    print("=====================================");
  }

  User? buscarUsuarioPorNombre(String nombre) {
    for (var usuario in _usuarios) {
      if (usuario.nombre == nombre) {
        return usuario;
      }
    }
    return null;
  }

  LogicaUsuarios._internal() {
    // Añadir usuario admin por defecto
    _usuarios.add(
      User(
        nombre: 'admin',
        contrasena: 'admin',
        tratamiento: 'Sr',
        edad: '20',
        lugarnacimiento: 'zaragoza',
      ),
    );
  }

  void registrarUsuario(User usuario) {
    _usuarios.add(usuario);
  }

  // Retorna true si las credenciales son válidas, false en caso contrario
  bool validarLogin(String nombre, String contrasena) {
    print("=== VALIDANDO LOGIN ===");
    print("Buscando: Nombre=$nombre, Contraseña=$contrasena");

    for (var usuario in _usuarios) {
      print("Comparando con: ${usuario.nombre}, ${usuario.contrasena}");
      if (usuario.nombre == nombre && usuario.contrasena == contrasena) {
        print("¡COINCIDENCIA ENCONTRADA!");
        return true;
      }
    }
    print("NO SE ENCONTRÓ COINCIDENCIA");
    return false;
  }

  List<User> get usuarios => _usuarios;

  static User? usuarioActual;
}
