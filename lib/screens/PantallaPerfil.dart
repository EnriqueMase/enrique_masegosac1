import 'package:enrique_masegosac1/screens/Pantalla_Principal.dart';
import 'package:flutter/material.dart';
import 'package:enrique_masegosac1/widgets/drawer.dart';
import 'package:enrique_masegosac1/services/LogicaUsuarios.dart';
import 'package:enrique_masegosac1/models/user.dart';

class PantallaPerfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? usuarioActual = LogicaUsuarios().getUsuarioActual();
    if (usuarioActual == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Pantalla_Principal()),
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
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                'assets/images/Bob.png',
              ), // Cambia la ruta según tu imagen
            ),
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
            // quiero que salga la edad, fecha y si es sr o sra
            SizedBox(height: 8),
            Text(
              'Edad: ${usuarioActual.edad} años', // Reemplaza con la edad real
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 8),
            Text(
              'Lugar de nacimiento: ${usuarioActual.lugarnacimiento}', // Reemplaza con la fecha real
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
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
