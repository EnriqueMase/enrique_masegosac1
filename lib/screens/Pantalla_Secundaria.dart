import 'package:enrique_masegosac1/config/utils/music.dart';
import 'package:flutter/material.dart';
import 'package:enrique_masegosac1/services/LogicaUsuarios.dart';
import 'dart:io';
import 'package:enrique_masegosac1/config/utils/Camera.dart';
import 'package:enrique_masegosac1/widgets/drawer.dart';
import 'package:enrique_masegosac1/models/user.dart';

String? photoPath;

class Pantalla_Secundaria extends StatefulWidget {
  const Pantalla_Secundaria({super.key});

  @override
  State<Pantalla_Secundaria> createState() => _Pantalla_SecundariaState();
}

class _Pantalla_SecundariaState extends State<Pantalla_Secundaria> {
  @override
  Widget build(BuildContext context) {
    User? usuario = LogicaUsuarios().getUsuarioActual();
    String nombreUsuario = usuario?.getNombre() ?? "Invitado";
    return Scaffold(
      drawer: Cdrawer(),
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.info),
            SizedBox(width: 10),
            const Text("Pantalla Secundaria"),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 8, 179, 2),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              "Bienvenido $nombreUsuario",
              style: TextStyle(
                fontSize: 40,
                color: Color.fromARGB(255, 12, 99, 8),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 35),
            const SizedBox(height: 20),
            const Text(
              "Aquí puedes ver información adicional.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 35),
            SizedBox(
              height: 350,
              child: photoPath != null
                  ? Image(image: FileImage(File(photoPath!)), fit: BoxFit.fill)
                  : Container(),
            ),
            const Text(
              'Botones de Reproducción',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: Music.anadirMusica,
                  child: Text("cargar musica"),
                ),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: Music.reproducir,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text(''),
                ),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: Music.pausar,
                  icon: const Icon(Icons.pause),
                  label: const Text(''),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.image),
            onPressed: () async {
              final path = await Camera().selectPhoto();
              if (path == null) return;
              setState(() {
                photoPath = path;
              });
            },
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            child: const Icon(Icons.camera_alt),
            onPressed: () async {
              final path = await Camera().takePhoto();
              if (path == null) return;
              setState(() {
                photoPath = path;
              });
            },
          ),
        ],
      ),
    );
  }
}
