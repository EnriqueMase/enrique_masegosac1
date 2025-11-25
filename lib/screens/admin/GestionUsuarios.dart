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
    final formKey = GlobalKey<FormState>();
    final nombreController = TextEditingController();
    final passController = TextEditingController();
    final emailController = TextEditingController();
    final telefonoController = TextEditingController();
    bool esAdmin = false;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Crear usuario'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nombreController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre de usuario',
                  ),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Obligatorio' : null,
                ),
                TextFormField(
                  controller: passController,
                  decoration: const InputDecoration(labelText: 'Contraseña'),
                  obscureText: true,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Obligatorio' : null,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextFormField(
                  controller: telefonoController,
                  decoration: const InputDecoration(labelText: 'Teléfono'),
                ),
                const SizedBox(height: 8),
                SwitchListTile(
                  value: esAdmin,
                  onChanged: (value) {
                    setState(() {
                      esAdmin = value;
                    });
                  },
                  title: const Text('Es administrador'),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
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
            child: const Text('Crear'),
          ),
        ],
      ),
    );
  }

  void _mostrarDialogoEditarUsuario(Usuarios u) {
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
        title: Text('Editar usuario: ${u.nombre}'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nombreController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre de usuario',
                  ),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Obligatorio' : null,
                ),
                TextFormField(
                  controller: passController,
                  decoration: const InputDecoration(labelText: 'Contraseña'),
                  obscureText: true,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Obligatorio' : null,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextFormField(
                  controller: telefonoController,
                  decoration: const InputDecoration(labelText: 'Teléfono'),
                ),
                TextFormField(
                  controller: edadController,
                  decoration: const InputDecoration(labelText: 'Edad'),
                ),
                TextFormField(
                  controller: lugarController,
                  decoration: const InputDecoration(
                    labelText: 'Lugar de nacimiento',
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: tratamiento,
                  items: const [
                    DropdownMenuItem(value: 'Sr', child: Text('Sr')),
                    DropdownMenuItem(value: 'Sra', child: Text('Sra')),
                    DropdownMenuItem(value: 'Otro', child: Text('Otro')),
                  ],
                  decoration: const InputDecoration(labelText: 'Tratamiento'),
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
                  title: const Text('Es administrador'),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
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
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final usuarios = _controladorUsuariosAdmin.getUsuariosGestionables();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de usuarios'),
        backgroundColor: const Color.fromARGB(255, 120, 190, 255),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarDialogoCrearUsuario,
        child: const Icon(Icons.add),
      ),
      body: usuarios.isEmpty
          ? const Center(child: Text('No hay usuarios que gestionar'))
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
                      'Email: ${u.email}\n'
                      'Teléfono: ${u.telefono}\n'
                      'Estado: ${u.isBlocked ? 'Bloqueado' : 'Activo'}',
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
                        const PopupMenuItem(
                          value: 'editar',
                          child: Text('Editar'),
                        ),
                        if (!u.isBlocked)
                          const PopupMenuItem(
                            value: 'bloquear',
                            child: Text('Bloquear'),
                          )
                        else
                          const PopupMenuItem(
                            value: 'desbloquear',
                            child: Text('Desbloquear'),
                          ),
                        const PopupMenuItem(
                          value: 'eliminar',
                          child: Text(
                            'Eliminar',
                            style: TextStyle(color: Colors.red),
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
