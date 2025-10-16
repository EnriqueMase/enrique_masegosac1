import 'package:enrique_masegosac1/config/utils/Validators.dart';
import 'package:enrique_masegosac1/models/user.dart';
import 'package:enrique_masegosac1/services/LogicaUsuarios.dart';
import 'package:enrique_masegosac1/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:enrique_masegosac1/screens/Pantalla_Principal.dart';
import 'package:image_picker/image_picker.dart';

class Registrarse extends StatefulWidget {
  const Registrarse({super.key});

  @override
  State<Registrarse> createState() => _RegistrarseState();
}

class _RegistrarseState extends State<Registrarse> {
  String? _genero;
  bool _aceptaTerminos = false;

  // Controladores para los campos de texto
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _edadController = TextEditingController();
  final TextEditingController _lugarNacimientoController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Cdrawer(),
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.app_registration),
            SizedBox(width: 10),
            const Text("Registrarse"),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 8, 179, 2),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Registros',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Tratamiento (Sr./Sra.)
            Text(
              'Tratamiento:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text('Sr.'),
                    leading: Radio(
                      value: 'Sr',
                      groupValue: _genero,
                      onChanged: (value) {
                        setState(() {
                          _genero = value!;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text('Sra.'),
                    leading: Radio(
                      value: 'Sra',
                      groupValue: _genero,
                      onChanged: (value) {
                        setState(() {
                          _genero = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Nombre
            TextFormField(
              controller: _nombreController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 16),

            // Contraseña
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 16),

            // Repetir contraseña
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Repite la contraseña',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 16),

            // Añadir imagen
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Aquí iría la lógica para seleccionar imagen
                      final ImagePicker _picker = ImagePicker();
                      _picker.pickImage(source: ImageSource.gallery);
                    },
                    icon: Icon(Icons.add_photo_alternate),
                    label: Text('Añadir imagen'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      final ImagePicker _picker = ImagePicker();
                      _picker.pickImage(source: ImageSource.gallery);
                    },
                    icon: Icon(Icons.upload),
                    label: Text('Cargar imagen'),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Edad
            TextFormField(
              controller: _edadController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Edad',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 16),

            // Lugar de nacimiento
            DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Lugar de Nacimiento',
                border: OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem(value: null, child: Text('-')),
                DropdownMenuItem(value: 'Zaragoza', child: Text('Zaragoza')),
                DropdownMenuItem(value: 'Barcelona', child: Text('Barcelona')),
                DropdownMenuItem(value: 'Madrid', child: Text('Madrid')),
              ],
              onChanged: (value) {
                setState(() {
                  _lugarNacimientoController.text = value ?? '';
                });
              },
              validator: (value) => Validators.validateEmpty(value),
            ),

            SizedBox(height: 16),

            // Términos y condiciones
            Row(
              children: [
                Checkbox(
                  value: _aceptaTerminos,
                  onChanged: (value) {
                    setState(() {
                      _aceptaTerminos = value!;
                    });
                  },
                ),
                Expanded(child: Text('Aceptas los términos y condiciones')),
              ],
            ),

            SizedBox(height: 24),

            // Botón de registro
            Center(
              child: ElevatedButton(
                onPressed: _aceptaTerminos ? _registrarUsuario : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 8, 179, 2),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: Text(
                  'Registrarse',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _registrarUsuario() {
    // Validaciones básicas
    if (_nombreController.text.isEmpty) {
      _mostrarError('Por favor ingresa tu nombre');
      return;
    }

    if (_passwordController.text.isEmpty) {
      _mostrarError('Por favor ingresa una contraseña');
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      _mostrarError('Las contraseñas no coinciden');
      return;
    }

    if (_edadController.text.isEmpty) {
      _mostrarError('Por favor ingresa tu edad');
      return;
    }

    if (_lugarNacimientoController.text.isEmpty) {
      _mostrarError('Por favor ingresa tu lugar de nacimiento');
      return;
    }

    // Mostrar mensaje de éxito
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Registro exitoso'),
        backgroundColor: Colors.green,
      ),
    );

    final nombre = _nombreController.text.trim();
    final contrasena = _passwordController.text.trim();
    final tratamiento = _genero ?? 'Sr'; // Valor por defecto
    final edad = _edadController.text.trim();
    final fechaNacimiento = _lugarNacimientoController.text.trim();

    final nuevoUsuario = User(
      nombre: nombre,
      contrasena: contrasena,
      tratamiento: tratamiento,
      edad: edad,
      lugarnacimiento: fechaNacimiento,
    );

    LogicaUsuarios().registrarUsuario(nuevoUsuario);

    // Volver a la pantalla principal
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Pantalla_Principal()),
    );
  }

  void _mostrarError(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje), backgroundColor: Colors.red),
    );
  }
}
