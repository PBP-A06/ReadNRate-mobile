import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/book/models/book.dart';
// import 'package:project/readlist/models/readlist.dart';
import 'package:project/home/widget/left_drawer.dart';
import 'package:project/leaderboard/widget/book_leaderboard_card.dart';
import 'package:project/leaderboard/models/readlist.dart';
import 'package:project/leaderboard/widget/dropdown.dart';
import 'package:project/leaderboard/widget/readlist_leaderboard_card.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  late Future<List<dynamic>> Function() fetchDataFunction; // Book/Readlist
  String titleText = "Top 10 by Rating";

  @override
  void initState() {
    super.initState();
    fetchDataFunction = fetch10BestRatedBooks; // Initial fetch function
  }

  Future<List<Book>> fetch10BestRatedBooks() async {
    titleText = "Top 10 by Rating";
    var url = Uri.parse(
        'https://readnrate.adaptable.app/leaderboard/get-10-best-rated-books/');
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

  Future<List<Book>> fetch100BestRatedBooks() async {
    titleText = "Top 100 by Rating";
    var url = Uri.parse(
        'https://readnrate.adaptable.app/leaderboard/get-100-best-rated-books/');
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

  Future<List<Book>> fetch10MostLikedBooks() async {
    titleText = "Top 10 by Likes";
    var url = Uri.parse(
        'https://readnrate.adaptable.app/leaderboard/get-10-most-liked-books/');
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

  Future<List<Book>> fetch100MostLikedBooks() async {
    titleText = "Top 100 by Likes";
    var url = Uri.parse(
        'https://readnrate.adaptable.app/leaderboard/get-100-most-liked-books/');
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

  Future<List<Readlist>> fetchReadlists() async {
    titleText = "Top 10 Readlists by Likes";
    var url =
        Uri.parse('https://readnrate.adaptable.app/leaderboard/get-readlists/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Book
    List<Readlist> listReadlist = [];
    for (var d in data) {
      if (d != null) {
        listReadlist.add(Readlist.fromJson(d));
      }
    }
    return listReadlist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Leaderboard'),
        backgroundColor: Colors.transparent, // Transparent
        elevation: 0,                          // No shadow
        foregroundColor: Colors.white,
        ),
        // Masukkan drawer sebagai parameter nilai drawer dari widget Scaffold
        drawer: const LeftDrawer(),
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
                          // nanti sesuaikan berdasarkan button ayng diklik
                          Text(
                            titleText, // Top 10/100 by Rating/Likes/Readlist
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Change to sort by?', // Text yang menandakan toko
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
                                    fetchDataFunction = fetch10BestRatedBooks;
                                  });
                                },
                                child: const Text(
                                  "Rating (Top 10)",
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
                                    fetchDataFunction = fetch100BestRatedBooks;
                                  });
                                },
                                child: const Text(
                                  "Rating (Top 100)",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
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
                                    fetchDataFunction = fetch10MostLikedBooks;
                                  });
                                },
                                child: const Text(
                                  "  Likes (Top 10) ",
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
                                    fetchDataFunction = fetch100MostLikedBooks;
                                  });
                                },
                                child: const Text(
                                  " Likes (Top 100)  ",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.grey.shade700),
                            ),
                            // nanti benerin, not done yet
                            onPressed: () {
                              setState(() {
                                fetchDataFunction = fetchReadlists;
                              });
                            },
                            child: const Text(
                              "Readlist (Top 10)",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            ),
                          ),
                          const SizedBox(height: 10),
                          MyDropdown(),
                          if (snapshot.data![0] is Book)
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
                                }).toList())
                          else // Grid layout
                            GridView.count(
                                // Container pada card kita.
                                primary: true,
                                padding: const EdgeInsets.all(10),
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                crossAxisCount: 2,
                                shrinkWrap: true,
                                childAspectRatio: 1, // 1:1 card
                                children: (snapshot.data! as List<Readlist>)
                                    .map((Readlist readlist) {
                                  return ReadlistCard(readlist);
                                }).toList())
                        ],
                      ),
                    ),
                  );
                }
              }
            }));
  }
}
