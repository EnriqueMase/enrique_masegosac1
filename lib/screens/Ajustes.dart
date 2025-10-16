import 'package:enrique_masegosac1/widgets/drawer.dart';
import 'package:flutter/material.dart';

class Ajustes extends StatefulWidget {
  const Ajustes({super.key});

  @override
  State<Ajustes> createState() => _AjustesState();
}

class _AjustesState extends State<Ajustes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Cdrawer(),
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.settings),
            SizedBox(width: 10),
            const Text("Ajustes"),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 8, 179, 2),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              "Ajustes de la App",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 35),
            const Image(
              image: AssetImage('/images/Bob.png'),
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            const Text(
              "Aquí puedes configurar los ajustes de la aplicación.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
