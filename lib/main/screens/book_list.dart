import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:project/book/models/book.dart';
import 'package:project/leaderboard/widget/book_leaderboard_card.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({Key? key}) : super(key: key);

  @override
  _BooksPageState createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  late Future<List<dynamic>> Function() fetchDataFunction; // Book/Readlist
  String titleText = "Books by Title";

  @override
  void initState() {
    super.initState();
    fetchDataFunction = fetchBooksSortedByTitle; // Initial fetch function
  }

  Future<List<Book>> fetchBooksSortedByTitle() async {
    titleText = "Books by Title";
    var url = Uri.parse(
        'https://readnrate.adaptable.app/leaderboard/get-100-books-sorted-by-title/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Book
    List<Book> listBook = [];
    for (var d in data) {
      if (d != null) {
        listBook.add(Book.fromJson(d));
      }
    }
    return listBook;
  }

  Future<List<Book>> fetchBooksSortedByCategory() async {
    titleText = "Books by Category";
    var url = Uri.parse(
        'https://readnrate.adaptable.app/leaderboard/get-100-books-sorted-by-category/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Book
    List<Book> listBook = [];
    for (var d in data) {
      if (d != null) {
        listBook.add(Book.fromJson(d));
      }
    }
    return listBook;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomCenter,
              colors: [
            Color.fromARGB(255, 36, 41, 49),
            Color.fromARGB(255, 24, 28, 33)
          ])),
      child: FutureBuilder(
          future: fetchDataFunction(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (!snapshot.hasData) {
                return const Column(
                  children: [
                    Text(
                      "Belum ada data.",
                      style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                    ),
                    SizedBox(height: 8),
                  ],
                );
              } else {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding:
                        const EdgeInsets.all(5), // Set padding dari halaman
                    child: Column(
                      // Widget untuk menampilkan children secara vertikal
                      children: [
                        const SizedBox(height: 10),
                        // nanti sesuaikan berdasarkan button yang diklik
                        Text(
                          titleText,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                              color: const Color.fromARGB(255, 192, 206, 218),
                              fontWeight: FontWeight.w100,
                              fontSize: 30),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Change to sort by?',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.almarai(
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic)),
                        ),
                        const SizedBox(height: 7),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.grey.shade700),
                              ),
                              onPressed: () {
                                setState(() {
                                  fetchDataFunction = fetchBooksSortedByTitle;
                                });
                              },
                              child: Text(
                                "Title",
                                style: GoogleFonts.almarai(
                                    textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                )),
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.grey.shade700),
                              ),
                              onPressed: () {
                                setState(() {
                                  fetchDataFunction =
                                      fetchBooksSortedByCategory;
                                });
                              },
                              child: Text(
                                "Category",
                                style: GoogleFonts.almarai(
                                    textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                )),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        // Grid layout
                        GridView.count(
                            // Container pada card kita.
                            primary: true,
                            padding: const EdgeInsets.all(10),
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            childAspectRatio: 0.48,
                            children:
                                (snapshot.data! as List<Book>).map((Book book) {
                              return BookCard(book);
                            }).toList()),
                      ],
                    ),
                  ),
                );
              }
            }
          }),
    ));
  }
}
