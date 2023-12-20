import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/book/models/book.dart';
import 'package:project/home/models/review_home.dart';
import 'package:project/home/widget/auto_image_slider.dart';
import 'package:project/home/widget/book_home_card.dart';
import 'package:project/home/widget/review_card.dart';
import 'package:project/main/screens/login.dart';
import 'package:project/main/screens/register.dart';
import 'package:http/http.dart' as http;

Future<List<Book>> fetchFourRandomBooks() async {
  var url = Uri.parse(
    'https://readnrate.adaptable.app/leaderboard/get-10-best-rated-books/',
  );
  var response = await http.get(
    url,
    headers: {"Content-Type": "application/json"},
  );

  var data = jsonDecode(utf8.decode(response.bodyBytes));
  List<Book> listBook = [];

  for (var d in data) {
    if (d != null) {
      listBook.add(Book.fromJson(d));
    }
  }

  listBook.shuffle();
  return listBook.take(4).toList();
}

Future<List<ReviewHome>> fetchFourRecentReviews() async {

  var url = 'https://readnrate.adaptable.app/get_reviews_all/';
  var response = await http.get(
    Uri.parse(url),
    headers: {"Content-Type": "application/json"}
  );
  
  List<ReviewHome> listOfReviews = [];
  List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

  for (var d in data) {
    listOfReviews.add(ReviewHome.fromJson(d));
  }
  
  // Reverse the list and take only the first four elements
  List<ReviewHome> reversedList = listOfReviews.reversed.toList();
  List<ReviewHome> firstFourReviews = reversedList.take(4).toList();

  return firstFourReviews;
}

class HomeFeedsPage extends StatelessWidget {
  const HomeFeedsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(bottom: 30),
          decoration: const BoxDecoration(
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
                      backgroundColor: const Color.fromARGB(255, 7, 194, 41)
                    ),
                    child: Text(
                      'JOIN US',
                      overflow: TextOverflow.visible,
                      style: GoogleFonts.almarai(
                        textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        letterSpacing: 0.8
                      ),
                    )
                  ),
                  )
                ),
              ),



              //title TEXT - "LATEST NEWS"
              SizedBox(
                width: double.infinity,
                child: Padding( 
                  padding: const EdgeInsets.only(top: 30, left: 20, bottom: 5),
                  child: 
                  InkWell(
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
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 0),
                child: Container(
                  height: 0.5,
                  color: const Color.fromARGB(255, 192, 206, 218),
                ),
              ),  
              //News Carousel 
              Container(
                margin: const EdgeInsets.only(top: 10,),
                child: const NewsImageSlider(),
              ),



              //title TEXT - "BOOKS TO READ"
              SizedBox(
                width: double.infinity,
                child: Padding( 
                  padding: const EdgeInsets.only(top: 30, left: 20, bottom: 5),
                  child:
                  InkWell(
                    onTap: () {
                      DefaultTabController.of(context).animateTo(2);
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
              Padding (
                padding: const EdgeInsets.only(top: 15),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 2 * 20.0, //Max width follows width of divider
                  child: FutureBuilder(
                    future: fetchFourRandomBooks(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return GridView.count(
                          crossAxisCount: 4,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 6.0, // Adjust the spacing between items
                          mainAxisSpacing: 6.0,  // Adjust the spacing between rows
                          childAspectRatio: 0.7, // Adjust the aspect ratio for each item
                          children: List.generate(4, (index) {
                            return Image.asset('assets/ReadNRate Logo 2.png'); // Replace PlaceholderImage with your actual placeholder widget
                          }),
                        );
                      } else {
                        return GridView.count(
                          crossAxisCount: 4,
                          shrinkWrap: true,
                          // physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 6.0, // Adjust the spacing between items
                          mainAxisSpacing: 6.0,  // Adjust the spacing between rows
                          childAspectRatio: 0.7, // Adjust the aspect ratio for each item
                          children: 
                            (snapshot.data! as List<Book>)
                              .map((Book book) {
                            return BookCardHome(book);
                            }).toList(),
                        );
                      }
                    }
                  )
                ),
              ),



              //title TEXT - "RECENT REVIEWS"
              SizedBox(
                width: double.infinity,
                child: Padding( 
                  padding: const EdgeInsets.only(top: 30, left: 20, bottom: 5),
                  child: 
                  InkWell(
                    child: Text(
                    "RECENT REVIEWS",
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
              //Recent reviews cards
              Padding (
                padding: const EdgeInsets.only(top: 15),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 2 * 20.0, //Max width follows width of divider
                  child: FutureBuilder(
                    future: fetchFourRecentReviews(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return ListView(
                          shrinkWrap: true,
                          children: List.generate(4, (index) {
                            return Image.asset('assets/ReadNRate Logo 2.png'); // Replace PlaceholderImage with your actual placeholder widget
                          }),
                        );
                      } else {
                        return ListView(
                          shrinkWrap: true,
                          children: 
                            (snapshot.data! as List<ReviewHome>).map(
                              (ReviewHome review) {
                                return ReviewCard(review);
                              }
                            ).toList(),
                        );
                      }
                    }
                  )
                ),
              ),
              
            ]
          ),
        )
    );
  } 
}
