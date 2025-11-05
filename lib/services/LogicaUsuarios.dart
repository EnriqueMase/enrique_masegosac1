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
    _garantizarAdmin();
  }

  void _garantizarAdmin() {
    // Asegurar que admin existe
    if (!_usuarios.any((u) => u.nombre == 'admin')) {
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
  }

  void registrarUsuario(User usuario) {
    // Asegurar admin antes de cada operación
    _garantizarAdmin();

    // No permitir duplicados
    if (_usuarios.any((u) => u.nombre == usuario.nombre)) return;
    _usuarios.add(usuario);
  }

  // Valida credenciales y retorna el usuario si son correctas
  User? validarCredenciales(String nombre, String contrasena) {
    // Asegurar admin antes de cada operación
    _garantizarAdmin();

    print("=== VALIDANDO LOGIN ===");
    print("Buscando: Nombre=$nombre, Contraseña=$contrasena");

    final usuario = buscarUsuarioPorNombre(nombre);
    if (usuario != null && usuario.contrasena == contrasena) {
      print("¡COINCIDENCIA ENCONTRADA!");
      return usuario;
    }

    print("NO SE ENCONTRÓ COINCIDENCIA");
    return null;
  }

  List<User> get usuarios => _usuarios;

  static User? usuarioActual;
}
