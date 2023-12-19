import 'package:google_fonts/google_fonts.dart';
import 'package:project/home/screens/menu.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:project/home/widget/left_drawer.dart';
import 'package:project/main/screens/register.dart';
import 'package:provider/provider.dart';
String? usernameGlobal;

class LoginPage extends StatefulWidget {
    const LoginPage({super.key});

    @override
    _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

  // Toggles the password show status
  bool _obscureText1 = true;
  void _toggleObscured1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

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
                  'assets/TheBesiegedCitybyClariceLispector.webp', // Replace with your background image path
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
                              "Sign in to ReadNRate",
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
                                  labelText: 'Username',
                                  labelStyle: TextStyle(color:Color(0xFF556678)),
                              ),
                          ),
                          const SizedBox(height: 12.0),
                          TextField(
                              controller: _passwordController,
                              style: const TextStyle(color: Colors.white),
                              obscureText: _obscureText1,
                              decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: const TextStyle(color:Color(0xFF556678)),
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
                          const SizedBox(height: 24.0),
                          
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 20, top: 10, bottom: 15),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => const RegisterPage()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFF27405)
                                  ),
                                  child: Text(
                                    'JOIN US',
                                    style: GoogleFonts.almarai(
                                      textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                                    ),
                                  )
                                ),
                              ),

                              Container(
                                margin: const EdgeInsets.only(left: 20, top: 10, bottom: 15),
                                child: ElevatedButton(
                                    onPressed: () async {
                                      
                                      showDialog(
                                        context: context, 
                                        builder: (context) {
                                          return Center(child: CircularProgressIndicator());
                                        }
                                      );

                                        String username = _usernameController.text;
                                        String password = _passwordController.text;

                                        // Cek kredensial
                                        // Untuk menyambungkan Android emulator dengan Django pada localhost,
                                        // gunakan URL http://10.0.2.2/
                                        final response = await request.login("https://readnrate.adaptable.app//auth/login/", {
                                        'username': username,
                                        'password': password,
                                        });
                            
                                        if (request.loggedIn) {
                                            String message = response['message'];
                                            String uname = response['username'];
                                            usernameGlobal = response['username'];
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(builder: (context) => HomePage()),
                                            );
                                            ScaffoldMessenger.of(context)
                                                ..hideCurrentSnackBar()
                                                ..showSnackBar(
                                                    SnackBar(content: Text("$message Welcome, $uname.")));
                                            } else {
                                              Navigator.pop(context); 

                                              showDialog(
                                                  context: context,
                                                  builder: (context) => AlertDialog(
                                                      title: const Text('Login Failed'),
                                                      content:
                                                          Text(response['message']),
                                                      actions: [
                                                          TextButton(
                                                              child: const Text('OK'),
                                                              onPressed: () {
                                                                  Navigator.pop(context);
                                                                  _passwordController.clear();
                                                              },
                                                          ),
                                                      ],
                                                  ),
                                              );
                                        }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF00B021),  
                                    ),
                                    child: Text(
                                      'LOG IN',
                                      style: GoogleFonts.almarai(
                                        textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                                      ),
                                    )
                                  ),
                              )
                            ],
                          )
                        ],
                    ),
                  ),
        ],
      ),
    );
  }
}