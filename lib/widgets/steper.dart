import 'package:flutter/material.dart';

class Stepci extends StatefulWidget {
  const Stepci({super.key});

  @override
  State<Stepci> createState() => _StepciState();
}

class _StepciState extends State<Stepci> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('15- Stepper Widget'),
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
