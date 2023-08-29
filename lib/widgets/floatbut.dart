import 'package:flutter/material.dart';

class FloatButt extends StatefulWidget {
  const FloatButt({super.key});

  @override
  State<FloatButt> createState() => _FloatButtState();
}

class _FloatButtState extends State<FloatButt> {
  static const List<(Color?, Color? background, ShapeBorder?)> customizations =
      <(Color?, Color?, ShapeBorder?)>[
    (
      null,
      null,
      RoundedRectangleBorder()
    ), // The FAB uses its default for null parameters.
    (null, Colors.green, BeveledRectangleBorder()),
    (Colors.white, Colors.green, CircleBorder()),
    (Colors.white, Colors.deepOrange, CircleBorder()),
  ];
  int index = 0; // Selects the customization.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('5- FloatingActionButton Widget'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            index = (index + 1) % customizations.length;
          });
        },
        foregroundColor: customizations[index].$1,
        backgroundColor: customizations[index].$2,
        shape: customizations[index].$3,
        child: const Icon(Icons.navigation),
        tooltip: "Tıkla",
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text("◀️ Ana sayfa"),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
