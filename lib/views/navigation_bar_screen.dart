import 'package:flutter/material.dart';

class NavigationBarScreen extends StatefulWidget {
  const NavigationBarScreen({Key? key}) : super(key: key);

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  int currentPageIndex = 0;

  List widgets = <Widget>[
    Container(
      color: Colors.blue,
      alignment: Alignment.center,
      child: const Text(
        'Page 1',
        style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w600),
      ),
    ),
    Container(
      color: Colors.green,
      alignment: Alignment.center,
      child: const Text(
        'Page 2',
        style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w600),
      ),
    ),
    Container(
      color: Colors.purple,
      alignment: Alignment.center,
      child: const Text(
        'Page 3',
        style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w600),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgets[currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.commute),
            label: 'Commute',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark),
            icon: Icon(Icons.bookmark_border),
            label: 'Saved',
          ),
        ],
      ),
    );
  }
}
