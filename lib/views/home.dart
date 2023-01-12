import 'package:flutter/material.dart';
import 'package:widget_of_the_day/views/navigation_bar_screen.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Widgets")),
      body: Column(
        children: [
          ListTile(
            title: const Text("Navigation Bar"),
            trailing: const Icon(Icons.arrow_forward),
            tileColor: Colors.black12,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NavigationBarScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
