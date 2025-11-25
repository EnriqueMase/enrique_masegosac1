import 'package:flutter/material.dart';
import 'package:enrique_masegosac1/widgets/drawer.dart';

class Ajustes extends StatefulWidget {
  const Ajustes({super.key});

  @override
  State<Ajustes> createState() => _AjustesState();
}

class _AjustesState extends State<Ajustes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Cdrawer(),
      appBar: AppBar(backgroundColor: const Color.fromARGB(255, 8, 179, 2)),
      body: Center(
        child: Column(
          children: const [
            SizedBox(height: 20),
            Text(
              'Ajustes de la App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 35),
            Image(
              image: AssetImage('assets/images/Bob.png'),
              width: 200,
              height: 200,
            ),
            SizedBox(height: 20),
            Text(
              'Aquí puedes configurar los ajustes de la aplicación.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
