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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("◀️ Ana sayfa"),
            ),
          ),
          SnackBarExample(),
          SnackBarExample2(),
        ],
      ),
    );
  }
}

class SnackBarExample extends StatelessWidget {
  const SnackBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Snackbar1 göster'),
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Süper Snackbar1'),
            backgroundColor: Colors.deepPurpleAccent,
            showCloseIcon: true,
            action: SnackBarAction(
              label: 'İşlem Yap',
              onPressed: () {
                // Code to execute.
                print("İşlem");
              },
            ),
          ),
        );
      },
    );
  }
}

class SnackBarExample2 extends StatelessWidget {
  const SnackBarExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Snackbar2 göster'),
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            action: SnackBarAction(
              textColor: Colors.brown,
              label: 'İşlem Yap',
              onPressed: () {
                // Code to execute.
              },
            ),
            backgroundColor: Colors.green,
            elevation: 8,
            clipBehavior: Clip.antiAlias,
            content: const Text(
              'Süper SnackBar2 \n 3 saniyelik',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            duration: const Duration(milliseconds: 3000),
            //width: 330.0,
            margin: EdgeInsets.fromLTRB(10, 10, 10, 30),
            // Width of the SnackBar.
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0, // Inner padding for SnackBar content.
            ),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        );
      },
    );
  }
}
