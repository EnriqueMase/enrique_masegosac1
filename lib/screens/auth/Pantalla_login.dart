// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:enrique_masegosac1/screens/auth/Registrarse.dart';
import 'package:flutter/material.dart';
import 'package:enrique_masegosac1/config/utils/EstilosPersonalizados.dart';
import 'package:enrique_masegosac1/screens/users/Pantalla_Usuario.dart';
import 'package:enrique_masegosac1/config/utils/musica.dart';
import 'package:enrique_masegosac1/config/utils/Validadores.dart';
import 'package:enrique_masegosac1/config/resources/Botones/botones_estilo.dart';
import 'package:enrique_masegosac1/controllers/usuario/user_controller.dart';
import 'package:enrique_masegosac1/controllers/controlador_autenticacion.dart';

class PantallaLogin extends StatefulWidget {
  const PantallaLogin({super.key});

  @override
  State<PantallaLogin> createState() => PantallaLoginState();
}

class PantallaLoginState extends State<PantallaLogin> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _contrasenaController = TextEditingController();
  bool _obscurePassword = true;
  String _mensajeContrasena = '';

  final ControladorAutenticacion _controladorAutenticacion =
      ControladorAutenticacion();

  @override
  void dispose() {
    _nombreController.dispose();
    _contrasenaController.dispose();
    super.dispose();
  }

  Future<void> _iniciarSesion() async {
    if (!_formKey.currentState!.validate()) return;

    await Musica.reproducir();

    await _controladorAutenticacion.iniciarSesion(
      context: context,
      nombre: _nombreController.text,
      contrasena: _contrasenaController.text,
    );
  }

  Future<void> _loginConGoogle() async {
    final cred = await controladorUsuario.signInWithGoogleWeb();

    if (!mounted) return;

    if (cred != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Pantalla_Usuario()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo iniciar sesión con Google')),
      );
    }
  }

  void _mostrarDialogoRecuperarContrasena() {
    final usuarioController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Recuperar contraseña'),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: usuarioController,
            decoration: const InputDecoration(
              labelText: 'Nombre de usuario',
              border: OutlineInputBorder(),
              icon: Icon(Icons.person),
            ),
            validator: (value) =>
                Validadores.validateEmpty(value, 'nombre de usuario'),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              if (!formKey.currentState!.validate()) return;
              _mostrarContrasenaEnPantalla(usuarioController.text.trim());
              Navigator.pop(context);
            },
            child: const Text('Enviar'),
          ),
        ],
      ),
    );
  }

  void _mostrarContrasenaEnPantalla(String nombreUsuario) {
    final usuario = _controladorAutenticacion.obtenerUsuarioPorNombre(
      nombreUsuario,
    );

    if (!mounted) return;

    if (usuario != null) {
      setState(() {
        _mensajeContrasena =
            'Usuario: ${usuario.nombre}\nContraseña: ${usuario.contrasena}';
      });
      Future.delayed(const Duration(seconds: 10), () {
        if (!mounted) return;
        setState(() => _mensajeContrasena = '');
      });
    } else {
      setState(() {
        _mensajeContrasena = 'Usuario "$nombreUsuario" no encontrado';
      });
      Future.delayed(const Duration(seconds: 5), () {
        if (!mounted) return;
        setState(() => _mensajeContrasena = '');
      });
    }
  }

  void _irARegistro() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const Registrarse()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(child: EstilosPersonalizados.logoImage()),

                    const Text(
                      'Inicio de sesión',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),

                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _nombreController,
                            decoration: const InputDecoration(
                              labelText: 'Usuario',
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) =>
                                Validadores.validateEmpty(value, 'usuario'),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _contrasenaController,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              labelText: 'Contraseña',
                              prefixIcon: const Icon(Icons.lock),
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                            validator: (value) =>
                                Validadores.validateEmpty(value, 'contraseña'),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    if (_mensajeContrasena.isNotEmpty)
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _mensajeContrasena,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: _mostrarDialogoRecuperarContrasena,
                        child: const Text('¿Has olvidado tu contraseña?'),
                      ),
                    ),

                    const SizedBox(height: 8),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _iniciarSesion,
                        style: BotonesEstilo.primary,
                        child: const Text('Iniciar sesión'),
                      ),
                    ),

                    const SizedBox(height: 12),

                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: _loginConGoogle,
                        icon: const Icon(Icons.login),
                        label: const Text('Iniciar sesión con Google'),
                      ),
                    ),

                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('¿No tienes cuenta?'),
                        TextButton(
                          onPressed: _irARegistro,
                          child: const Text('Regístrate'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
