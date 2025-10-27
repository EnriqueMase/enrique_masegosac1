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
  // Form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Registros',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              const Text(
                'Tratamiento:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: const Text('Sr.'),
                      leading: Radio<String>(
                        value: 'Sr',
                        groupValue: _genero,
                        onChanged: (value) => setState(() => _genero = value),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text('Sra.'),
                      leading: Radio<String>(
                        value: 'Sra',
                        groupValue: _genero,
                        onChanged: (value) => setState(() => _genero = value),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Nombre
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => Validators.validateEmpty(value, 'nombre'),
              ),

              const SizedBox(height: 16),

              // Contraseña
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    Validators.validateEmpty(value, 'contraseña'),
              ),

              const SizedBox(height: 16),

              // Repetir contraseña
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Repite la contraseña',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => Validators.validatePasswordMatch(
                  _passwordController.text,
                  value,
                ),
              ),

              const SizedBox(height: 16),

              // Imagen botones
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        final ImagePicker _picker = ImagePicker();
                        _picker.pickImage(source: ImageSource.gallery);
                      },
                      icon: const Icon(Icons.add_photo_alternate),
                      label: const Text('Añadir imagen'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        final ImagePicker _picker = ImagePicker();
                        _picker.pickImage(source: ImageSource.gallery);
                      },
                      icon: const Icon(Icons.upload),
                      label: const Text('Cargar imagen'),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Edad
              TextFormField(
                controller: _edadController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Edad',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => Validators.validateAge(value),
              ),

              const SizedBox(height: 16),

              // Lugar de nacimiento
              DropdownButtonFormField<String?>(
                decoration: const InputDecoration(
                  labelText: 'Lugar de Nacimiento',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: null, child: Text('-')),
                  DropdownMenuItem(value: 'Zaragoza', child: Text('Zaragoza')),
                  DropdownMenuItem(
                    value: 'Barcelona',
                    child: Text('Barcelona'),
                  ),
                  DropdownMenuItem(value: 'Madrid', child: Text('Madrid')),
                ],
                onChanged: (value) {
                  setState(() {
                    _lugarNacimientoController.text = value ?? '';
                  });
                },
                validator: (value) =>
                    Validators.validateEmpty(value, 'lugar de nacimiento'),
              ),

              const SizedBox(height: 16),

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
                  const Expanded(
                    child: Text('Aceptas los términos y condiciones'),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Botón de registro
              Center(
                child: ElevatedButton(
                  onPressed: _aceptaTerminos ? _registrarUsuario : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 8, 179, 2),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                  ),
                  child: const Text(
                    'Registrarse',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _registrarUsuario() {
    // Usa los validators en el Form: valida todo el formulario
    if (!_formKey.currentState!.validate()) {
      // Si algún campo falla, el Form mostrará los errores en cada campo.
      return;
    }

    final nombre = _nombreController.text.trim();
    final contrasena = _passwordController.text.trim();
    final tratamiento = _genero ?? 'Sr'; // Valor por defecto
    final edad = _edadController.text.trim();
    final fechaNacimiento = _lugarNacimientoController.text.trim();

    // Verificar si el nombre ya existe
    final existente = LogicaUsuarios().buscarUsuarioPorNombre(nombre);
    if (existente != null) {
      _mostrarError('El nombre de usuario ya existe');
      return;
    }

    final nuevoUsuario = User(
      nombre: nombre,
      contrasena: contrasena,
      tratamiento: tratamiento,
      edad: edad,
      lugarnacimiento: fechaNacimiento,
    );

    LogicaUsuarios().registrarUsuario(nuevoUsuario);

    // Mostrar mensaje de éxito después de registrar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Registro exitoso'),
        backgroundColor: Colors.green,
      ),
    );

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
