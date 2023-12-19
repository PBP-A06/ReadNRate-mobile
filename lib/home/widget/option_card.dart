import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:project/main/screens/book_list.dart';
import 'package:project/main/screens/login.dart';
import 'package:provider/provider.dart';

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
    final request = context.watch<CookieRequest>();
    return Material(
      color: option.color,
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        // Area responsive terhadap sentuhan
        // Navigate ke route yang sesuai (tergantung jenis tombol)
        onTap: () async {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context) // test
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${option.name}!")));

          // statement if sebelumnya
          // tambahkan else if baru seperti di bawah ini
          if (option.name == "Logout") {
            final response = await request
                .logout("https://readnrate.adaptable.app/auth/logout/");
            String message = response["message"];
            usernameGlobal = null;
            if (response['status']) {
              String uname = response["username"];
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("$message Sampai jumpa, $uname."),
              ));
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("$message"),
              ));
            }
          } else if (option.name == "All Books") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BooksPage()),
            );
          }
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
