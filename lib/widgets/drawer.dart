import 'package:flutter/material.dart';

class Drawer1 extends StatelessWidget {
  const Drawer1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('1- Drawer Widget'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text("◀️ Ana sayfa"),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.orange,
                image: DecorationImage(
                    image: AssetImage("assets/wepik1.jpeg"), fit: BoxFit.cover),
              ),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Drawer Header',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 24,
                      ),
                    ),
                    Expanded(
                      child: FlutterLogo(
                        style: FlutterLogoStyle.markOnly,
                        size: 80,
                      ),
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.message, color: Colors.black),
              title: Text('Mesajlar'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle, color: Colors.black),
              title: Text('Profil'),
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.black),
              title: Text('Ayarlar'),
            ),
            ListTile(
                leading: Icon(Icons.arrow_back, color: Colors.black),
                title: Text('Geri'),
                onTap: () => Navigator.pop(context)),
          ],
        ),
      ),
    );
  }
}
