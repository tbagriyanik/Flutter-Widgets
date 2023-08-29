import 'package:flutter/material.dart';

class Alertim extends StatelessWidget {
  const Alertim({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('4- Alert Dialog'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: DialogExample(),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("◀️ Ana sayfa"),
            ),
          )
        ],
      ),
    );
  }
}

class DialogExample extends StatelessWidget {
  const DialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 2,
          foregroundColor: Colors.pink),
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Diyalog Başlığı'),
          content: const Text('Diyalog içeriği'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Vazgeç'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('Tamam'),
            ),
          ],
        ),
      ),
      child: const Text('Diyalog Göster'),
    );
  }
}
