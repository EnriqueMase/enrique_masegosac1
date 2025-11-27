import 'package:enrique_masegosac1/models/usuarios.dart';
import 'package:enrique_masegosac1/services/Logica_Usuarios.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class controladorUsuario {
  static String? nombre;
  static String? email;
  static String? foto;

  /// Login unificado: web usa popup y móvil usa GoogleSignIn.
  static Future<UserCredential?> signInWithGoogle() async {
    if (kIsWeb) {
      return signInWithGoogleWeb();
    }
    return signInWithGoogleMobile();
  }

  /// Login con Google en web usando FirebaseAuth y guarda la sesion local.
  static Future<UserCredential?> signInWithGoogleWeb() async {
    try {
      final provider = GoogleAuthProvider();
      provider.addScope('email');
      provider.addScope('profile');

      final userCredential = await FirebaseAuth.instance.signInWithPopup(
        provider,
      );

      final user = userCredential.user;
      _setLocalUser(user);
      return userCredential;
    } catch (e) {
      print('Error durante el inicio de sesion con Google (web): $e');
      return null;
    }
  }

  /// Login en Android/iOS usando GoogleSignIn + FirebaseAuth.
  static Future<UserCredential?> signInWithGoogleMobile() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null; // cancelado

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      _setLocalUser(userCredential.user);
      return userCredential;
    } catch (e) {
      print('Error durante el inicio de sesion con Google (mobile): $e');
      return null;
    }
  }

  /// Normaliza y registra/selecciona el usuario en memoria.
  static void _setLocalUser(User? user) {
    if (user == null) return;

    nombre = user.displayName ?? user.email ?? 'Usuario Google';
    email = user.email;
    foto = user.photoURL;

    final logicaUsuarios = LogicaUsuarios();
    final resolvedName = (nombre?.trim().isNotEmpty ?? false)
        ? nombre!.trim()
        : (email?.split('@').first ?? 'usuario_google');
    final resolvedEmail = email ?? '';
    final resolvedPhone = user.phoneNumber ?? '';

    Usuarios? usuarioExistente =
        logicaUsuarios.buscarUsuarioPorNombre(resolvedName);

    if (usuarioExistente == null && resolvedEmail.isNotEmpty) {
      for (final u in logicaUsuarios.usuarios) {
        if (u.email.toLowerCase() == resolvedEmail.toLowerCase()) {
          usuarioExistente = u;
          break;
        }
      }
    }

    if (usuarioExistente != null) {
      logicaUsuarios.setUsuarioActual(usuarioExistente);
    } else {
      final nuevoUsuario = Usuarios(
        nombre: resolvedName,
        contrasena: 'google_auth',
        email: resolvedEmail,
        telefono: resolvedPhone,
      );
      logicaUsuarios.registrarUsuario(nuevoUsuario);
      logicaUsuarios.setUsuarioActual(nuevoUsuario);
    }
  }
}
