// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:enrique_masegosac1/screens/Pantalla_Secundaria.dart';
import 'package:enrique_masegosac1/screens/Registrarse.dart';
import 'package:flutter/material.dart';
import 'package:enrique_masegosac1/services/LogicaUsuarios.dart';
import 'package:enrique_masegosac1/models/user.dart';

class Pantalla_Principal extends StatefulWidget {
  const Pantalla_Principal({super.key});

  @override
  State<Pantalla_Principal> createState() => _Pantalla_PrincipalState();
}

class _Pantalla_PrincipalState extends State<Pantalla_Principal> {
  bool _obscurePassword = true;
  String _nombre = "";
  String _contrasena = "";
  void _PantallaSecundaria() {
    // Limpiar espacios
    String nombre = _nombre.trim();
    String contrasena = _contrasena.trim();

    if (nombre.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("El campo Nombre está vacío")));
      return;
    }

    if (contrasena.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("El campo Contraseña está vacío")));
      return;
    }

    // **MÉTODO SIMPLIFICADO Y ROBUSTO**
    LogicaUsuarios logica = LogicaUsuarios();

    // Debug
    logica.imprimirUsuarios();
    print("Buscando: '$nombre' con contraseña '$contrasena'");

    // Buscar usuario
    User? usuario = logica.buscarUsuarioPorNombre(nombre);

    if (usuario == null) {
      print("Usuario no encontrado");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Usuario no encontrado")));
      return;
    }

    // Verificar contraseña
    if (usuario.contrasena != contrasena) {
      print("Contraseña incorrecta");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Contraseña incorrecta")));
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
        title: Row(
          children: [
            Icon(Icons.person),
            SizedBox(width: 10),
            const Text("Lord Team"),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 8, 179, 2),
      ),
      body: Container(
        decoration: const BoxDecoration(),
        child: Center(
          child: Column(
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
                //Esto hace que ocupe su espacio entero.
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 35),
              // Nombre
              SizedBox(
                width: 500,
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nombre',
                    hintText: 'Ingresa tu nombre',
                    icon: Icon(Icons.person),
                  ),
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  onChanged: (value) {
                    setState(() {
                      _nombre = value;
                    });
                  },
                ),
                // Contraseña
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 500,
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Contraseña',
                    hintText: 'Ingresa tu contraseña',
                    icon: Icon(Icons.lock),
                    // ver lo que se escribe
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
                  onChanged: (value) {
                    setState(() {
                      _contrasena = value;
                    });
                  },
                  // Esconde el texto ingresado
                  obscureText: _obscurePassword,
                  keyboardType: TextInputType.visiblePassword,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _PantallaSecundaria,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 153, 117, 173),
                ),
                child: const Text(
                  'Inicio de sesion',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              // registrarse
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Registrarse()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 153, 117, 173),
                ),
                child: const Text(
                  'Registrarse',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
