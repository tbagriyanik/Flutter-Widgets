import 'package:flutter/material.dart';

class Kart extends StatefulWidget {
  const Kart({super.key});

  @override
  State<Kart> createState() => _KartState();
}

class _KartState extends State<Kart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('12- Card Widget'),
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
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Center(
              child: Card(
                elevation: 2,
                color: Colors.orange[50],
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      leading: Icon(
                        Icons.album,
                        color: Colors.blueGrey,
                        size: 50,
                      ),
                      title: Text('The Enchanted Nightingale'),
                      subtitle:
                          Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: TextButton(
                            child: const Text('BİLET AL'),
                            onPressed: () {
                              /* ... */
                            },
                          ),
                        ),
                        const VerticalDivider(
                          width: 20,
                          thickness: 1,
                          indent: 20,
                          endIndent: 0,
                          color: Colors.grey,
                        ),
                        Expanded(
                          child: TextButton(
                            child: const Text('DİNLE'),
                            onPressed: () {
                              /* ... */
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
