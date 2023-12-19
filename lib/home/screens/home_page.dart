import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/main/screens/book_list.dart';
import 'package:project/main/screens/login.dart';
import 'package:project/main/screens/register.dart';

class HomeFeedsPage extends StatelessWidget {
  const HomeFeedsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomCenter,
              colors: [ Color.fromARGB(255, 36, 41, 49), Color.fromARGB(255, 24, 28, 33)]
            )
          ),

          child: Column(
            children: [

              //Welcome TEXT (logged in)
              if (usernameGlobal != null)
                SizedBox(
                  width: double.infinity,
                  child: Padding( 
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                    "Welcome back, $usernameGlobal",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: const Color.fromARGB(255, 192, 206, 218), 
                      fontWeight: FontWeight.w100, 
                      fontSize: 30 ),
                    ),
                  )
                ),
              
              //Welcome TEXT (guest)
              if (usernameGlobal == null)
              SizedBox(
                width: double.infinity,
                child: Padding( 
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(
                  "Join the biggest book reviewing community in the world",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    color: const Color.fromARGB(255, 192, 206, 218), 
                    fontWeight: FontWeight.w100, 
                    fontSize: 30 ),
                  ),
                )
              ),
              if (usernameGlobal == null)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: SizedBox(
                    height: 30,
                    width: 110,
                    child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      
                      backgroundColor: Color.fromARGB(255, 7, 194, 41)
                    ),
                    child: Text(
                      'JOIN US',
                      overflow: TextOverflow.visible,
                      style: GoogleFonts.dmSerifDisplay(
                        textStyle: const TextStyle(
                          color: Colors.white,  
                          fontSize: 13,
                          letterSpacing: 2
                          )
                      ),
                    )
                  ),
                  )
                ),
              ),

              //title TEXT
              SizedBox(
                width: double.infinity,
                child: Padding( 
                  padding: const EdgeInsets.only(top: 30, left: 20, bottom: 5),
                  child: 
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BooksPage(),
                        ),
                      );
                    },
                    child: Text(
                    "BOOKS TO READ",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                      color: const Color.fromARGB(255, 192, 206, 218), 
                      fontWeight: FontWeight.w300, 
                      fontSize: 12,
                      letterSpacing: 0.8,
                      ),                  
                    ),
                  )
                )
              ),

              //Divider
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: 0.5,
                  color: const Color.fromARGB(255, 192, 206, 218),
                ),
              ),

              //Book cover images
              SizedBox(
                height: 100,
                width: double.infinity,
                child: GridView.count(
                  crossAxisCount: 4,
                  children: [

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        width: 100,
                        color: Colors.blue,
                        ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 90,
                        width: 50,
                        color: Colors.blue,
                        ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 90,
                        width: 50,
                        color: Colors.blue,
                        ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 90,
                        width: 50,
                        color: Colors.blue,
                        ),
                    )
                  ],
                )
              ),


              //title TEXT
              SizedBox(
                width: double.infinity,
                child: Padding( 
                  padding: const EdgeInsets.only(top: 30, left: 20, bottom: 5),
                  child: 
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BooksPage(),
                        ),
                      );
                    },
                    child: Text(
                    "LATEST NEWS",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                      color: const Color.fromARGB(255, 192, 206, 218), 
                      fontWeight: FontWeight.w300, 
                      fontSize: 12,
                      letterSpacing: 0.8,
                      ),                  
                    ),
                  )
                )
              ),

              //Divider
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: 0.5,
                  color: const Color.fromARGB(255, 192, 206, 218),
                ),
              ),

              //title TEXT
              SizedBox(
                width: double.infinity,
                child: Padding( 
                  padding: const EdgeInsets.only(top: 30, left: 20, bottom: 5),
                  child: 
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BooksPage(),
                        ),
                      );
                    },
                    child: Text(
                    "EDITOR'S PICKS",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                      color: const Color.fromARGB(255, 192, 206, 218), 
                      fontWeight: FontWeight.w300, 
                      fontSize: 12,
                      letterSpacing: 0.8,
                      ),                  
                    ),
                  )
                )
              ),

              //Divider
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: 0.5,
                  color: const Color.fromARGB(255, 192, 206, 218),
                ),
              ),
            ]
          ),
        )
    );
  } 
}
