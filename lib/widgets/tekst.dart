import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Tekst extends StatefulWidget {
  const Tekst({super.key});

  @override
  State<Tekst> createState() => _TekstState();
}

class _TekstState extends State<Tekst> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('11- Text Widget'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text("◀️ Ana sayfa"),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: <Widget>[
                Tooltip(
                  message: "Seçilebilir bir metin",
                  child: SelectionArea(
                    child: Text.rich(
                      TextSpan(
                        text: 'Merhaba ',
                        style: TextStyle(fontSize: 24),
                        children: const <TextSpan>[
                          TextSpan(
                              text: 'güzel',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic)),
                          TextSpan(text: ' Dünya!'),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                DefaultTextStyle.merge(
                  style: GoogleFonts.sacramento(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                  child: const Center(
                    child: Text('Tek Metin'),
                  ),
                ),
                Center(child: AutocompleteExampleApp()),
                SizedBox(height: 10),
                Center(child: SearchTextFieldExample()),
                SizedBox(height: 10),
                Center(child: FormExample()),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class AutocompleteExampleApp extends StatelessWidget {
  const AutocompleteExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
                'Otomatik tamamlama için : ${AutocompleteBasicExample._kOptions}.'),
            const AutocompleteBasicExample(),
          ],
        ),
      ),
    );
  }
}

class AutocompleteBasicExample extends StatelessWidget {
  const AutocompleteBasicExample({super.key});

  static const List<String> _kOptions = <String>[
    'ankara',
    'bursa',
    'eskişehir',
    'istanbul',
    'izmir',
  ];

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return _kOptions.where((String option) {
          return option.contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selection) {
        debugPrint('You just selected $selection');
      },
    );
  }
}

class SearchTextFieldExample extends StatefulWidget {
  const SearchTextFieldExample({super.key});

  @override
  State<SearchTextFieldExample> createState() => _SearchTextFieldExampleState();
}

class _SearchTextFieldExampleState extends State<SearchTextFieldExample> {
  String text = 'Arama yapınız';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(text),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchTextField(
              fieldValue: (String value) {
                setState(() {
                  text = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required this.fieldValue,
  });

  final ValueChanged<String> fieldValue;

  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      prefixIcon: const Icon(CupertinoIcons.search_circle_fill),
      suffixIcon: const Icon(CupertinoIcons.delete),
      backgroundColor: Colors.amberAccent,
      borderRadius: BorderRadius.circular(25.0),
      placeholder: 'Arama',
      onChanged: (String value) {
        fieldValue('Değişen metin: $value');
      },
      onSubmitted: (String value) {
        fieldValue('Yollanan metin: $value');
      },
    );
  }
}

class FormExample extends StatefulWidget {
  const FormExample({super.key});

  @override
  State<FormExample> createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Eposta adresinizi giriniz',
            ),
            autovalidateMode: AutovalidateMode.always,
            controller: myController,
            onFieldSubmitted: (value) {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                if (_formKey.currentState!.validate()) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(myController.text),
                      );
                    },
                  );
                }
              }
            },
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Bir metin girilmedi';
              }
              if (!value.isEmpty &&
                  !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)) {
                return 'Bir eposta girilmedi';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(myController.text),
                      );
                    },
                  );
                }
              },
              child: const Text('Gönder'),
            ),
          ),
        ],
      ),
    );
  }
}
