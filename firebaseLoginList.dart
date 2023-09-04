import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Urunler {
  final String urunadi;
  final double fiyat;
  final int adet;
  final String ID;

  Urunler(this.urunadi, this.fiyat, this.adet, this.ID);

  // Factory constructor to convert Firestore document data to a Product object
  factory Urunler.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Urunler(
        data['urunadi'], data['fiyat'].toDouble(), data['adet'], doc.id);
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _urunAdiController = TextEditingController();
  final TextEditingController _urunFiyatController = TextEditingController();
  final TextEditingController _urunAdetController = TextEditingController();

  String errorMessage = "";

  User? _user;

  late Stream<List<Urunler>> _productsStream;

  String? selectedProductId;
  //late final productIDs;

  void _login() async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      setState(() {
        errorMessage = '👌 Giriş yapıldı: \n${userCredential.user!.email}';
        _user = _auth.currentUser;
      });
    } catch (e) {
      setState(() {
        errorMessage = '💥 Hata: \n$e';
      });
    }
  }

  void _logout() async {
    await _auth.signOut();
    setState(() {
      _user = null;
    });
  }

  void _register() async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text, // Replace with desired email
        password: _passwordController.text, // Replace with desired password
      );
      setState(() {
        _user = userCredential.user;
      });
    } catch (e) {
      setState(() {
        errorMessage = '💥 Kaydolma Hatası: \n$e';
      });
    }
  }

  void _deleteAccount() async {
    try {
      // Before deleting the account, you might want to ask the user for confirmation or re-authenticate them.
      await _user?.delete();
      setState(() {
        _user = null;
      });
    } catch (e) {
      setState(() {
        errorMessage = '💥 Hesap Silme Hatası: \n$e';
      });
    }
  }

  void _resetPassword() async {
    try {
      await _auth.sendPasswordResetEmail(
          email: _emailController.text); // Replace with user's email
      // Inform the user that a password reset email has been sent
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Parola yenileme bağlantısı emailinize gönderilmiştir.'),
      ));
    } catch (e) {
      setState(() {
        errorMessage = '💥 Parola Yenileme Hatası: \n$e';
      });
    }
  }

  // Create a new product in Firestore
  void _createProduct() async {
    try {
      await FirebaseFirestore.instance.collection('urunler').add({
        'urunadi': _urunAdiController.text,
        'fiyat': double.parse(_urunFiyatController.text),
        'adet': int.parse(_urunAdetController.text),
      });
      // Clear text fields after adding a product
      _urunAdiController.clear();
      _urunFiyatController.clear();
      _urunAdetController.clear();
      String hata = '👌 Ürün eklendi';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(hata),
      ));
    } catch (e) {
      setState(() {
        String hata = '💥 Ürün ekleme hatası: \n$e';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(hata),
        ));
      });
    }
  }

  // Update an existing product in Firestore
  void _updateProduct(String productId) async {
    try {
      await FirebaseFirestore.instance
          .collection('urunler')
          .doc(productId)
          .update({
        'urunadi': _urunAdiController.text,
        'fiyat': double.parse(_urunFiyatController.text),
        'adet': int.parse(_urunAdetController.text),
      });
      // Clear text fields after updating a product
      _urunAdiController.clear();
      _urunFiyatController.clear();
      _urunAdetController.clear();
      String hata = '👌 Ürün güncellendi';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(hata),
      ));
    } catch (e) {
      setState(() {
        String hata = '💥 Ürün güncelleme hatası: \n$e';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(hata),
        ));
      });
    }
  }

  // Delete a product from Firestore
  void _deleteProduct(String productId) async {
    try {
      await FirebaseFirestore.instance
          .collection('urunler')
          .doc(productId)
          .delete();
      String hata = '👌 Ürün silindi';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(hata),
      ));
    } catch (e) {
      setState(() {
        String hata = '💥 Ürün silme hatası: \n$e';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(hata),
        ));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      setState(() async {
        errorMessage = '🛟 Firebase bağlantısı var';

        _productsStream = FirebaseFirestore.instance
            .collection('urunler')
            .snapshots()
            .map((querySnapshot) {
          //productIDs = querySnapshot.docs.map((doc) => doc.id).toList();
          return querySnapshot.docs
              .map((doc) => Urunler.fromFirestore(doc))
              .toList();
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return girisFormu();
    } else {
      return basariliEkran();
    }
  }

  Scaffold basariliEkran() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Örnek'),
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.person, color: Colors.blue),
                    SizedBox(
                      width: 10,
                    ),
                    Text('${_user!.email}'),
                  ],
                ),
              ),
              // PopupMenuItem 1
              const PopupMenuItem(
                value: 1,
                // row with 2 children
                child: Row(
                  children: [
                    Icon(Icons.delete_sweep_outlined, color: Colors.red),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Hesabı Sil",
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                ),
              ),
              // PopupMenuItem 2
              const PopupMenuItem(
                value: 2,
                // row with two children
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.blue),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Çıkış")
                  ],
                ),
              ),
            ],
            offset: Offset(0, 55),
            //color: Colors.black,
            elevation: 2,
            // on selected we show the dialog box
            onSelected: (value) {
              // if value 1 show dialog
              if (value == 1) {
                _deleteAccount();
                // if value 2 show dialog
              } else if (value == 2) {
                _logout();
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              const Text(
                'Ürün Listesi',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              // Add a new product
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _urunAdiController,
                      decoration: InputDecoration(labelText: 'Ürün Adı'),
                    ),
                    TextField(
                      controller: _urunFiyatController,
                      decoration: InputDecoration(labelText: 'Fiyat'),
                    ),
                    TextField(
                      controller: _urunAdetController,
                      decoration: InputDecoration(labelText: 'Adet'),
                    ),
                    ElevatedButton(
                      onPressed: _createProduct,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Ürün Ekle'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder<List<Urunler>>(
                stream: _productsStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  final products = snapshot.data;
                  return Column(
                    children: products!.map((product) {
                      return ListTile(
                        title: Text(product.urunadi),
                        subtitle: Text(
                            '${product.fiyat.toStringAsFixed(2)} ₺ (${product.adet.toString()} adet)'),
                        trailing: IconButton(
                          icon: Icon(Icons.edit_note_outlined),
                          onPressed: () {
                            // When edit button is pressed, populate text fields with product info
                            _urunAdiController.text = product.urunadi;
                            _urunFiyatController.text =
                                product.fiyat.toString();
                            _urunAdetController.text = product.adet.toString();

                            selectedProductId = product.ID;

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Ürün Güncelleme'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      TextField(
                                        controller: _urunAdiController,
                                        decoration: InputDecoration(
                                            labelText: 'Ürün Adı'),
                                      ),
                                      TextField(
                                        controller: _urunFiyatController,
                                        decoration:
                                            InputDecoration(labelText: 'Fiyat'),
                                      ),
                                      TextField(
                                        controller: _urunAdetController,
                                        decoration:
                                            InputDecoration(labelText: 'Adet'),
                                      ),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      child: Text('Güncelle'),
                                      onPressed: () {
                                        // Update the product with the entered values
                                        _updateProduct(selectedProductId!);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    ElevatedButton(
                                      child: Text('Sil'),
                                      onPressed: () {
                                        _deleteProduct(selectedProductId!);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    ElevatedButton(
                                      child: Text('Vazgeç'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        onLongPress: () {
                          // çalışmadı
                          _deleteProduct(selectedProductId!);
                        },
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Scaffold girisFormu() {
    return Scaffold(
      appBar: AppBar(title: const Text('Firebase Örnek')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: "aaa@aaa.com",
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Parola',
                hintText: "123123",
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: _login,
                    child: Row(
                      children: [
                        Icon(Icons.login),
                        SizedBox(width: 5),
                        const Text('Giriş'),
                      ],
                    ),
                  ),
                  const SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: _register,
                    child: Row(
                      children: [
                        Icon(Icons.supervised_user_circle_outlined),
                        SizedBox(width: 5),
                        const Text('Kaydol'),
                      ],
                    ),
                  ),
                  const SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: _resetPassword,
                    child: Row(
                      children: [
                        Icon(Icons.password_outlined),
                        SizedBox(width: 5),
                        const Text('Parola Hatırlat'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(errorMessage)
          ],
        ),
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginScreen(),
    theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent)),
  ));
}
