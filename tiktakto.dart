import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TikTakTo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'TikTakTo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const double buttonSize = 90;
  static const double fontSize = 44;
  bool gameOver = false;

  List<String> cells = List.filled(9, '');

  final winningConditions = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
    [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
    [0, 4, 8], [2, 4, 6] // Diagonals
  ];

  void cellClick(int index) {
    if (gameOver || cells[index].isNotEmpty) return;

    setState(() {
      cells[index] = "O";
    });
    checkGameOver();
    if (gameOver) return;

    int randomIndex;
    do {
      randomIndex = Random().nextInt(9);
    } while (cells[randomIndex].isNotEmpty);

    setState(() {
      cells[randomIndex] = "X";
    });
    checkGameOver();
  }

  void checkGameOver() {
    for (var condition in winningConditions) {
      if (condition.every((i) => cells[i] == 'X')) {
        showAlertDialog(context, '❌ Ben Kazandım!');
        gameOver = true;
        return;
      } else if (condition.every((i) => cells[i] == 'O')) {
        showAlertDialog(context, '🫠 Sen Kazandın!');
        gameOver = true;
        return;
      }
    }

    if (!cells.contains('')) {
      showAlertDialog(context, '😊 Oyun Berabere');
    }
  }

  void resetGame() {
    setState(() {
      cells = List.filled(9, '');
    });

    int randomIndex = Random().nextInt(9); // 0-8
    setState(() {
      cells[randomIndex] = "X";
    });
    gameOver = false;
  }

  showAlertDialog(BuildContext context, String message) {
    Widget okButton = TextButton(
      child: const Text("Tamam"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(widget.title),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget buildCell(int index) {
    return SizedBox(
      width: buttonSize,
      height: buttonSize,
      child: ElevatedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.lime.shade100,
        ),
        onPressed: () => cellClick(index),
        child: Text(
          cells[index],
          style: const TextStyle(fontSize: fontSize),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    resetGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
        elevation: 2,
      ),
      body: Center(
        child: SizedBox(
          width: 290,
          child: Wrap(
            spacing: 5,
            runSpacing: 5,
            children: List.generate(9, (index) => buildCell(index)),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: resetGame,
        tooltip: 'Yeni',
        child: const Icon(
          Icons.autorenew,
          size: 35,
          color: Colors.black,
        ),
      ),
    );
  }
}
