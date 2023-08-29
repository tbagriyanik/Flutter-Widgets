import 'package:flutter/material.dart';

class ImageIconu extends StatelessWidget {
  const ImageIconu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('6- Icon Image Widget'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(
                    Icons.favorite,
                    color: Colors.pink,
                    size: 36.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                  Icon(
                    Icons.audiotrack,
                    color: Colors.green,
                    size: 36.0,
                  ),
                  Icon(
                    Icons.beach_access,
                    color: Colors.blue,
                    size: 36.0,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
              )),
              SizedBox(
                height: 10,
              ),
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset('lib/assets/wepik1.jpeg'),
                ),
              )),
              SizedBox(
                height: 10,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("◀️ Ana sayfa"),
                ),
              ),
            ],
          ),
        ));
  }
}
