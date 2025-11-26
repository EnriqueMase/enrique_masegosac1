import 'package:enrique_masegosac1/l10n/app_localizations.dart';
import 'package:enrique_masegosac1/widgets/drawer.dart';
import 'package:flutter/material.dart';

class PaginaContacto extends StatefulWidget {
  const PaginaContacto({super.key});

  @override
  State<PaginaContacto> createState() => _PaginaContactoState();
}

class _PaginaContactoState extends State<PaginaContacto> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _emailController = TextEditingController();
  final _mensajeController = TextEditingController();

  @override
  void dispose() {
    _nombreController.dispose();
    _emailController.dispose();
    _mensajeController.dispose();
    super.dispose();
  }

  void _enviar() {
    final l10n = AppLocalizations.of(context)!;
    if (!_formKey.currentState!.validate()) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10n.messageSent)));

    _formKey.currentState!.reset();
    _nombreController.clear();
    _emailController.clear();
    _mensajeController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      drawer: Cdrawer(),
      appBar: AppBar(
        title: Text(l10n.contact),
        backgroundColor: const Color.fromARGB(255, 8, 179, 2),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: InputDecoration(
                  labelText: l10n.name,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? l10n.name : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: l10n.email,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _mensajeController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: l10n.message,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? l10n.message : null,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _enviar,
                  child: Text(l10n.sendMessage),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
