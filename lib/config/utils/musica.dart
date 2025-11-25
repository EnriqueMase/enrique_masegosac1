import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class Musica {
  static final AudioPlayer _audioPlayer = AudioPlayer();
  static String? _localFilePath;

  /// Reproduce la música actual.
  /// - Si hay archivo local seleccionado -> lo usa.
  /// - Si no -> reproduce el asset por defecto.
  static Future<void> reproducir() async {
    try {
      if (_localFilePath != null) {
        await _audioPlayer.play(DeviceFileSource(_localFilePath!));
      } else {
        await _audioPlayer.play(AssetSource('music/applepay.mp3'));
        print('Reproduciendo sonido de inicio de sesión...');
      }
    } catch (e) {
      print('Error al reproducir la música: $e');
    }
  }

  /// Pausa la música actual.
  static Future<void> pausar() async {
    try {
      await _audioPlayer.pause();
      print('⏸ Música pausada.');
    } catch (e) {
      print('Error al pausar la música: $e');
    }
  }

  /// Permite elegir un archivo de música y lo guarda como pista actual.
  /// Devuelve un mensaje para mostrar al usuario.
  static Future<String> anadirMusica() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav', 'aac'],
    );

    if (result != null && result.files.isNotEmpty) {
      final filePath = result.files.single.path!;
      _localFilePath = filePath;
      return 'Se ha cargado la música correctamente';
    } else {
      return 'No se ha seleccionado ningún archivo de música.';
    }
  }

  /// Helper para usar desde la UI (por ejemplo, un botón en Ajustes).
  void cargarMusica(BuildContext context) async {
    final audioCargado = await Musica.anadirMusica();
    final snackBar = SnackBar(content: Text(audioCargado));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
