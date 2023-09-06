import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Tasarım'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 1;

  void _incrementCounter() {
    setState(() {
      _counter = Random().nextInt(5) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 6,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.description_outlined, color: Colors.white),
            const SizedBox(width: 20),
            Text(
              widget.title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
        // popup menu button
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              // popupmenu item 1
              const PopupMenuItem(
                value: 1,
                // row has two child icon and text.
                child: Row(
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    SizedBox(
                      // sized box with width 10
                      width: 10,
                    ),
                    Text("Beğen"),
                  ],
                ),
              ),
              // popupmenu item 2
              const PopupMenuItem(
                value: 2,
                // row has two child icon and text
                child: Row(
                  children: [
                    Icon(Icons.chrome_reader_mode),
                    SizedBox(
                      // sized box with width 10
                      width: 10,
                    ),
                    Text("Hakkında")
                  ],
                ),
              ),
            ],
            offset: const Offset(0, 50),
            color: Colors.white30,
            elevation: 2,
            splashRadius: 20,
            onSelected: (value) {
              if (value == 1) {
                const snackBar = SnackBar(
                  content: Text('Menü değeri  1'),
                  duration: Duration(seconds: 2),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
              if (value == 2) {
                const snackBar = SnackBar(
                  content: Text('Menü değeri  2'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Table(
                  textBaseline: TextBaseline.alphabetic,
                  //border: TableBorder.all(color: Colors.red, width: 0.5),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: const [
                    TableRow(
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      children: [
                        Text("Sıra No",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                        Text("Adı",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                        Text("Telefon",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                            verticalAlignment: TableCellVerticalAlignment.fill,
                            child: Text("1",
                                style: TextStyle(fontStyle: FontStyle.italic),
                                textAlign: TextAlign.right)),
                        TableCell(
                            verticalAlignment: TableCellVerticalAlignment.top,
                            child: Text("Ali")),
                        TableCell(
                            verticalAlignment: TableCellVerticalAlignment.top,
                            child: Text("1232",
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.right)),
                      ],
                    )
                  ],
                ),
              ),
              DataTable(
                dataRowColor: MaterialStateProperty.all(Colors.grey[100]),
                sortColumnIndex: 1,
                dataRowMinHeight: 20,
                columns: const <DataColumn>[
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Ad',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  DataColumn(
                    numeric: true,
                    label: Expanded(
                      child: Text(
                        'Yaş',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Rol',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                ],
                rows: <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      DataCell(const Text('Sarah')),
                      DataCell(const Text('9')),
                      DataCell(
                        showEditIcon: true,
                        Text('Student'),
                        onTap: () {
                          print("edit");
                          const snackBar = SnackBar(
                            content: Text('Öğrenci tıklandı'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                      ),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('Janine')),
                      DataCell(Text('43')),
                      DataCell(Text('Professor')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(
                        const Text(
                          'William',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.wavy,
                            decorationColor: Colors.blue,
                            decorationThickness: 2.5,
                          ),
                        ),
                        onTap: () {
                          print("edit");
                          const snackBar = SnackBar(
                            content: Text('William tıklandı'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                      ),
                      DataCell(Text('27')),
                      DataCell(Text('Associate Professor')),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                'Rasgele $_counter',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Image.asset('images/ball$_counter.png', width: 300),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        shape: const CircleBorder(),
        elevation: 20,
        backgroundColor: Colors.black,
        child: const Icon(Icons.radar_outlined, color: Colors.blue),
      ),
    );
  }
}
