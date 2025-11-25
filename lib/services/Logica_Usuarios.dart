import 'package:enrique_masegosac1/models/usuarios.dart';

class LogicaUsuarios {
  static final LogicaUsuarios _instancia = LogicaUsuarios._internal();

  factory LogicaUsuarios() => _instancia;

  final List<Usuarios> _usuarios = [];
  Usuarios? _usuarioActual;

  LogicaUsuarios._internal() {
    _initUsuariosPorDefecto();
  }

  void _initUsuariosPorDefecto() {
    if (_usuarios.isNotEmpty) return;

    _usuarios.add(
      Usuarios(
        nombre: 'admin',
        contrasena: 'admin',
        tratamiento: 'Sr',
        edad: '30',
        lugarnacimiento: 'Zaragoza',
        isAdmin: true,
        email: 'admin@example.com',
        telefono: '600000000',
      ),
    );

    _usuarios.add(
      Usuarios(
        nombre: 'Enrique',
        contrasena: 'Enrique',
        tratamiento: 'Sr',
        edad: '20',
        lugarnacimiento: 'Zaragoza',
        email: 'enrique@example.com',
        telefono: '600000001',
      ),
    );

    _usuarios.add(
      Usuarios(
        nombre: 'Ruben',
        contrasena: 'Ruben',
        tratamiento: 'Sr',
        edad: '20',
        lugarnacimiento: 'Zaragoza',
        email: 'ruben@example.com',
        telefono: '600000002',
      ),
    );

    if (buscarUsuarioPorNombre('user') == null) {
      _usuarios.add(
        Usuarios(
          nombre: 'user',
          contrasena: 'user',
          tratamiento: 'Sr',
          edad: '18',
          lugarnacimiento: 'Zaragoza',
          email: 'user@example.com',
          telefono: '600000003',
        ),
      );
    }
  }

  // ===== Usuario actual =====

  Usuarios? getUsuarioActual() => _usuarioActual;

  void setUsuarioActual(Usuarios usuario) {
    _usuarioActual = usuario;
  }

  void cerrarSesion() {
    _usuarioActual = null;
  }

  // ===== Usuarios =====

  List<Usuarios> get usuarios => List.unmodifiable(_usuarios);

  Usuarios? buscarUsuarioPorNombre(String nombre) {
    for (final u in _usuarios) {
      if (u.nombre.toLowerCase() == nombre.toLowerCase()) {
        return u;
      }
    }
    return null;
  }

  Usuarios? obtenerUsuarioPorNombre(String nombre) {
    return buscarUsuarioPorNombre(nombre);
  }

  void registrarUsuario(Usuarios user) {
    if (_usuarios.any(
      (u) => u.nombre.toLowerCase() == user.nombre.toLowerCase(),
    )) {
      return;
    }
    _usuarios.add(user);
  }

  /// Actualiza un usuario (busca por nombre original)
  void actualizarUsuario(String nombreOriginal, Usuarios datosNuevos) {
    for (int i = 0; i < _usuarios.length; i++) {
      if (_usuarios[i].nombre.toLowerCase() == nombreOriginal.toLowerCase()) {
        _usuarios[i] = datosNuevos;
        // Si es el usuario logueado, actualizamos referencia
        if (_usuarioActual?.nombre.toLowerCase() ==
            nombreOriginal.toLowerCase()) {
          _usuarioActual = datosNuevos;
        }
        return;
      }
    }
  }

  /// Elimina un usuario (irreversible)
  void eliminarUsuario(String nombre) {
    _usuarios.removeWhere(
      (u) => u.nombre.toLowerCase() == nombre.toLowerCase(),
    );
    if (_usuarioActual?.nombre.toLowerCase() == nombre.toLowerCase()) {
      _usuarioActual = null;
    }
  }

  /// Bloquear / desbloquear usuario
  void setBloqueado(String nombre, bool bloqueado) {
    final u = buscarUsuarioPorNombre(nombre);
    if (u != null) {
      final index = _usuarios.indexOf(u);
      _usuarios[index] = Usuarios(
        nombre: u.nombre,
        contrasena: u.contrasena,
        tratamiento: u.tratamiento,
        edad: u.edad,
        lugarnacimiento: u.lugarnacimiento,
        fotoPath: u.fotoPath,
        fotoBytes: u.fotoBytes,
        isAdmin: u.isAdmin,
        isBlocked: bloqueado,
        email: u.email,
        telefono: u.telefono,
      );

      if (_usuarioActual?.nombre == u.nombre) {
        _usuarioActual = _usuarios[index];
      }
    }
  }

  // ===== Login =====

  Usuarios? validarCredenciales(String nombre, String contrasena) {
    final user = buscarUsuarioPorNombre(nombre.trim());
    if (user != null &&
        user.contrasena == contrasena.trim() &&
        !user.isBlocked) {
      // si está bloqueado, no entra
      return user;
    }
    return null;
  }

  // ===== Listas para admin =====

  /// Lista de usuarios para gestión, excluyendo:
  /// - admin
  /// - el propio admin logueado
  List<Usuarios> getUsuariosGestionables() {
    final actual = _usuarioActual;
    return _usuarios.where((u) {
      if (u.nombre.toLowerCase() == 'admin') return false;
      if (actual != null &&
          u.nombre.toLowerCase() == actual.nombre.toLowerCase()) {
        return false;
      }
      return true;
    }).toList();
  }

  void imprimirUsuarios() {
    for (final u in _usuarios) {
      print(
        'Usuario: ${u.nombre} / pass: ${u.contrasena} / admin: ${u.isAdmin} / bloqueado: ${u.isBlocked}',
      );
    }
  }
}
