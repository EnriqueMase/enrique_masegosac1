import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class Musica {
  static final AudioPlayer _audioPlayer = AudioPlayer();
  static String? _localFilePath;

  // la linea de abajo es para el volumen
  static Future<void> reproducirLoop({double volumen = 0.2}) async {
    try {
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
      await _audioPlayer.setVolume(volumen);

      if (_localFilePath != null) {
        await _audioPlayer.play(DeviceFileSource(_localFilePath!));
      } else {
        await _audioPlayer.play(AssetSource('music/applepay.mp3'));
        print('Reproduciendo sonido de fondo en loop...');
      }
    } catch (e) {
      print('Error al reproducir en loop: $e');
    }
  }

  // Reproduce una sola vez.
  static Future<void> reproducir() async {
    try {
      await _audioPlayer.setReleaseMode(ReleaseMode.stop);
      if (_localFilePath != null) {
        await _audioPlayer.play(DeviceFileSource(_localFilePath!));
      } else {
        await _audioPlayer.play(AssetSource('music/applepay.mp3'));
        print('Reproduciendo sonido de inicio de sesion...');
      }
    } catch (e) {
      print('Error al reproducir: $e');
    }
  }

  static Future<void> pausar() async {
    try {
      await _audioPlayer.pause();
      print('Musica pausada.');
    } catch (e) {
      print('Error al pausar: $e');
    }
  }

  // Detiene y quita el loop.
  static Future<void> parar() async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.setReleaseMode(ReleaseMode.stop);
      print('Musica detenida.');
    } catch (e) {
      print('Error al detener: $e');
    }
  }

  // Permite elegir un archivo de musica y lo guarda como pista actual.
  static Future<String> anadirMusica() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav', 'aac'],
    );

    if (result != null && result.files.isNotEmpty) {
      final filePath = result.files.single.path!;
      _localFilePath = filePath;
      return 'Se ha cargado la musica correctamente';
    } else {
      return 'No se ha seleccionado ningun archivo de musica.';
    }
  }

  // Helper para usar desde la UI (por ejemplo, un boton en Ajustes).
  void cargarMusica(BuildContext context) async {
    final audioCargado = await Musica.anadirMusica();
    final snackBar = SnackBar(content: Text(audioCargado));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
