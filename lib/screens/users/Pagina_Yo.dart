import 'dart:io';
import 'dart:typed_data';

import 'package:enrique_masegosac1/config/resources/Botones/botones_colores.dart';
import 'package:enrique_masegosac1/config/utils/Validadores.dart';
import 'package:enrique_masegosac1/l10n/app_localizations.dart';
import 'package:enrique_masegosac1/models/usuarios.dart';
import 'package:enrique_masegosac1/screens/auth/Pantalla_login.dart';
import 'package:enrique_masegosac1/services/Logica_Usuarios.dart';
import 'package:enrique_masegosac1/widgets/drawer.dart';
import 'package:flutter/material.dart';

class PaginaYo extends StatefulWidget {
  const PaginaYo({super.key});

  @override
  State<PaginaYo> createState() => _PaginaYoState();
}

class _PaginaYoState extends State<PaginaYo> {
  // Copia del usuario logueado para mostrar y editar.
  Usuarios? _usuario;

  @override
  void initState() {
    super.initState();
    // Guardamos el usuario actual al iniciar la pantalla.
    _usuario = LogicaUsuarios().getUsuarioActual();
  }

  // Devuelve la imagen priorizando bytes y luego ruta en disco.
  ImageProvider? _resolverImagen(String? path, Uint8List? bytes) {
    if (bytes != null && bytes.isNotEmpty) return MemoryImage(bytes);
    if (path != null && path.isNotEmpty) return FileImage(File(path));
    return null;
  }

  // Abre un diálogo para editar solo los datos del propio usuario.
  void _mostrarEditor() {
    final user = _usuario;
    if (user == null) return;
    final l10n = AppLocalizations.of(context)!;
    final formKey = GlobalKey<FormState>();
    final nombreCtrl = TextEditingController(text: user.nombre);
    final emailCtrl = TextEditingController(text: user.email);
    final telefonoCtrl = TextEditingController(text: user.telefono);
    final edadCtrl = TextEditingController(text: user.edad ?? '');
    final lugarCtrl = TextEditingController(text: user.lugarnacimiento ?? '');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(l10n.editUser(user.nombre)),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Campos editables del perfil actual
                TextFormField(
                  controller: nombreCtrl,
                  decoration: InputDecoration(labelText: l10n.userName),
                  validator: (v) => Validadores.validateEmpty(v, l10n.userName),
                ),
                TextFormField(
                  controller: emailCtrl,
                  decoration: InputDecoration(labelText: l10n.email),
                ),
                TextFormField(
                  controller: telefonoCtrl,
                  decoration: InputDecoration(labelText: l10n.phone),
                ),
                TextFormField(
                  controller: edadCtrl,
                  decoration: InputDecoration(labelText: l10n.age),
                ),
                TextFormField(
                  controller: lugarCtrl,
                  decoration: InputDecoration(labelText: l10n.birthPlace),
                ),
              ],
            ),
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

              final actualizado = Usuarios(
                nombre: nombreCtrl.text.trim(),
                contrasena: user.contrasena,
                tratamiento: user.tratamiento,
                edad: edadCtrl.text.trim(),
                lugarnacimiento: lugarCtrl.text.trim(),
                fotoPath: user.fotoPath,
                fotoBytes: user.fotoBytes,
                isAdmin: user.isAdmin,
                isBlocked: user.isBlocked,
                email: emailCtrl.text.trim(),
                telefono: telefonoCtrl.text.trim(),
              );

              final logica = LogicaUsuarios();
              logica.actualizarUsuario(user.nombre, actualizado);
              setState(() {
                _usuario = logica.getUsuarioActual();
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.save)),
              );
            },
            child: Text(l10n.save),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final user = _usuario;

    if (user == null) {
      // Si no hay sesión activa, redirige de inmediato al login.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const PantallaLogin()),
        );
      });

      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final avatar = _resolverImagen(user.fotoPath, user.fotoBytes);

    return Scaffold(
      drawer: Cdrawer(),
      appBar: AppBar(
        title: Text(l10n.myProfile),
        backgroundColor: ButtonColors.Principal,
        actions: [
          // Botón para editar el perfil propio
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: l10n.edit,
            onPressed: _mostrarEditor,
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: avatar,
              child: avatar == null ? const Icon(Icons.person, size: 40) : null,
            ),
            const SizedBox(height: 16),
            Text(
              user.nombre,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('${l10n.email}: ${user.email}'),
            Text('${l10n.phone}: ${user.telefono}'),
            const SizedBox(height: 8),
            Text('${l10n.age}: ${user.getEdad()}'),
            Text('${l10n.birthPlace}: ${user.getLugarNacimiento()}'),
          ],
        ),
      ),
    );
  }
}
