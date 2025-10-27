import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class Music {
  static final AudioPlayer audioPlayer = AudioPlayer();
  static String? _localFilePath;

  static Future<void> reproducir() async {
    try {
      if (_localFilePath != null) {
        await audioPlayer.play(DeviceFileSource(_localFilePath!));
      } else {
        await audioPlayer.play(AssetSource('assets/music/golden.mp3'));
        print('Reproduciendo música...');
      }
    } catch (e) {
      print('Error al reproducir la música: $e');
    }
  }

  static Future<void> pausar() async {
    try {
      await audioPlayer.pause();
      print('⏸ Música pausada.');
    } catch (e) {
      print('Error al pausar la música: $e');
    }
  }

  static Future<String> anadirMusica() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav', 'aac'],
    );

    if (result != null && result.files.isNotEmpty) {
      final filePath = result.files.single.path!;
      _localFilePath = filePath;
      return "Se ha cargado la musica correctamente";
    } else {
      print('Error al seleccionar el archivo de música.');
      return '';
    }
  }

  void cargarMusica(BuildContext context) async {
    String audioCargado = await Music.anadirMusica();
    var snackBar = SnackBar(content: Text(audioCargado));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // ignore: unused_element
  void _reproducir() async {
    await Music.reproducir();
  }

  // ignore: unused_element
  void _pausar() async {
    await Music.pausar();
  }
}
