import 'package:flutter/material.dart';
import 'package:project/main/screens/book_list.dart';
import 'package:project/home/screens/menu.dart';
import 'package:project/main/screens/login.dart';
import 'package:project/main/screens/register.dart';

class UserProfileWidget extends StatelessWidget {
  final String username;

  UserProfileWidget({required this.username});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.all(10),
            child: CircleAvatar(
              radius: 38,
              backgroundImage: NetworkImage(
                  'https://i.pinimg.com/550x/6e/c3/13/6ec313d108678bd6e33d5e6935c3099f.jpg'),
            ),
          ),
        Text(
          username,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({Key? key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFF2C343F),
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF2C343F), // Use the same color as the background
            ),
            padding: EdgeInsets.all(0), // Remove default padding
            child: UserProfileWidget(username: 'JohnDoe'), // Replace with actual username
          ),
          ListTile(
            leading: const Icon(
              Icons.home_outlined,
              color: Colors.white,
            ),
            title: const Text(
              'Home',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.checklist,
              color: Colors.white,
            ),
            title: const Text(
              'All Books',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BooksPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.library_books,
              color: Colors.white,
            ),
            title: const Text(
              'Readlists',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BooksPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.bookmark,
              color: Colors.white,
            ),
            title: const Text(
              'Bookmarks',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BooksPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            title: const Text(
              'Likes',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BooksPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              // Handle logout here
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.login,
              color: Colors.white,
            ),
            title: const Text(
              'Sign in',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.person_add,
              color: Colors.white,
            ),
            title: const Text(
              'Register',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
