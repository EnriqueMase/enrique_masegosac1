// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:enrique_masegosac1/l10n/app_localizations.dart';
import 'package:enrique_masegosac1/locale_bloc/locale_bloc.dart';
import 'package:enrique_masegosac1/locale_bloc/locale_state.dart';
import 'package:enrique_masegosac1/screens/auth/Registrarse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:enrique_masegosac1/config/utils/EstilosPersonalizados.dart';
import 'package:enrique_masegosac1/screens/users/Pantalla_Usuario.dart';
import 'package:enrique_masegosac1/config/utils/musica.dart';
import 'package:enrique_masegosac1/config/utils/Validadores.dart';
import 'package:enrique_masegosac1/config/resources/Botones/botones_estilo.dart';
import 'package:enrique_masegosac1/config/resources/Texto/texto_estilos.dart';
import 'package:enrique_masegosac1/controllers/usuario/user_controller.dart';
import 'package:enrique_masegosac1/controllers/controlador_autenticacion.dart';
import 'package:enrique_masegosac1/services/Logica_Usuarios.dart';
import 'package:enrique_masegosac1/widgets/cambio_lenguajes.dart';

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

    await Musica.reproducirLoop();

    // Autenticación local (admin/user) y redirección según rol.
    await _controladorAutenticacion.iniciarSesion(
      context: context,
      nombre: _nombreController.text,
      contrasena: _contrasenaController.text,
    );
  }

  Future<void> _loginConGoogle() async {
    // Login federado y creación/selección del usuario en memoria.
    final cred = await controladorUsuario.signInWithGoogle();

    if (!mounted) return;

    final usuarioActual = LogicaUsuarios().getUsuarioActual();

    if (cred != null && usuarioActual != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Pantalla_Usuario()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo iniciar sesion con Google')),
      );
    }
  }

  void _mostrarDialogoRecuperarContrasena() {
    final l10n = AppLocalizations.of(context)!;
    final usuarioController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(l10n.recoverPasswordTitle),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: usuarioController,
            decoration: InputDecoration(
              labelText: l10n.username,
              border: const OutlineInputBorder(),
              icon: const Icon(Icons.person),
            ),
            validator: (value) =>
                Validadores.validateEmpty(value, l10n.username),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              if (!formKey.currentState!.validate()) return;
              _mostrarContrasenaEnPantalla(usuarioController.text.trim());
              Navigator.pop(context);
            },
            child: Text(l10n.send),
          ),
        ],
      ),
    );
  }

  void _mostrarContrasenaEnPantalla(String nombreUsuario) {
    final l10n = AppLocalizations.of(context)!;
    final usuario = _controladorAutenticacion.obtenerUsuarioPorNombre(
      nombreUsuario,
    );

    if (!mounted) return;

    if (usuario != null) {
      setState(() {
        _mensajeContrasena =
            l10n.userAndPassword(usuario.nombre, usuario.contrasena);
      });
      Future.delayed(const Duration(seconds: 10), () {
        if (!mounted) return;
        setState(() => _mensajeContrasena = '');
      });
    } else {
      setState(() {
        _mensajeContrasena = l10n.userNotFound(nombreUsuario);
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
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              children: [
                // Selector de idioma - Igual que en el drawer
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: BlocBuilder<LocaleBloc, LocaleState>(
                    builder: (context, state) =>
                        buildLanguageSwitch(context, Theme.of(context), state),
                  ),
                ),

                // Card con el formulario de login
                Card(
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
                        Text(l10n.loginTitle, style: AppTextStyles.h1),
                        const SizedBox(height: 24),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _nombreController,
                                decoration: InputDecoration(
                                  labelText: l10n.username,
                                  prefixIcon: const Icon(Icons.person),
                                  border: const OutlineInputBorder(),
                                ),
                                validator: (value) => Validadores.validateEmpty(
                                    value, l10n.username),
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _contrasenaController,
                                obscureText: _obscurePassword,
                                decoration: InputDecoration(
                                  labelText: l10n.password,
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
                                validator: (value) => Validadores.validateEmpty(
                                    value, l10n.password),
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
                            child: Text(l10n.forgotPassword),
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _iniciarSesion,
                            style: BotonesEstilo.primary,
                            child: Text(l10n.signIn),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: _loginConGoogle,
                            icon: const Icon(Icons.login),
                            style: BotonesEstilo.outlined,
                            label: Text(l10n.signInWithGoogle),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(l10n.noAccount),
                            TextButton(
                              onPressed: _irARegistro,
                              child: Text(l10n.register),
                            ),
                          ],
                        ),
                      ],
                    ),
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
