import 'package:flutter/material.dart';

class DropDownBut extends StatefulWidget {
  const DropDownBut({super.key});

  @override
  State<DropDownBut> createState() => _DropDownButState();
}

class _DropDownButState extends State<DropDownBut> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('13- DropDown Button Widget'),
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
