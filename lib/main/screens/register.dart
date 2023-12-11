import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:project/home/widget/left_drawer.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      backgroundColor: const Color(0xFF14171C),
      extendBodyBehindAppBar: true,            // Transparent App Bar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent
        elevation: 0,                          // No shadow
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body:
        Stack(
          children: [
            // Background image
            Image.asset(
              'assets/TheMemoryPolicebyYokoOgawa.webp', // Replace with your background image path
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.6),
                    const Color(0xFF14171C),
                  ],
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //Title
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Join ReadNRate",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  TextField(
                    controller: _usernameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color:Color(0xFF556678)),
                      labelText: "Username",
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  TextField(
                    controller: _passwordController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color:Color(0xFF556678)),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 12.0),
                  TextField(
                    controller: _passwordConfirmationController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Confirm your Password',
                      labelStyle: TextStyle(color:Color(0xFF556678)),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.grey.shade700),
                    ),
                    onPressed: () async {
                      String username = _usernameController.text;
                      String password = _passwordController.text;
                      String passwordConfirmation =
                          _passwordConfirmationController.text;

                      final response = await request.postJson(
                        "https://readnrate.adaptable.app/auth/register",
                        // "http://localhost:8000/auth/register/",
                        jsonEncode(<String, String>{
                          'username': username,
                          'password': password,
                          'passwordConfirmation': passwordConfirmation,
                        }),
                      );

                      if (response["status"] == "success") {
                        Navigator.pop(context); // back to login page
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(SnackBar(
                              content: Text(
                                  "Register berhasil! Akun $username sudah dapat digunakan.")));
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Register Gagal'),
                            content: Text(response['message']),
                            actions: [
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      }
                      if (request.loggedIn) {
                      } else {}
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}