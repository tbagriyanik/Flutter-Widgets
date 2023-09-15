import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:blurry/blurry.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Kod Örnekleri',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Kod Örnekleri'),
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
  void _appExit() {
    exit(0);
  }

  Future<void> runAsyncOperation() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Async Başladı!'),
      ),
    );
    await Future.delayed(Duration(seconds: 2)).then((_) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 3),
          content: Text('Async Bitti!'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                  child: Text("1- Merhaba print"),
                  onPressed: () {
                    print("Merhaba Dünya");
                  }),
              ElevatedButton(
                  onPressed: onPressed2, child: Text("2- Toast Mesajı")),
              ElevatedButton(
                  onPressed: onPressed3, child: Text("3- Snackbar Mesajı")),
              ElevatedButton(
                  onPressed: onPressed4, child: Text("4- Alert ve Blurry")),
              ElevatedButton(
                  onPressed: onPressed5, child: Text("5- for komutu")),
              ElevatedButton(onPressed: onPressed6, child: Text("6- ListView")),
              ElevatedButton(onPressed: onPressed7, child: Text("7- Class")),
              ElevatedButton(onPressed: onPressed8, child: Text("8- Async 1")),
              ElevatedButton(onPressed: onPressed7, child: Text("9- ")),
              ElevatedButton(onPressed: onPressed7, child: Text("10- ")),
              ElevatedButton(onPressed: onPressed7, child: Text("11- ")),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _appExit,
        tooltip: 'Çıkış',
        elevation: 4,
        shape: CircleBorder(side: BorderSide.none, eccentricity: 1),
        child: const Icon(Icons.exit_to_app),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Vazgeç"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = ElevatedButton(
      style:
          ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.pink)),
      child: Text(
        "Tamam",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        Blurry.info(
            title: 'Blurry',
            description: 'Kabul ettiniz',
            confirmButtonText: 'Evet',
            cancelButtonText: 'Hayır',
            titleTextStyle: const TextStyle(fontFamily: 'Zen'),
            popupHeight: 180,
            buttonTextStyle: const TextStyle(fontFamily: 'Zen'),
            descriptionTextStyle: const TextStyle(fontFamily: 'Zen'),
            onConfirmButtonPressed: () {
              Navigator.of(context).pop();
            }).show(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert Dialog"),
      content: Text(
        "Bir soru soralım",
        style: GoogleFonts.acme(),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogList(BuildContext context) {
    // set up the buttons
    Widget kapatButon = TextButton(
      child: Text("Kapat"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    final List<String> liste = [
      'Ankara',
      'İstanbul',
      'İzmir',
      'Bursa',
      'Konya'
    ];

    TextEditingController textController = TextEditingController();
    ScrollController listeKutusu = ScrollController();

    void _addToList() {
      setState(() {
        liste.add(textController.text);
        textController.clear();
        //listeKutusu.position;
      });
    }

    AlertDialog alert = AlertDialog(
      title: Text("ListView"),
      content: Container(
        width: 200,
        height: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                controller: listeKutusu,
                itemCount: liste.length,
                itemBuilder: (context, index) {
                  // Satırın arka plan rengini hesaplayın
                  Color rowColor =
                      index % 2 == 0 ? Colors.lightGreen : Colors.lime;

                  return Container(
                    color: rowColor,
                    child: ListTile(
                      title: Text(
                        liste[index],
                        style: TextStyle(color: Colors.deepPurple),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: textController,
                      decoration: InputDecoration(
                        hintText: 'Şehir Ekle',
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _addToList,
                    child: Text('Ekle'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [kapatButon],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void onPressed2() {
    Fluttertoast.showToast(
        msg: "Merhaba Dünya 2 - Fluttertoast",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.greenAccent,
        textColor: Colors.black,
        fontSize: 12.0);
  }

  void onPressed3() {
    var snackBar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Merhaba Dünya 3 - SnackBar',
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(width: 20),
          TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              child: Text("Kapat"))
        ],
      ),
      backgroundColor: Colors.greenAccent,
    );
    // Step 3
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void onPressed4() {
    showAlertDialog(context);
  }

  void onPressed5() {
    String sonuc = "";

    for (var i = 0; i < 5; i++) {
      print(i);
      sonuc += i.toString() + " ";
    }
    sonuc += "\n";

    List<String> isimler = ['Ahmet', 'Ayşe', 'Zeynep'];
    for (var isim in isimler) {
      print(isim);
      sonuc += isim + " ";
    }

    Fluttertoast.showToast(
        msg: "$sonuc",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.greenAccent,
        textColor: Colors.black,
        fontSize: 10.0);
  }

  void onPressed6() {
    showAlertDialogList(context);
  }

  void onPressed7() {
    var ogrenci1 = Ogrenci("Ali", 20);
    ogrenci1.selamVer();
  }

  void onPressed8() {
    runAsyncOperation();
  }
}

class Ogrenci {
  String ad;
  int yas;

  Ogrenci(this.ad, this.yas);

  void selamVer() {
    Fluttertoast.showToast(msg: "Merhaba, ben $ad ve $yas yaşındayım.");
  }
}
