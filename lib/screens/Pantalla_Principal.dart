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
                ElevatedButton(
                  onPressed: () {
                    // Lógica para recuperar la contraseña
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
