import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:blurry/blurry.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  ///Future
  Future<void> runAsyncOperation() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        duration: const Duration(seconds: 3),
        content: const Text('Async Başladı!'),
      ),
    );
    await Future.delayed(const Duration(seconds: 2)).then((_) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 3),
          content: Text('Async Bitti!'),
        ),
      );
    });
  }

  ///Completer
  late Completer<void> _completer;
  bool _isCompleterRunning = false;

  Future<void> _longRunningCompleter() async {
    _completer = Completer<void>();

    for (int i = 0; i < 100000000; i++) {
      if (_completer.isCompleted) {
        print('Görev Durduruldu!');
        return;
      }
      await Future.delayed(Duration(milliseconds: 10));
    }

    if (!_completer.isCompleted) {
      print('Görev Tamamlandı');
    }
  }

  void _startCompleter() {
    setState(() {
      _isCompleterRunning = true;
    });

    _longRunningCompleter().then((_) {
      setState(() {
        _isCompleterRunning = false;
      });
    });
  }

  void _cancelCompleter() {
    if (!_completer.isCompleted) {
      _completer.complete(); // Cancel the task
    }
  }

  void _toggleCompleter() {
    if (_isCompleterRunning) {
      // Cancel the task
      if (!_completer.isCompleted) {
        _completer.complete();
      }
    } else {
      // Start the task
      _isCompleterRunning = true;
      _longRunningCompleter().then((_) {
        setState(() {
          _isCompleterRunning = false;
        });
      });
    }
  }

  //Isolate
  late Isolate _isolate;
  String _taskStatus = '10a kadar';

  void _startTask() async {
    final receivePort = ReceivePort();

    _isolate = await Isolate.spawn(_longRunningTask, receivePort.sendPort);

    receivePort.listen((message) {
      setState(() {
        _taskStatus = message;
      });
    });
  }

  static void _longRunningTask(SendPort sendPort) {
    // Simulate a long-running task
    for (int i = 0; i <= 10; i++) {
      sleep(Duration(seconds: 1)); // Simulate work for 1 second
      sendPort.send('Durum: $i');
    }
    sendPort.send('Görev 👌');
  }

  void _cancelTask() {
    if (_isolate != null) {
      _isolate.kill(priority: Isolate.immediate);
      setState(() {
        _taskStatus = 'Görev ❌';
      });
    }
  }

  @override
  void dispose() {
    _cancelTask();
    super.dispose();
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const SizedBox(height: 5),
              ElevatedButton(
                  child: const Text("1- Merhaba print"),
                  onPressed: () {
                    print("Merhaba Dünya");
                  }),
              const SizedBox(height: 5),
              ElevatedButton(
                  onPressed: onPressed2, child: const Text("2- Toast Mesajı")),
              const SizedBox(height: 5),
              ElevatedButton(
                  onPressed: onPressed3,
                  child: const Text("3- Snackbar Mesajı")),
              const SizedBox(height: 5),
              ElevatedButton(
                  onPressed: onPressed4,
                  child: const Text("4- Alert ve Blurry")),
              const SizedBox(height: 5),
              ElevatedButton(
                  onPressed: onPressed5, child: const Text("5- for döngüsü")),
              const SizedBox(height: 5),
              ElevatedButton(
                  onPressed: onPressed6, child: const Text("6- ListView")),
              const SizedBox(height: 5),
              ElevatedButton(
                  onPressed: onPressed7, child: const Text("7- Class")),
              const SizedBox(height: 5),
              ElevatedButton(
                  onPressed: onPressed8, child: const Text("8- Async")),
              const SizedBox(height: 5),
              ElevatedButton(
                  onPressed: onPressed9, child: const Text("9- Map")),
              const SizedBox(height: 5),
              ElevatedButton(
                  onPressed: onPressed10, child: const Text("10- List")),
              const SizedBox(height: 5),
              Container(
                //onPressed: _toggleTask,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _isCompleterRunning
                        ? SizedBox(
                            child: Padding(
                                padding: EdgeInsets.all(10),
                                child: CircularProgressIndicator()),
                            height: 35.0,
                            width: 35.0,
                          )
                        : ElevatedButton(
                            onPressed: _startCompleter,
                            child: Text('11- Completer Başlat'),
                          ),
                    SizedBox(height: 10),
                    if (_isCompleterRunning)
                      ElevatedButton(
                        onPressed: _cancelCompleter,
                        child: Text('11- Completer Durdur'),
                      ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _startTask,
                    child: Text('12- Isolate Başlat'),
                  ),
                  SizedBox(width: 5),
                  ElevatedButton(
                    onPressed: _cancelTask,
                    child: Text('Durdur'),
                  ),
                  SizedBox(width: 5),
                  Text(_taskStatus),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _appExit,
        tooltip: 'Çıkış',
        elevation: 4,
        shape: const CircleBorder(side: BorderSide.none, eccentricity: 1),
        child: const Icon(Icons.exit_to_app),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Vazgeç"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = ElevatedButton(
      style:
          ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.pink)),
      child: const Text(
        "Tamam",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        Blurry.info(
            title: 'Blurry Başlığı',
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
      title: const Text("Uyarı Kutusu"),
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
      child: const Text("Kapat"),
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

    void addToListFunction() {
      setState(() {
        liste.add(textController.text);
        textController.clear();
        //listeKutusu.position;
      });
    }

    AlertDialog alert = AlertDialog(
      title: const Text("ListView"),
      content: SizedBox(
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
                        style: const TextStyle(color: Colors.deepPurple),
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
                      decoration: const InputDecoration(
                        hintText: 'Şehir Ekle',
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: addToListFunction,
                    child: const Text('Ekle'),
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
          const Text(
            'Merhaba Dünya 3 - SnackBar',
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(width: 20),
          TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              child: const Text("Kapat"))
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
      sonuc += "$i ";
    }
    sonuc += "\n";

    List<String> isimler = ['Ahmet', 'Ayşe', 'Zeynep'];
    for (var isim in isimler) {
      print(isim);
      sonuc += "$isim ";
    }

    Fluttertoast.showToast(
        msg: sonuc,
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
    var ogrenci1 = OgrenciClass("Ali", 20);
    ogrenci1.selamVer();
  }

  void onPressed8() {
    runAsyncOperation();
  }

  void onPressed9() {
    Map<String, int> urunler = {
      'Patates': 90,
      'Domates': 85,
      'Soğan': 78,
      'Karpuz': 92,
    };
    String sonuc = "Ürün Listesi (Map)\n";
    urunler.forEach((key, value) {
      sonuc = '$sonuc $key: $value, ';
    });

    Fluttertoast.showToast(
        msg: sonuc,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP_LEFT,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.greenAccent,
        textColor: Colors.black,
        fontSize: 10.0);
  }

  void onPressed10() {
    List<OgrenciClass> ogrenciler = [
      OgrenciClass("Ali", 22),
      OgrenciClass("Ahmet", 21),
      OgrenciClass("Hüsnü", 20),
      OgrenciClass("Fadime", 23),
    ];
    String sonuc = "Öğrenci Listesi (List)\n";
    for (var ogrenci in ogrenciler) {
      sonuc = '$sonuc ${ogrenci.ad}: ${ogrenci.yas}, ';
    }

    Fluttertoast.showToast(
        msg: sonuc,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP_LEFT,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.greenAccent,
        textColor: Colors.black,
        fontSize: 10.0);
  }
}

class OgrenciClass {
  String ad;
  int yas;

  OgrenciClass(this.ad, this.yas);

  void selamVer() {
    Fluttertoast.showToast(msg: "Merhaba, ben $ad ve $yas yaşındayım.");
  }
}
