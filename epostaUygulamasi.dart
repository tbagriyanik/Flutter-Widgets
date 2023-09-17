import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final theme = ThemeData.dark();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme.copyWith(
        useMaterial3: true,
        colorScheme: theme.colorScheme.copyWith(
          secondary: Colors.lightBlue,
        ),
      ),
      home: const MyHomePage(title: 'Eposta Uygulaması'),
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
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Epostalar',
      style: optionStyle,
    ),
    Text(
      'Konferans',
      style: optionStyle,
    ),
    Text(
      'Ayarlar',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.title),
            IconButton(
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Profil'),
                  content: const Text('Profil Bilgileriniz'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Vazgeç'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Tamam'),
                    ),
                  ],
                ),
              ),
              icon: Icon(
                Icons.accessibility_sharp,
                color: Colors.orange,
                size: 35,
                shadows: <Shadow>[
                  Shadow(color: Colors.black, blurRadius: 25.0)
                ],
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: FlutterLogo(size: 100),
          ),
          SizedBox(height: 20),
          Center(
            child: _widgetOptions[_selectedIndex],
          ),
          Center(
            child: Text("Gelen Kutusu boş"),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 90,
              child: const DrawerHeader(
                curve: Curves.bounceInOut,
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Eposta'),
              ),
            ),
            ListTile(
              title: const Text('Epostalar'),
              leading: Icon(Icons.mail),
              selected: _selectedIndex == 0,
              onTap: () {
                // Update the state of the app
                _onItemTapped(0);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Konferans'),
              leading: Icon(Icons.videocam),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(1);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              title: const Text('Ayarlar'),
              leading: Icon(Icons.settings),
              selected: _selectedIndex == 2,
              onTap: () {
                // Update the state of the app
                _onItemTapped(2);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .endDocked, //specify the location of the FAB
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Eposta Oluştur'),
            content: const Text('Eposta Bilgileriniz'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Vazgeç'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Tamam'),
              ),
            ],
          ),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(17))),
        tooltip: "Yeni",
        backgroundColor: Colors.blueAccent,
        child: Container(
            margin: EdgeInsets.all(5.0),
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return RadialGradient(
                  center: Alignment.center,
                  radius: 1,
                  colors: [
                    Colors.white,
                    Colors.lightGreenAccent,
                    Colors.yellow
                  ],
                  tileMode: TileMode.mirror,
                ).createShader(bounds);
              },
              child: Column(
                children: [
                  Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 25,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Oluştur",
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
            )),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 60,
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  _onItemTapped(0);
                },
                iconSize: 20.0,
                highlightColor: Colors.orangeAccent,
                style: (_selectedIndex == 0)
                    ? IconButton.styleFrom(
                        backgroundColor: Colors.blue.shade200)
                    : IconButton.styleFrom(backgroundColor: Colors.transparent),
                icon: Icon(
                  Icons.mail,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  _onItemTapped(1);
                },
                iconSize: 20.0,
                highlightColor: Colors.orangeAccent,
                style: (_selectedIndex == 1)
                    ? IconButton.styleFrom(
                        backgroundColor: Colors.blue.shade200)
                    : IconButton.styleFrom(backgroundColor: Colors.transparent),
                icon: Icon(
                  Icons.videocam,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 50.0,
              ),
            ],
          ),
        ),
        notchMargin: 5,
        clipBehavior: Clip.antiAlias,
        color: Colors.blue.shade700,
        shape: AutomaticNotchedShape(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
            ),
          ),
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(23),
            ),
          ),
        ),
      ),
    );
  }
}
