import 'package:flutter/material.dart';

class Option {
  final String name;
  final IconData icon;
  final Color color;

  Option(this.name, this.icon, this.color);
}

class OptionCard extends StatelessWidget {
  final Option option;

  const OptionCard(this.option, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Material(
      color: option.color,
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        // Area responsive terhadap sentuhan
        // Navigate ke route yang sesuai (tergantung jenis tombol)
        onTap: () {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context) // test
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${option.name}!")));
        },
        child: Container(
          // Container untuk menyimpan Icon dan Text
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  option.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  option.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
