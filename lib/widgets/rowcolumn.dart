import 'package:flutter/material.dart';

class RowColumn extends StatefulWidget {
  const RowColumn({super.key});

  @override
  State<RowColumn> createState() => _RowColumnState();
}

class _RowColumnState extends State<RowColumn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('8- Row Column Widgets'),
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
          Divider(
            thickness: 2,
          ),
          Row(
            children: <Widget>[
              Card(
                margin: EdgeInsets.all(4),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      Text('İlk sütundaki bilgi', textAlign: TextAlign.center),
                ),
              ),
              Card(
                margin: EdgeInsets.all(4),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('İkinci sütundaki bilgi',
                      textAlign: TextAlign.center),
                ),
              ),
              Expanded(
                child: FlutterLogo(
                  size: 90,
                ),
              ),
            ],
          ),
          Divider(
            thickness: 2,
          ),
          Expanded(
              child: Column(
            children: <Widget>[
              Card(
                margin: EdgeInsets.all(4),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      Text('İlk satırdaki bilgi', textAlign: TextAlign.center),
                ),
              ),
              Card(
                margin: EdgeInsets.all(4),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('İkinci satırdaki bilgi',
                      textAlign: TextAlign.center),
                ),
              ),
              Center(
                child: FlutterLogo(
                  size: 90,
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
