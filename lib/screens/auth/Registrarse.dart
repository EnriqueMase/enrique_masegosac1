import 'dart:io';
import 'dart:typed_data';

import 'package:enrique_masegosac1/screens/auth/Pantalla_login.dart';
import 'package:enrique_masegosac1/services/Logica_Usuarios.dart';
import 'package:enrique_masegosac1/widgets/custom_radio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:enrique_masegosac1/config/utils/Validadores.dart';
import 'package:enrique_masegosac1/models/usuarios.dart';

class Registrarse extends StatefulWidget {
  const Registrarse({super.key});

  @override
  State<Registrarse> createState() => _RegistrarseState();
}

class _RegistrarseState extends State<Registrarse> {
  final _formKey = GlobalKey<FormState>();

  final _nombreController = TextEditingController();
  final _passwordController = TextEditingController();
  final _edadController = TextEditingController();
  final _lugarNacimientoController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefonoController = TextEditingController();

  String? _genero;
  File? _pickedImage;
  Uint8List? _pickedImageBytes;

  @override
  void dispose() {
    _nombreController.dispose();
    _passwordController.dispose();
    _edadController.dispose();
    _lugarNacimientoController.dispose();
    _emailController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }

  Future<void> _seleccionarImagen() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      final bytes = await picked.readAsBytes();
      setState(() {
        _pickedImage = File(picked.path);
        _pickedImageBytes = bytes;
      });
    }
  }

  void _registrarUsuario() {
    if (!_formKey.currentState!.validate()) return;

    final logica = LogicaUsuarios();

    final nombre = _nombreController.text.trim();
    final contrasena = _passwordController.text.trim();

    if (logica.buscarUsuarioPorNombre(nombre) != null) {
      _mostrarError('El usuario "$nombre" ya existe');
      return;
    }

    final nuevoUsuario = Usuarios(
      nombre: nombre,
      contrasena: contrasena,
      tratamiento: _genero,
      edad: _edadController.text.trim(),
      lugarnacimiento: _lugarNacimientoController.text.trim(),
      fotoPath: _pickedImage?.path,
      fotoBytes: _pickedImageBytes,
      email: _emailController.text.trim(),
      telefono: _telefonoController.text.trim(),
    );

    logica.registrarUsuario(nuevoUsuario);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Registro completado'),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const PantallaLogin()),
    );
  }

  void _mostrarError(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrarse'),
        backgroundColor: const Color.fromARGB(255, 8, 179, 2),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: _seleccionarImagen,
                child: CircleAvatar(
                  radius: 48,
                  backgroundImage: _pickedImage != null
                      ? FileImage(_pickedImage!)
                      : null,
                  child: _pickedImage == null
                      ? const Icon(Icons.camera_alt, size: 32)
                      : null,
                ),
              ),
              const SizedBox(height: 16),
              // botones radio
              custom_radio(text: 'Sr'),
              custom_radio(text: 'Sra'),
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre de usuario',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    Validadores.validateEmpty(value, 'nombre de usuario'),
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    Validadores.validateEmpty(value, 'contraseña'),
              ),
              const SizedBox(height: 12),

              const SizedBox(height: 12),

              TextFormField(
                controller: _edadController,
                decoration: const InputDecoration(
                  labelText: 'Edad',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _lugarNacimientoController,
                decoration: const InputDecoration(
                  labelText: 'Lugar de nacimiento',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _telefonoController,
                decoration: const InputDecoration(
                  labelText: 'Teléfono',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _registrarUsuario,
                  child: const Text('Registrarse'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
