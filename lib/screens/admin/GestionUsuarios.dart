import 'package:enrique_masegosac1/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import 'package:enrique_masegosac1/controllers/administrador/controlador_usuarios_admin.dart';
import 'package:enrique_masegosac1/models/usuarios.dart';

class GestionUsuariosPage extends StatefulWidget {
  const GestionUsuariosPage({super.key});
  @override
  State<GestionUsuariosPage> createState() => _GestionUsuariosPageState();
}

class _GestionUsuariosPageState extends State<GestionUsuariosPage> {
  final ControladorUsuariosAdmin _controladorUsuariosAdmin =
      ControladorUsuariosAdmin();

  void _mostrarDialogoCrearUsuario() {
    final l10n = AppLocalizations.of(context)!;
    final formKey = GlobalKey<FormState>();
    final nombreController = TextEditingController();
    final passController = TextEditingController();
    final emailController = TextEditingController();
    final telefonoController = TextEditingController();
    bool esAdmin = false;

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setStateDialog) => AlertDialog(
          title: Text(l10n.createUser),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
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

                _controladorUsuariosAdmin.crearUsuario(
                  nombre: nombreController.text.trim(),
                  contrasena: passController.text.trim(),
                  email: emailController.text.trim(),
                  telefono: telefonoController.text.trim(),
                  isAdmin: esAdmin,
                );

                Navigator.pop(context);
                setState(() {});
              },
              child: Text(l10n.create),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarDialogoEditarUsuario(Usuarios u) {
    final l10n = AppLocalizations.of(context)!;
    final formKey = GlobalKey<FormState>();
    final nombreController = TextEditingController(text: u.nombre);
    final passController = TextEditingController(text: u.contrasena);
    final emailController = TextEditingController(text: u.email);
    final telefonoController = TextEditingController(text: u.telefono);
    final edadController = TextEditingController(text: u.edad ?? '');
    final lugarController = TextEditingController(
      text: u.lugarnacimiento ?? '',
    );
    String? tratamiento = u.tratamiento;
    bool esAdmin = u.isAdmin;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(l10n.editUser(u.nombre)),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
                  value: tratamiento,
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
                    setState(() {
                      esAdmin = value;
                    });
                  },
                  title: Text(l10n.isAdmin),
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
                isBlocked: u.isBlocked,
                fotoPath: u.fotoPath,
                fotoBytes: u.fotoBytes,
              );

              _controladorUsuariosAdmin.editarUsuario(
                nombreOriginal: u.nombre,
                datosNuevos: nuevo,
              );

              Navigator.pop(context);
              setState(() {});
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
    final usuarios = _controladorUsuariosAdmin.getUsuariosGestionables();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.userManagement),
        backgroundColor: const Color.fromARGB(255, 120, 190, 255),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarDialogoCrearUsuario,
        child: const Icon(Icons.add),
      ),
      body: usuarios.isEmpty
          ? Center(child: Text(l10n.noUsersToManage))
          : ListView.builder(
              itemCount: usuarios.length,
              itemBuilder: (context, index) {
                final u = usuarios[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: Icon(
                      u.isAdmin ? Icons.verified_user : Icons.person,
                      color: u.isAdmin ? Colors.green : Colors.blueGrey,
                    ),
                    title: Text(u.nombre),
                    subtitle: Text(
                      '${l10n.email}: ${u.email}\n'
                      '${l10n.phone}: ${u.telefono}\n'
                      '${l10n.status}: ${u.isBlocked ? l10n.blocked : l10n.active}',
                    ),
                    isThreeLine: true,
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'editar') {
                          _mostrarDialogoEditarUsuario(u);
                        } else if (value == 'bloquear') {
                          _controladorUsuariosAdmin.bloquearUsuario(u.nombre);
                          setState(() {});
                        } else if (value == 'desbloquear') {
                          _controladorUsuariosAdmin.desbloquearUsuario(
                            u.nombre,
                          );
                          setState(() {});
                        } else if (value == 'eliminar') {
                          _controladorUsuariosAdmin.eliminarUsuario(u.nombre);
                          setState(() {});
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(value: 'editar', child: Text(l10n.edit)),
                        if (!u.isBlocked)
                          PopupMenuItem(
                            value: 'bloquear',
                            child: Text(l10n.block),
                          )
                        else
                          PopupMenuItem(
                            value: 'desbloquear',
                            child: Text(l10n.unblock),
                          ),
                        PopupMenuItem(
                          value: 'eliminar',
                          child: Text(
                            l10n.delete,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
