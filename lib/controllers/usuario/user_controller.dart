import 'package:firebase_auth/firebase_auth.dart';

class controladorUsuario {
  static String? nombre;
  static String? email;
  static String? foto;

  /// Login con Google en web usando FirebaseAuth.
  static Future<UserCredential?> signInWithGoogleWeb() async {
    try {
      final provider = GoogleAuthProvider();
      provider.addScope('email');
      provider.addScope('profile');

      final userCredential = await FirebaseAuth.instance.signInWithPopup(
        provider,
      );

      final user = userCredential.user;
      nombre = user?.displayName;
      email = user?.email;
      foto = user?.photoURL;

      return userCredential;
    } catch (e) {
      print('Error durante el inicio de sesión con Google (web): $e');
      return null;
    }
  }
}
