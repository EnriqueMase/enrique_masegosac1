import 'package:enrique_masegosac1/models/user.dart';

class LogicaUsuarios {
  static final LogicaUsuarios _instancia = LogicaUsuarios._internal();

  factory LogicaUsuarios() => _instancia;

  final List<User> _usuarios = [];
  User? _usuarioActual;

  LogicaUsuarios._internal() {
    _initUsuariosPorDefecto();
  }

  void _initUsuariosPorDefecto() {
    if (_usuarios.isNotEmpty) return;

    _usuarios.add(
      User(
        nombre: 'admin',
        contrasena: 'admin',
        tratamiento: 'Sr',
        edad: '30',
        lugarnacimiento: 'Zaragoza',
        isAdmin: true,
        email: 'admin@example.com',
        telefono: '60000',
      ),
    );

    _usuarios.add(
      User(
        nombre: 'Enrique',
        contrasena: 'Enrique',
        tratamiento: 'Sr',
        edad: '20',
        lugarnacimiento: 'Zaragoza',
        email: 'enrique@example.com',
        telefono: '60001',
      ),
    );

    _usuarios.add(
      User(
        nombre: 'Ruben',
        contrasena: 'Ruben',
        tratamiento: 'Sr',
        edad: '20',
        lugarnacimiento: 'Zaragoza',
        email: 'ruben@example.com',
        telefono: '60002',
      ),
    );

    // Usuario genérico user/user
    if (buscarUsuarioPorNombre('user') == null) {
      _usuarios.add(
        User(
          nombre: 'user',
          contrasena: 'user',
          tratamiento: 'Sr',
          edad: '18',
          lugarnacimiento: 'Zaragoza',
          email: 'user@example.com',
          telefono: '60003',
        ),
      );
    }
  }

  // Gestión de usuario actual

  User? getUsuarioActual() => _usuarioActual;

  void setUsuarioActual(User usuario) {
    _usuarioActual = usuario;
  }

  void cerrarSesion() {
    _usuarioActual = null;
  }

  // Gestión de usuarios

  List<User> get usuarios => List.unmodifiable(_usuarios);

  User? buscarUsuarioPorNombre(String nombre) {
    for (final usuario in _usuarios) {
      if (usuario.nombre.toLowerCase() == nombre.toLowerCase()) {
        return usuario;
      }
    }
    return null;
  }

  User? obtenerUsuarioPorNombre(String nombre) {
    return buscarUsuarioPorNombre(nombre);
  }

  void registrarUsuario(User user) {
    if (_usuarios.any(
      (u) => u.nombre.toLowerCase() == user.nombre.toLowerCase(),
    )) {
      // Ya existe, no lo añadimos
      return;
    }
    _usuarios.add(user);
  }

  User? validarCredenciales(String nombre, String contrasena) {
    final user = buscarUsuarioPorNombre(nombre.trim());
    if (user != null && user.contrasena == contrasena.trim()) {
      return user;
    }
    return null;
  }

  // Solo para debug si quieres
  void imprimirUsuarios() {
    for (final u in _usuarios) {
      print('Usuario: ${u.nombre} / pass: ${u.contrasena}');
    }
  }
}
