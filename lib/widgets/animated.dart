import 'package:flutter/material.dart';

class Animated extends StatefulWidget {
  const Animated({super.key});

  @override
  State<Animated> createState() => _AnimatedState();
}

class _AnimatedState extends State<Animated> {
  bool _first = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('9- Animated Widget'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text("◀️ Ana sayfa"),
              ),
            ),
            Column(children: <Widget>[
              Center(child: AnimatedDefaultTextStyleWidget()),
              Center(child: GFG()),
              Center(child: LogoFade()),
              Center(child: AnimatedPhysicalModalWidget()),
            ]),
          ],
        ),
      ),
    );
  }
}

class AnimatedDefaultTextStyleWidget extends StatefulWidget {
  @override
  _AnimatedDefaultTextStyleWidgetState createState() =>
      _AnimatedDefaultTextStyleWidgetState();
}

class _AnimatedDefaultTextStyleWidgetState
    extends State<AnimatedDefaultTextStyleWidget> {
  bool _first = true;
  double _fontSize = 60;
  Color _color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 120,
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                fontSize: _fontSize,
                color: _color,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.bold,
              ),
              child: Text(
                'Yazı Efekti',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _fontSize = _first ? 90 : 60;
                _color = _first ? Colors.blue : Colors.red;
                _first = !_first;
              });
            },
            child: Text(
              "Yazı Efekti için Tıkla",
            ),
          )
        ],
      ),
    );
  }
}

class GFG extends StatefulWidget {
  const GFG({Key? key}) : super(key: key);

  @override
  State<GFG> createState() => _GFGState();
}

class _GFGState extends State<GFG> with TickerProviderStateMixin {
  late AnimationController _controller;
  bool _bool = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: AnimatedCrossFade(
              // First widget
              firstChild: Container(
                height: 100,
                width: 150,
                color: Colors.blue,
              ),
              // Second widget
              secondChild: Container(
                height: 150,
                width: 100,
                color: Colors.yellow,
              ),
              // Parameter to change between two
              // widgets on this basis of value of _bool
              crossFadeState:
                  _bool ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              // Duration for crossFade animation.
              duration: Duration(seconds: 1)),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() => _bool = !_bool);
          },
          child: Text("Kutu Efekti için Tıkla",
              style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}

class LogoFade extends StatefulWidget {
  const LogoFade({super.key});

  @override
  State<LogoFade> createState() => LogoFadeState();
}

class LogoFadeState extends State<LogoFade> {
  double opacityLevel = 1.0;

  void _changeOpacity() {
    setState(() => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AnimatedOpacity(
          opacity: opacityLevel,
          duration: const Duration(seconds: 1),
          child: const FlutterLogo(size: 100),
        ),
        ElevatedButton(
          onPressed: _changeOpacity,
          child: const Text('Logo Efekti için Tıkla'),
        ),
      ],
    );
  }
}

class AnimatedPhysicalModalWidget extends StatefulWidget {
  @override
  _AnimatedPhysicalModalWidgetState createState() =>
      _AnimatedPhysicalModalWidgetState();
}

class _AnimatedPhysicalModalWidgetState
    extends State<AnimatedPhysicalModalWidget> {
  bool _first = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AnimatedPhysicalModel(
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
          elevation: _first ? 0 : 6.0,
          shape: BoxShape.rectangle,
          shadowColor: Colors.black,
          color: Colors.white,
          borderRadius: _first
              ? const BorderRadius.all(Radius.circular(0))
              : const BorderRadius.all(Radius.circular(20)),
          child: Container(
            height: 120.0,
            width: 120.0,
            color: Colors.blue[50],
            child: FlutterLogo(
              size: 50,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
          child: const Text('Efekt için Tıkla'),
          onPressed: () {
            setState(() {
              _first = !_first;
            });
          },
        ),
      ],
    );
  }
}
