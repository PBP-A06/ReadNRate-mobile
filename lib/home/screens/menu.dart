import 'package:flutter/material.dart';
import 'package:project/home/widget/left_drawer.dart';
import 'package:project/home/widget/option_card.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final List<Option> items = [
    Option("Home", Icons.home_outlined, Colors.grey.shade900),
    Option("All Books", Icons.checklist, Colors.grey.shade800),
    Option("Logout", Icons.logout, Colors.grey.shade600),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'ReadNRate Mobile',
        ),
        backgroundColor: Colors.grey.shade800,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Center(
        child: SingleChildScrollView(
          // Widget wrapper yang dapat discroll
          child: Padding(
            padding: const EdgeInsets.all(10.0), // Set padding dari halaman
            child: Column(
              // Widget untuk menampilkan children secara vertikal
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
                  child: Text(
                    'Review your favorite books', // Text yang menandakan toko
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      // fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                // Grid layout
                GridView.count(
                  // Container pada card kita.
                  primary: true,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  children: items.map((Option item) {
                    // Iterasi untuk setiap item
                    return OptionCard(item);
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
