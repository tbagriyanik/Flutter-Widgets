import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Locale> findSystemLocale() async {
  Locale locale = await window.locale;
  return locale;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final String defaultSystemLocale = Platform.localeName;
  final List<Locale> systemLocales = WidgetsBinding.instance.window.locales;

  // Set the current locale to the user's preferred locale.
  Locale locale = await findSystemLocale();

  print(locale.languageCode + " " + defaultSystemLocale);

  runApp(MyApp(locale: locale));
}

class MyApp extends StatefulWidget {
  late Locale locale;

  MyApp({Key? key, required this.locale}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

enum Languages { Turkish, English }

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;
  TextEditingController _userNameController = TextEditingController();
  bool _switchValue = false;
  String? _savedUserName, _stateMessage = "";

  late String _saveText = "Save", _loadText = "Load", _resetText = "Reset";

  Set<Languages> selection = <Languages>{Languages.English};

  void setLocale(Locale value) {
    setState(() {
      widget.locale = value;
      print(value);
      if (value.languageCode == "Languages.Turkish") {
        _saveText = "Kaydet";
        _loadText = "Yükle";
        _resetText = "Sıfırla";
      }
      if (value.languageCode == "Languages.English") {
        _saveText = "Save";
        _loadText = "Load";
        _resetText = "Reset";
      }
    });
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString('userName');
    bool? switchValue = prefs.getBool('switchValue');

    if (userName != null && userName.isNotEmpty) {
      setState(() {
        _userNameController.text = userName.trim();
        _savedUserName = userName;
        _stateMessage = "Loaded";
        setLocale(Locale.fromSubtags());
      });
    } else {
      setState(() {
        _stateMessage = "No Data";
      });
    }

    if (switchValue != null) {
      setState(() {
        _switchValue = switchValue;
        _themeMode = switchValue ? ThemeMode.dark : ThemeMode.light;
      });
    }
  }

  Future<void> save(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = _userNameController.text.trim();
    bool switchValue = _switchValue;

    if (userName != null && userName.isNotEmpty) {
      await prefs.setString('userName', userName);
      await prefs.setBool('switchValue', switchValue);

      setState(() {
        _savedUserName = userName;
        _themeMode = switchValue ? ThemeMode.dark : ThemeMode.light;
        _stateMessage = "Saved";
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text('You forgot your name!'),
      ));
    }
  }

  Future<void> reset() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = "";
    bool switchValue = false;

    await prefs.clear();
    setState(() {
      _userNameController.text = userName;
      _savedUserName = userName;
      _switchValue = switchValue;
      _themeMode = ThemeMode.light;
      _stateMessage = "Reset";
    });
  }

  void toggleThemeMode() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
      print(_themeMode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', 'US'), // English
        Locale('tr', 'TR'), // Turkish
      ],
      locale: widget.locale,
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      home: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('User Preferences Demo'),
            centerTitle: true,
          ),
          body: Builder(builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: _userNameController,
                    decoration: InputDecoration(labelText: 'Enter your name'),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Color Mode Setting"),
                      Switch(
                        value: _switchValue,
                        onChanged: (value) {
                          toggleThemeMode();
                          setState(() {
                            _switchValue = value;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SegmentedButton<Languages>(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                Colors.lightBlue.shade400)),
                        segments: const <ButtonSegment<Languages>>[
                          ButtonSegment<Languages>(
                              value: Languages.Turkish, label: Text('Tr')),
                          ButtonSegment<Languages>(
                              value: Languages.English, label: Text('Eng')),
                        ],
                        selected: selection,
                        onSelectionChanged: (Set<Languages> newSelection) {
                          setState(() {
                            selection = newSelection;
                            setLocale(Locale.fromSubtags(
                                languageCode: newSelection.first.toString()));
                          });
                        },
                        multiSelectionEnabled: false,
                      )
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          save(context);
                        },
                        child: Text(_saveText),
                      ),
                      SizedBox(width: 5),
                      ElevatedButton(
                        onPressed: () {
                          load();
                        },
                        child: Text(_loadText),
                      ),
                      SizedBox(width: 5),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll<Color>(Colors.red)),
                        onPressed: () {
                          reset();
                        },
                        child: Text(_resetText),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Settings $_stateMessage',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
