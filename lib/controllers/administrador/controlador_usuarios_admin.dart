import 'package:enrique_masegosac1/models/usuarios.dart';
import 'package:enrique_masegosac1/services/Logica_Usuarios.dart';

class ControladorUsuariosAdmin {
  final LogicaUsuarios _logicaUsuarios = LogicaUsuarios();

  List<Usuarios> getUsuariosGestionables() {
    return _logicaUsuarios.getUsuariosGestionables();
  }

  void bloquearUsuario(String nombre) {
    _logicaUsuarios.setBloqueado(nombre, true);
  }

  void desbloquearUsuario(String nombre) {
    _logicaUsuarios.setBloqueado(nombre, false);
  }

  void eliminarUsuario(String nombre) {
    _logicaUsuarios.eliminarUsuario(nombre);
  }

  void crearUsuario({
    required String nombre,
    required String contrasena,
    String? tratamiento,
    String? edad,
    String? lugar,
    String? email,
    String? telefono,
    bool isAdmin = false,
  }) {
    final nuevo = Usuarios(
      nombre: nombre,
      contrasena: contrasena,
      tratamiento: tratamiento,
      edad: edad,
      lugarnacimiento: lugar,
      email: email ?? '',
      telefono: telefono ?? '',
      isAdmin: isAdmin,
    );
    _logicaUsuarios.registrarUsuario(nuevo);
  }

  void editarUsuario({
    required String nombreOriginal,
    required Usuarios datosNuevos,
  }) {
    _logicaUsuarios.actualizarUsuario(nombreOriginal, datosNuevos);
  }

  void asignarAdmin(String nombre, bool esAdmin) {
    _logicaUsuarios.setAdmin(nombre, esAdmin);
  }
}
