import 'package:flutter/material.dart';

class SnakBar extends StatefulWidget {
  const SnakBar({super.key});

  @override
  State<SnakBar> createState() => _SnakBarState();
}

class _SnakBarState extends State<SnakBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('14- SnackBar Widget'),
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
