import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Dikkat
// pubspec.yaml içine   sqflite: eklenmelidir

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyData {
  final int id;
  final String name;
  final String email;

  MyData({required this.id, required this.name, required this.email});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }

  factory MyData.fromMap(Map<String, dynamic> map) {
    return MyData(
      id: map['id'],
      name: map['name'],
      email: map['email'],
    );
  }
}

class DatabaseHelper {
  Database? _database;

  Future<Database> get db async => _database ??= await initDatabase();

  Future<Database> initDatabase() async {
    final dbPath = await getDatabasesPath();
    const dbName = 'my_database.db';
    final path = join(dbPath, dbName);

    final database = await openDatabase(path, onCreate: (db, version) async {
      await db.execute('''
      CREATE TABLE my_table (
        id INTEGER PRIMARY KEY,
        name TEXT,
        email TEXT
      )
    ''');

      await db.insert(
        'my_table',
        {'name': 'John', 'email': 'john@example.com'},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      await db.insert(
        'my_table',
        {'name': 'Ahmet', 'email': 'ahmet@example.com'},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      await db.insert(
        'my_table',
        {'name': 'Ali', 'email': 'ali@example.com'},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }, version: 1);

    return database;
  }

  Future<int> insertData(Map<String, dynamic> data) async {
    final db = await this.db;
    return await db.insert('my_table', data);
  }

  Future<List<Map<String, dynamic>>> getData() async {
    final db = await this.db;
    return await db.query('my_table');
  }

  Future<int> updateData(Map<String, dynamic> data, int id) async {
    final db = await this.db;
    return await db.update('my_table', data, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteData(int id) async {
    final db = await this.db;
    return await db.delete('my_table', where: 'id = ?', whereArgs: [id]);
  }
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final dbHelper = DatabaseHelper();

  late List<MyData> persons;
  late List<MyData> filteredPersons = [];

  int personCount = 0;

  final _nameControllerInsert = TextEditingController();
  final _emailControllerInsert = TextEditingController();
  late TextEditingController _nameControllerUpdate = TextEditingController();
  late TextEditingController _emailControllerUpdate = TextEditingController();

  bool isSearching = false;

  @override
  void initState() {
    initDatabaseAndGetData();
    super.initState();
  }

  void initDatabaseAndGetData() async {
    try {
      await dbHelper.initDatabase();
      final data = await dbHelper.getData();

      final myDataList = data.map((item) => MyData.fromMap(item)).toList();

      setState(() {
        persons = myDataList;
        filteredPersons = myDataList;
        personCount = myDataList.length;
      });
    } catch (e) {
      print("Error initializing database or retrieving data: $e");
    }
  }

  Future<void> _deleteItem(int id) async {
    try {
      await dbHelper.deleteData(id);
      initDatabaseAndGetData();
    } catch (e) {
      print("Error deleting person: $e");
    }
  }

  void _addPerson(String name, String email) async {
    try {
      await dbHelper.insertData({'name': name, 'email': email});
      initDatabaseAndGetData();
    } catch (e) {
      print("Error adding person: $e");
    }
  }

  Future<void> _showDeleteConfirmationDialog(
      BuildContext context, int id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Person'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this person?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                _deleteItem(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showAddPersonDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Person'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _nameControllerInsert,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _emailControllerInsert,
                decoration: InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                // Validate and add the new person to the database
                final name = _nameControllerInsert.text;
                final email = _emailControllerInsert.text;

                if (name.isNotEmpty && email.isNotEmpty) {
                  _addPerson(name, email);
                  _nameControllerInsert.clear();
                  _emailControllerInsert.clear();
                  Navigator.of(context).pop();
                } else {
                  // Show an error message or handle validation
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateItem(BuildContext context, int id) async {
    // Retrieve the existing person's data
    final person = persons.firstWhere((p) => p.id == id);
    _nameControllerUpdate = TextEditingController(text: person.name);
    _emailControllerUpdate = TextEditingController(text: person.email);
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Person'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _nameControllerUpdate,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _emailControllerUpdate,
                decoration: InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Update'),
              onPressed: () async {
                final name = _nameControllerUpdate.text;
                final email = _emailControllerUpdate.text;

                if (name.isNotEmpty && email.isNotEmpty) {
                  // Update the person's data
                  await dbHelper.updateData({'name': name, 'email': email}, id);
                  initDatabaseAndGetData();
                  Navigator.of(context).pop();
                } else {
                  // Show an error message or handle validation
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SQFlite Database',
      home: Scaffold(
        appBar: AppBar(
          title: isSearching
              ? TextField(
                  onChanged: (query) {
                    // Update the filtered data based on the search query
                    setState(() {
                      filteredPersons = persons
                          .where((person) =>
                              person.name
                                  .toLowerCase()
                                  .contains(query.toLowerCase()) ||
                              person.email
                                  .toLowerCase()
                                  .contains(query.toLowerCase()))
                          .toList();
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search person...',
                    border: InputBorder.none,
                  ),
                )
              : Text('Personal Database'),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
          actions: [
            IconButton(
              icon: Icon(
                  isSearching ? Icons.clear : Icons.person_search_outlined),
              onPressed: () {
                setState(() {
                  isSearching = !isSearching;
                  if (!isSearching) {
                    filteredPersons = persons;
                  }
                });
              },
            ),
          ],
        ),
        body: Center(
          child: Container(
            child: (filteredPersons.isNotEmpty)
                ? ListView.builder(
                    itemCount: filteredPersons.length,
                    itemBuilder: (BuildContext context, int position) {
                      return Card(
                        color: Colors.yellow[200],
                        elevation: 1.0,
                        child: ListTile(
                          leading: Container(
                            width: 70,
                            child: TextButton(
                              onPressed: () => _updateItem(
                                  context, filteredPersons[position].id),
                              child: Row(
                                children: [
                                  Icon(Icons.person_pin_outlined,
                                      color: Colors.blue),
                                  SizedBox(width: 10),
                                  Text(
                                    filteredPersons[position].id.toString(),
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          title: Text(filteredPersons[position].name),
                          subtitle: Text(filteredPersons[position].email),
                          trailing: GestureDetector(
                            child: Icon(
                              Icons.person_remove_alt_1_outlined,
                              color: Colors.pink,
                            ),
                            onTap: () {
                              _showDeleteConfirmationDialog(
                                  context, filteredPersons[position].id);
                            },
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text("No matching data"),
                  ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape: CircleBorder(),
          backgroundColor: Colors.green,
          onPressed: () {
            _showAddPersonDialog(context);
          },
          child: Icon(Icons.person_add_alt),
        ),
      ),
    );
  }
}
