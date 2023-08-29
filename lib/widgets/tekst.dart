import 'package:flutter/material.dart';

class Tekst extends StatefulWidget {
  const Tekst({super.key});

  @override
  State<Tekst> createState() => _TekstState();
}

class _TekstState extends State<Tekst> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('11- Text Widget'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text("◀️ Ana sayfa"),
        ),
      ),
    );
  }
}
