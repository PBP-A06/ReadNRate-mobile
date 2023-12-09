import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/book/models/book.dart';
import 'package:project/home/widget/left_drawer.dart';
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
        backgroundColor: Colors.black,
        body: FutureBuilder(
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
                        style:
                            TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return SingleChildScrollView(
                    // Widget wrapper yang dapat discroll
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
                            style: const TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Change to sort by?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                            ),
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
                                child: const Text(
                                  "Title",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
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
                                child: const Text(
                                  "Category",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
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
                              childAspectRatio: 0.48,
                              children: (snapshot.data! as List<Book>)
                                  .map((Book book) {
                                return BookCard(book);
                              }).toList()),
                        ],
                      ),
                    ),
                  );
                }
              }
            }));
  }
}
