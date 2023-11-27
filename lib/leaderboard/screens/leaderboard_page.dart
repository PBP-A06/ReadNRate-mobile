import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project/models/book.dart';
import 'package:project/widget/left_drawer.dart';
import 'package:http/http.dart' as http;

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  @override
  Widget build(BuildContext context) {
    Future<List<Book>> fetchBook() async {
      var url = Uri.parse(
          'http://localhost:8000/leaderboard/get-10-best-rated-books/');
      var response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );

      // melakukan decode response menjadi bentuk json
      var data = jsonDecode(utf8.decode(response.bodyBytes));

      // melakukan konversi data json menjadi object Book
      List<Book> list_book = [];
      for (var d in data) {
        if (d != null) {
          list_book.add(Book.fromJson(d));
        }
      }
      return list_book;
    }

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Daftar Buku'),
          backgroundColor: Colors.grey[800],
          foregroundColor: Colors.white,
        ),
        // Masukkan drawer sebagai parameter nilai drawer dari widget Scaffold
        drawer: const LeftDrawer(),
        body: FutureBuilder(
            future: fetchBook(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return const Column(
                    children: [
                      Text(
                        "Tidak ada data buku.",
                        style:
                            TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${index + 1}. ${snapshot.data![index].fields.title}",
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "${snapshot.data![index].fields.category}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.grey.shade700),
                                  ),
                                  onPressed: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) => BookDetailsPage(
                                    //           snapshot.data![index])),
                                    // );
                                  },
                                  child: const Text(
                                    "See Details",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ));
                }
              }
            }));
  }
}
