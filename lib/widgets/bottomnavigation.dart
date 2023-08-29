import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            if (index == 3) {
              Navigator.pop(context);
              return;
            }
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber[500],
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Ana Sayfa',
          ),
          NavigationDestination(
            icon: Icon(Icons.business),
            label: 'İş',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.school),
            icon: Icon(Icons.school_outlined),
            label: 'Okul',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.arrow_back),
            icon: Icon(Icons.arrow_back_outlined),
            label: 'Geri',
          ),
        ],
      ),
      body: <Widget>[
        Container(
          color: Colors.yellow,
          alignment: Alignment.center,
          child: const Text('Sayfa 1'),
        ),
        Container(
          color: Colors.orangeAccent,
          alignment: Alignment.center,
          child: const Text('Sayfa 2'),
        ),
        Container(
          color: Colors.lightBlue,
          alignment: Alignment.center,
          child: const Text('Sayfa 3'),
        ),
        Container(
          color: Colors.pink,
          alignment: Alignment.center,
          child: const Text('Sayfa 4 - Burası Geri için'),
        ),
      ][currentPageIndex],
    );
  }
}
