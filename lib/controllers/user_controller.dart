import 'package:firebase_auth/firebase_auth.dart';

class UserController {
  static String? nombre;
  static String? email;
  static String? foto;

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
      print('Error during Google sign-in (web): $e');
      return null;
    }
  }
}
