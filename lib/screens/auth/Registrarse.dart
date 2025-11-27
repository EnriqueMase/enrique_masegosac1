import 'dart:io';
import 'dart:typed_data';

import 'package:enrique_masegosac1/config/utils/Validadores.dart';
import 'package:enrique_masegosac1/models/usuarios.dart';
import 'package:enrique_masegosac1/screens/auth/Pantalla_login.dart';
import 'package:enrique_masegosac1/services/Logica_Usuarios.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Registrarse extends StatefulWidget {
  const Registrarse({super.key});

  @override
  State<Registrarse> createState() => _RegistrarseState();
}

class _RegistrarseState extends State<Registrarse> {
  final _formKey = GlobalKey<FormState>();

  final _nombreController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _edadController = TextEditingController();

  String? _genero;
  String? _lugarNacimiento = 'Zaragoza';
  File? _pickedImage;
  Uint8List? _pickedImageBytes;
  bool _aceptaTerminos = false;

  @override
  void dispose() {
    _nombreController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _edadController.dispose();
    super.dispose();
  }

  Future<void> _seleccionarImagen() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    await _procesarImagen(picked);
  }
  // foto desde camara del movil

  Future<void> _tomarFoto() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.camera);
    await _procesarImagen(picked);
  }

  Future<void> _procesarImagen(XFile? picked) async {
    if (picked == null) return;
    final bytes = await picked.readAsBytes();
    setState(() {
      _pickedImage = File(picked.path);
      _pickedImageBytes = bytes;
    });
  }

  void _registrarUsuario() {
    if (!_formKey.currentState!.validate()) return;
    if (!_aceptaTerminos) {
      _mostrarError('Debes aceptar los términos y condiciones');
      return;
    }

    final logica = LogicaUsuarios();
    final usuarioActual = logica.getUsuarioActual();
    final esAdminLogueado = usuarioActual?.isAdmin ?? false;

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
      lugarnacimiento: _lugarNacimiento,
      fotoPath: _pickedImage?.path,
      fotoBytes: _pickedImageBytes,
    );

    logica.registrarUsuario(nuevoUsuario);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Registro completado'),
        backgroundColor: Colors.green,
      ),
    );

    if (esAdminLogueado) {
      Navigator.pop(context, true);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const PantallaLogin()),
      );
    }
  }

  void _mostrarError(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje), backgroundColor: Colors.red),
    );
  }

  Widget _buildTratamientoOption(String valor, String etiqueta) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: valor,
          groupValue: _genero,
          onChanged: (value) => setState(() => _genero = value),
        ),
        Text(etiqueta),
      ],
    );
  }

  Widget _buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Anadir imagen',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade100,
                  border: Border.all(color: Colors.grey.shade300),
                  image: _pickedImageBytes != null
                      ? DecorationImage(
                          image: MemoryImage(_pickedImageBytes!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: _pickedImageBytes == null
                    ? const Icon(Icons.image, color: Colors.grey)
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    OutlinedButton(
                      onPressed: _seleccionarImagen,
                      child: const Text('Cargar imagen'),
                    ),
                    const SizedBox(height: 8),
                    OutlinedButton.icon(
                      onPressed: _tomarFoto,
                      icon: const Icon(Icons.photo_camera),
                      label: const Text('Camara'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registros'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tratamiento:',
                        style: TextStyle(fontSize: 16),
                      ),
                      Row(
                        children: [
                          _buildTratamientoOption('Sr', 'Sr.'),
                          _buildTratamientoOption('Sra', 'Sra.'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _nombreController,
                        decoration: const InputDecoration(
                          labelText: 'Nombre',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => Validadores.validateEmpty(
                            value, 'nombre de usuario'),
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
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Repite la contraseña',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => Validadores.validatePasswordMatch(
                          _passwordController.text,
                          value,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildImagePicker(),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _edadController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Edad',
                          border: OutlineInputBorder(),
                        ),
                        validator: Validadores.validateAge,
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        value: _lugarNacimiento,
                        decoration: const InputDecoration(
                          labelText: 'Lugar de nacimiento',
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'Zaragoza',
                            child: Text('Zaragoza'),
                          ),
                          DropdownMenuItem(
                            value: 'Madrid',
                            child: Text('Madrid'),
                          ),
                          DropdownMenuItem(
                            value: 'Barcelona',
                            child: Text('Barcelona'),
                          ),
                        ],
                        onChanged: (value) =>
                            setState(() => _lugarNacimiento = value),
                      ),
                      const SizedBox(height: 16),
                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Aceptas los términos y condiciones'),
                        value: _aceptaTerminos,
                        onChanged: (value) =>
                            setState(() => _aceptaTerminos = value ?? false),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _registrarUsuario,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text('Aceptar'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
