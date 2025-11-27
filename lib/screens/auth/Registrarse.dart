import 'dart:io';
import 'dart:typed_data';

import 'package:enrique_masegosac1/config/utils/Validadores.dart';
import 'package:enrique_masegosac1/l10n/app_localizations.dart';
import 'package:enrique_masegosac1/locale_bloc/locale_bloc.dart';
import 'package:enrique_masegosac1/locale_bloc/locale_state.dart';
import 'package:enrique_masegosac1/models/usuarios.dart';
import 'package:enrique_masegosac1/screens/auth/Pantalla_login.dart';
import 'package:enrique_masegosac1/services/Logica_Usuarios.dart';
import 'package:enrique_masegosac1/widgets/cambio_lenguajes.dart';
import 'package:enrique_masegosac1/config/resources/Botones/botones_estilo.dart';
import 'package:enrique_masegosac1/config/resources/Botones/botones_colores.dart';
import 'package:enrique_masegosac1/config/resources/Texto/texto_estilos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  // Ejecuta validaciones y registra en memoria, manteniendo compatibilidad con admin/usuario.
  void _registrarUsuario() {
    final l10n = AppLocalizations.of(context)!;
    if (!_formKey.currentState!.validate()) return;
    if (!_aceptaTerminos) {
      _mostrarError(l10n.mustAcceptTerms);
      return;
    }

    final logica = LogicaUsuarios();
    final usuarioActual = logica.getUsuarioActual();
    final esAdminLogueado = usuarioActual?.isAdmin ?? false;

    final nombre = _nombreController.text.trim();
    final contrasena = _passwordController.text.trim();

    // Evitamos duplicados por nombre antes de registrar.
    if (logica.buscarUsuarioPorNombre(nombre) != null) {
      _mostrarError(l10n.userExists(nombre));
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
      SnackBar(
        content: Text(l10n.registrationCompleted),
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

  // Selector de imagen reutilizable para mantener el widget principal más limpio.
  Widget _buildImagePicker(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.addImage,
          style: const TextStyle(fontWeight: FontWeight.w600),
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
                      style: BotonesEstilo.outlined,
                      child: Text(l10n.uploadImage),
                    ),
                    const SizedBox(height: 8),
                    OutlinedButton.icon(
                      onPressed: _tomarFoto,
                      icon: const Icon(Icons.photo_camera),
                      style: BotonesEstilo.outlined,
                      label: Text(l10n.takePhoto),
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

  // Campo de entrada reutilizable para mantener el widget principal más limpio.
  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.registerTitle, style: AppTextStyles.h2),
        backgroundColor: ButtonColors.Principal,
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
                      // Cambio de idioma, igual que en login y drawer.
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: BlocBuilder<LocaleBloc, LocaleState>(
                          builder: (context, state) => buildLanguageSwitch(
                            context,
                            Theme.of(context),
                            state,
                          ),
                        ),
                      ),
                      Text(
                        '${l10n.gender}:',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Row(
                        children: [
                          _buildTratamientoOption('Sr', l10n.mr),
                          _buildTratamientoOption('Sra', l10n.mrs),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _buildInputField(
                        controller: _nombreController,
                        label: l10n.name,
                        validator: (value) =>
                            Validadores.validateEmpty(value, l10n.userName),
                      ),
                      const SizedBox(height: 12),
                      _buildInputField(
                        controller: _passwordController,
                        label: l10n.password,
                        obscureText: true,
                        validator: (value) =>
                            Validadores.validateEmpty(value, l10n.password),
                      ),
                      const SizedBox(height: 12),
                      _buildInputField(
                        controller: _confirmPasswordController,
                        label: l10n.confirmPassword,
                        obscureText: true,
                        validator: (value) => Validadores.validatePasswordMatch(
                          _passwordController.text,
                          value,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildImagePicker(l10n),
                      const SizedBox(height: 16),
                      _buildInputField(
                        controller: _edadController,
                        label: l10n.age,
                        keyboardType: TextInputType.number,
                        validator: Validadores.validateAge,
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        initialValue: _lugarNacimiento,
                        decoration: InputDecoration(
                          labelText: l10n.birthPlace,
                          border: const OutlineInputBorder(),
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
                      // Aceptación antes de registrar.
                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(l10n.termsAndConditionsLabel),
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
                          style: BotonesEstilo.primary,
                          child: Text(l10n.confirm),
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
