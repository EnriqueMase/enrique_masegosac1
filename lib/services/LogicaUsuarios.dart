import 'package:enrique_masegosac1/models/user.dart';

class LogicaUsuarios {
  static final LogicaUsuarios _instancia = LogicaUsuarios._internal();
  final List<User> _usuarios = [];
  static User? _usuarioActual;

  User? obtenerUsuarioPorNombre(String nombre) {
    // Verifica que la lista de usuarios no esté vacía
    if (usuarios.isEmpty) {
      print("La lista de usuarios está vacía");
      return null;
    }

    // Busca el usuario
    for (var user in usuarios) {
      print("Comparando: ${user.nombre} con $nombre");
      if (user.nombre.toLowerCase() == nombre.toLowerCase()) {
        return user;
      }
    }

    print("Usuario $nombre no encontrado en la lista");
    return null;
  }

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
  // quiero añadir un usuario por defecto user con contraseña user si no existe

  LogicaUsuarios._internal() {
    _garantizarAdmin();
  }

  void _garantizarAdmin() {
    // Asegurar que admin existe
    if (buscarUsuarioPorNombre('admin') == null) {
      _usuarios.add(
        User(
          nombre: 'admin',
          contrasena: 'admin',
          tratamiento: 'Sr',
          edad: '20',
          lugarnacimiento: 'zaragoza',
        ),
      );
      _usuarios.add(
        User(
          nombre: 'Enrique',
          contrasena: 'Enrique',
          tratamiento: 'Sr',
          edad: '20',
          lugarnacimiento: 'zaragoza',
        ),
      );
      _usuarios.add(
        User(
          nombre: 'Ruben',
          contrasena: 'Ruben',
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
