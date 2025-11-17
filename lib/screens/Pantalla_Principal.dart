// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:enrique_masegosac1/screens/Pantalla_Secundaria.dart';
import 'package:enrique_masegosac1/screens/Registrarse.dart';
import 'package:flutter/material.dart';
import 'package:enrique_masegosac1/services/LogicaUsuarios.dart';
import 'package:enrique_masegosac1/models/user.dart';
import 'package:enrique_masegosac1/config/utils/music.dart';
import 'package:enrique_masegosac1/config/utils/Validators.dart';
import 'package:enrique_masegosac1/config/utils/button_styles.dart';

class Pantalla_Principal extends StatefulWidget {
  const Pantalla_Principal({super.key});

  @override
  State<Pantalla_Principal> createState() => _Pantalla_PrincipalState();
}

class _Pantalla_PrincipalState extends State<Pantalla_Principal> {
  bool _obscurePassword = true;
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _contrasenaController = TextEditingController();
  String _mensajeContrasena =
      ''; // Variable para mostrar la contraseña en pantalla

  @override
  void dispose() {
    _nombreController.dispose();
    _contrasenaController.dispose();
    super.dispose();
  }

  void _PantallaSecundaria() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Limpiar espacios
    String nombre = _nombreController.text.trim();
    String contrasena = _contrasenaController.text.trim();

    // Validar credenciales
    LogicaUsuarios logica = LogicaUsuarios();
    logica.imprimirUsuarios(); // Debug: muestra usuarios registrados

    User? usuario = logica.validarCredenciales(nombre, contrasena);
    if (usuario == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Usuario o contraseña incorrectos"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Login exitoso
    print("Login exitoso para: ${usuario.nombre}");
    logica.setUsuarioActual(usuario);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Pantalla_Secundaria()),
    );
  }

  void _mostrarDialogoRecuperarContrasena() {
    final _usuarioController = TextEditingController();
    final _recuperarFormKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Recuperar contraseña'),
          content: Form(
            key: _recuperarFormKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Ingresa tu nombre de usuario para recuperar tu contraseña',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _usuarioController,
                    decoration: const InputDecoration(
                      labelText: 'Nombre de usuario',
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu nombre de usuario';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_recuperarFormKey.currentState!.validate()) {
                  String usuario = _usuarioController.text.trim();
                  _mostrarContrasenaEnPantalla(usuario);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Enviar'),
            ),
          ],
        );
      },
    );
  }

  void _mostrarContrasenaEnPantalla(String nombreUsuario) {
    LogicaUsuarios logica = LogicaUsuarios();

    // Buscar el usuario por nombre
    User? usuario = logica.obtenerUsuarioPorNombre(nombreUsuario);

    if (usuario != null) {
      // mostrar la contraseña directamente en la pantalla principal
      setState(() {
        _mensajeContrasena =
            'Usuario: ${usuario.nombre}\nContraseña: ${usuario.contrasena}';
      });

      // esto es para que cuando pasesn 10 segundos se elimine el mensaje
      Future.delayed(const Duration(seconds: 10), () {
        if (mounted) {
          setState(() {
            _mensajeContrasena = '';
          });
        }
      });
    } else {
      // mostrar mensaje en pantalla de usuario no encontrado
      setState(() {
        _mensajeContrasena = 'Usuario "$nombreUsuario" no encontrado';
      });

      // esto es por si el usuario no existe
      // y que en 5 segundos se elimine el mensaje
      Future.delayed(const Duration(seconds: 5), () {
        if (mounted) {
          setState(() {
            _mensajeContrasena = '';
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.person),
            SizedBox(width: 10),
            Text("Lord Team"),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 8, 179, 2),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Bienvenido a la App de Lord Team",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 35),
                const Image(
                  image: AssetImage("assets/images/Logo.png"),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 35),

                // Mostrar mensaje de contraseña si existe
                if (_mensajeContrasena.isNotEmpty)
                  Container(
                    width: 500,
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.lock_open,
                          color: Colors.green,
                          size: 40,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _mensajeContrasena,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Esta información se borrará automáticamente',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),

                // Nombre
                SizedBox(
                  width: 500,
                  child: TextFormField(
                    controller: _nombreController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nombre',
                      hintText: 'Ingresa tu nombre',
                      icon: Icon(Icons.person),
                    ),
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                    validator: (value) =>
                        Validators.validateEmpty(value, 'nombre'),
                  ),
                ),
                const SizedBox(height: 20),
                // Contraseña
                SizedBox(
                  width: 500,
                  child: TextFormField(
                    controller: _contrasenaController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Contraseña',
                      hintText: 'Ingresa tu contraseña',
                      icon: const Icon(Icons.lock),
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
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                    validator: (value) =>
                        Validators.validateEmpty(value, 'contraseña'),
                    obscureText: _obscurePassword,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                ),
                const SizedBox(height: 20),
                // Botón de login
                ElevatedButton(
                  onPressed: () {
                    Music.reproducir();
                    _PantallaSecundaria();
                  },
                  style: ButtonStyles.primaryButton,
                  child: const Text(
                    'Inicio de sesión',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                // Botón de registro
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Registrarse(),
                      ),
                    );
                  },
                  style: ButtonStyles.secondaryButton,
                  child: const Text(
                    'Registrarse',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                // Botón de recuperar contraseña
                ElevatedButton(
                  onPressed: () {
                    _mostrarDialogoRecuperarContrasena();
                  },
                  style: ButtonStyles.secondaryButton,
                  child: const Text(
                    '¿Olvidaste la contraseña?',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
