import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:project/home/screens/menu.dart';
import 'package:project/home/widget/left_drawer.dart';
import 'package:project/main/screens/login.dart';
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

  // Toggles the password show status
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  void _toggleObscured1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  void _toggleObscured2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      backgroundColor: const Color(0xFF14171C),
      extendBodyBehindAppBar: true, // Transparent App Bar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent
        elevation: 0, // No shadow
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Stack(
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
                    labelStyle: TextStyle(color: Color(0xFF556678)),
                    labelText: "Username",
                  ),
                ),

                const SizedBox(height: 12.0),
                TextField(
                  controller: _passwordController,
                  style: const TextStyle(color: Colors.white),
                  obscureText: _obscureText1,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: const TextStyle(color: Color(0xFF556678)),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                      child: GestureDetector(
                        onTap: _toggleObscured1,
                        child: Icon(
                          _obscureText1
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12.0),
                TextField(
                  controller: _passwordConfirmationController,
                  style: const TextStyle(color: Colors.white),
                  obscureText: _obscureText2,
                  decoration: InputDecoration(
                    labelText: 'Confirm your Password',
                    labelStyle: const TextStyle(color: Color(0xFF556678)),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                      child: GestureDetector(
                        onTap: _toggleObscured2,
                        child: Icon(
                          _obscureText2
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24.0),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 15),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF00B021)),
                    ),
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const Center(
                                child: CircularProgressIndicator());
                          });

                      String username = _usernameController.text;
                      String password = _passwordController.text;
                      String passwordConfirmation =
                          _passwordConfirmationController.text;

                      final response = await request.postJson(
                        "https://readnrate.adaptable.app/auth/register/",
                        // "http://127.0.0.1:8000/auth/register/",
                        jsonEncode(<String, String>{
                          'username': username,
                          'password': password,
                          'passwordConfirmation': passwordConfirmation,
                        }),
                      );

                      if (response["status"] == "success") {
                        Navigator.pop(context); // back to login page
                        usernameGlobal = username;
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(SnackBar(
                              content: Text(
                                  "Register berhasil! Akun $username sudah dapat digunakan.")));

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      } else {
                        Navigator.pop(context);
                        _passwordController.clear();
                        _passwordConfirmationController.clear();

                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Register Failed'),
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
                    },
                    child: Text(
                      'GO',
                      style: GoogleFonts.almarai(
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
