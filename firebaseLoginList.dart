import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Urunler {
  final String urunadi;
  final double fiyat;
  final int adet;

  Urunler(this.urunadi, this.fiyat, this.adet);

  // Factory constructor to convert Firestore document data to a Product object
  factory Urunler.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Urunler(data['urunadi'], data['fiyat'].toDouble(), data['adet']);
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

  String errorMessage = "";

  User? _user;

  late Stream<List<Urunler>> _productsStream;

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
        errorMessage = '💥 Parola yenileme hatası: \n$e';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      setState(() {
        errorMessage = '🛟 Firebase bağlantısı var';
        _productsStream = FirebaseFirestore.instance
            .collection('urunler')
            .snapshots()
            .map((querySnapshot) {
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
      appBar: AppBar(title: const Text('Firebase Örnek')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Hoş geldiniz: ${_user!.email}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _deleteAccount,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Hesabı Sil'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _logout,
              child: const Text('Çıkış'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Ürün Listesi:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                    );
                  }).toList(),
                );
              },
            ),
          ],
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
            Row(
              children: [
                ElevatedButton(
                  onPressed: _login,
                  child: const Text('Giriş'),
                ),
                const SizedBox(width: 15),
                ElevatedButton(
                  onPressed: _register,
                  child: const Text('Kaydol'),
                ),
                const SizedBox(width: 15),
                ElevatedButton(
                  onPressed: _resetPassword,
                  child: const Text('Parola Hatırlat'),
                ),
              ],
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
