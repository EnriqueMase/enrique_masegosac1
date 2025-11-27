import 'package:enrique_masegosac1/controllers/administrador/controlador_usuarios_admin.dart';
import 'package:enrique_masegosac1/l10n/app_localizations.dart';
import 'package:enrique_masegosac1/models/usuarios.dart';
import 'package:flutter/material.dart';

Future<void> mostrarDialogoEditarUsuario({
  required BuildContext context,
  required Usuarios usuario,
  required ControladorUsuariosAdmin controlador,
  required VoidCallback onSaved,
}) async {
  final l10n = AppLocalizations.of(context)!;
  final formKey = GlobalKey<FormState>();
  final nombreController = TextEditingController(text: usuario.nombre);
  final passController = TextEditingController(text: usuario.contrasena);
  final emailController = TextEditingController(text: usuario.email);
  final telefonoController = TextEditingController(text: usuario.telefono);
  final edadController = TextEditingController(text: usuario.edad ?? '');
  final lugarController = TextEditingController(
    text: usuario.lugarnacimiento ?? '',
  );
  String? tratamiento = usuario.tratamiento;
  bool esAdmin = usuario.isAdmin;

  await showDialog(
    context: context,
    builder: (_) => StatefulBuilder(
      // StatefulBuilder para refrescar el toggle de admin dentro del dialogo
      builder: (context, setStateDialog) => AlertDialog(
        title: Text(l10n.editUser(usuario.nombre)),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Campos editables del usuario seleccionado
                TextFormField(
                  controller: nombreController,
                  decoration: InputDecoration(labelText: l10n.userName),
                  validator: (v) =>
                      v == null || v.isEmpty ? l10n.requiredField : null,
                ),
                TextFormField(
                  controller: passController,
                  decoration: InputDecoration(labelText: l10n.password),
                  obscureText: true,
                  validator: (v) =>
                      v == null || v.isEmpty ? l10n.requiredField : null,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: l10n.email),
                ),
                TextFormField(
                  controller: telefonoController,
                  decoration: InputDecoration(labelText: l10n.phone),
                ),
                TextFormField(
                  controller: edadController,
                  decoration: InputDecoration(labelText: l10n.age),
                ),
                TextFormField(
                  controller: lugarController,
                  decoration: InputDecoration(labelText: l10n.birthPlace),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  initialValue: tratamiento,
                  items: [
                    DropdownMenuItem(value: 'Sr', child: Text(l10n.mr)),
                    DropdownMenuItem(value: 'Sra', child: Text(l10n.mrs)),
                    DropdownMenuItem(value: 'Otro', child: Text(l10n.other)),
                  ],
                  decoration: InputDecoration(labelText: l10n.gender),
                  onChanged: (value) {
                    tratamiento = value;
                  },
                ),
                const SizedBox(height: 8),
                SwitchListTile(
                  value: esAdmin,
                  onChanged: (value) {
                    setStateDialog(() {
                      esAdmin = value;
                    });
                  },
                  title: Text(l10n.isAdmin),
                ),
                // Boton rapido para alternar admin
                Align(
                  alignment: Alignment.centerLeft,
                  child: OutlinedButton.icon(
                    onPressed: () => setStateDialog(() => esAdmin = !esAdmin),
                    icon: Icon(
                      esAdmin
                          ? Icons.admin_panel_settings
                          : Icons.add_moderator,
                    ),
                    label: Text(
                      esAdmin ? l10n.isAdmin : '${l10n.isAdmin} (+)',
                    ),
                  ),
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

              final nuevo = Usuarios(
                nombre: nombreController.text.trim(),
                contrasena: passController.text.trim(),
                tratamiento: tratamiento,
                edad: edadController.text.trim(),
                lugarnacimiento: lugarController.text.trim(),
                email: emailController.text.trim(),
                telefono: telefonoController.text.trim(),
                isAdmin: esAdmin,
                isBlocked: usuario.isBlocked,
                fotoPath: usuario.fotoPath,
                fotoBytes: usuario.fotoBytes,
              );

              controlador.editarUsuario(
                nombreOriginal: usuario.nombre,
                datosNuevos: nuevo,
              );

              Navigator.pop(context);
              onSaved();
            },
            child: Text(l10n.save),
          ),
        ],
      ),
    ),
  );
}
