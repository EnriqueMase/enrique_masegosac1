import 'package:enrique_masegosac1/screens/auth/Pantalla_login.dart';
import 'package:flutter/material.dart';
import 'package:enrique_masegosac1/widgets/drawer.dart';
import 'package:enrique_masegosac1/services/Logica_Usuarios.dart';
import 'package:enrique_masegosac1/models/usuarios.dart';
import 'dart:io';

class PantallaPerfil extends StatefulWidget {
  const PantallaPerfil({super.key});

  @override
  _PantallaPerfilState createState() => _PantallaPerfilState();
}

class _PantallaPerfilState extends State<PantallaPerfil> {
  Usuarios? _usuarioActual;

  final bool _isWeb = identical(0, 0.0);

  @override
  void initState() {
    super.initState();
    _usuarioActual = LogicaUsuarios().getUsuarioActual();
  }

  Widget _Avatar() {
    // PARA WEB: usar imagen desde bytes
    /* aqui lo que hace eso ir al usuario 
    para ver la imagen con la que se registro*/
    if (_isWeb && _usuarioActual?.fotoBytes != null) {
      return CircleAvatar(
        radius: 60,
        backgroundImage: MemoryImage(_usuarioActual!.fotoBytes!),
      );
    }
    // PARA MÓVIL: usar imagen desde archivo
    else if (!_isWeb &&
        _usuarioActual?.fotoPath != null &&
        _usuarioActual!.fotoPath!.isNotEmpty) {
      return CircleAvatar(
        radius: 60,
        backgroundImage: FileImage(File(_usuarioActual!.fotoPath!)),
      );
    }
    // usar icono por defecto si no hay imagen
    else {
      return CircleAvatar(
        radius: 60,
        backgroundColor: Colors.blue.shade100,
        child: const Icon(Icons.person, size: 60, color: Colors.blue),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Usuarios? usuarioActual = _usuarioActual;
    if (usuarioActual == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PantallaLogin()),
        );
      });
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      drawer: Cdrawer(),
      appBar: AppBar(
        title: Text('Bienvenido ${usuarioActual.nombre}'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _Avatar(),
            SizedBox(height: 16),
            Text(
              usuarioActual.nombre,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '${usuarioActual.nombre}@email.com',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 8),
            Text(
              'Edad: ${usuarioActual.edad} años',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 8),
            Text(
              'Lugar de nacimiento: ${usuarioActual.lugarnacimiento}',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 8),
            Text(
              'Tratamiento: ${usuarioActual.tratamiento}.',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 24),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Editar perfil'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configuración'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Cerrar sesión'),
              onTap: () {
                LogicaUsuarios().cerrarSesion();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PantallaLogin(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
