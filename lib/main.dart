import 'dart:async';

import 'package:flutter/material.dart';
import 'package:widgets/assets/mycolors.dart';
import 'package:widgets/widgets/app_bar.dart';
import 'package:widgets/widgets/bottomnavigation.dart';
import 'package:widgets/widgets/buttonlar.dart';
import 'package:widgets/widgets/drawer.dart';
import 'package:widgets/widgets/dropdownbutton.dart';
import 'package:widgets/widgets/floatbut.dart';
import 'package:widgets/widgets/imageicon.dart';
import 'package:widgets/widgets/kart.dart';
import 'package:widgets/widgets/popmenu.dart';
import 'package:widgets/widgets/rowcolumn.dart';
import 'package:widgets/widgets/snakbar.dart';
import 'package:widgets/widgets/steper.dart';
import 'package:widgets/widgets/tekst.dart';

import 'widgets/alertd.dart';
import 'widgets/animated.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SecondScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.renk5,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            Expanded(
              child: FlutterLogo(size: MediaQuery.of(context).size.width),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: TextButton(
                  onPressed: () => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SecondScreen())),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      "Hoş Geldiniz",
                      style: TextStyle(fontSize: 20),
                    ),
                  )),
            )
          ]),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text("Flutter Widget Örnekleri")),
      body: SafeArea(
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      "Widget Listesi",
                      textScaleFactor: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: MyColors.renk2,
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.amberAccent,
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Drawer1())),
                      child: Text("1- Drawer"),
                    ),
                    SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => PopMenum())),
                      child: Text("2- Popup Menu Button"),
                    ),
                    SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => BottomNav())),
                      child: Text("3- Bottom Navigation Bar"),
                    ),
                    SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Alertim())),
                      child: Text("4- Alert Dialog"),
                    ),
                    SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => FloatButt())),
                      child: Text("5- Floating Action Button"),
                    ),
                    SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImageIconu())),
                      child: Text("6- Icon Image"),
                    ),
                    SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Butonlar())),
                      child: Text("7- Button"),
                    ),
                    SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => RowColumn())),
                      child: Text("8- Row Column"),
                    ),
                    SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Animated())),
                      child: Text("9- Animated Widget"),
                    ),
                    SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AppBarApp())),
                      child: Text("10- AppBar"),
                    ),
                    SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Tekst())),
                      child: Text("11- Text"),
                    ),
                    SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Kart())),
                      child: Text("12- Card"),
                    ),
                    SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DropDownBut())),
                      child: Text("13- Dropdown Button"),
                    ),
                    SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SnakBar())),
                      child: Text("14- Snackbar"),
                    ),
                    SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Stepci())),
                      child: Text("15- Stepper"),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
