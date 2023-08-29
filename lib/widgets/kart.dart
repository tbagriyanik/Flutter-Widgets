import 'package:flutter/material.dart';

class Kart extends StatefulWidget {
  const Kart({super.key});

  @override
  State<Kart> createState() => _KartState();
}

class _KartState extends State<Kart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('12- Card Widget'),
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
