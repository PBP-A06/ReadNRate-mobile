import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/book/models/book.dart';
import 'package:project/home/widget/left_drawer.dart';
import 'package:project/leaderboard/widget/book_leaderboard_card.dart';

import 'dart:convert';


class ReadlistDetailPage extends StatefulWidget {
  final int readlistId;

  const ReadlistDetailPage({Key? key, required this.readlistId})
      : super(key: key);

  @override
  _ReadlistDetailPageState createState() => _ReadlistDetailPageState();
}

class _ReadlistDetailPageState extends State<ReadlistDetailPage> {
  Future<List<Book>> fetchBooks(int readlistId) async {
    var url = Uri.parse(
        'https://readnrate.adaptable.app/readlist/readlist-flutter/${widget.readlistId}/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Book> list_product = [];
    for (var d in data) {
      if (d != null) {
        list_product.add(Book.fromJson(d));
      }
    }
    return list_product;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Readlists'),
          backgroundColor: Colors.transparent, // Transparent
          elevation: 0, // No shadow
          foregroundColor: Colors.white,
        ),
        // Masukkan drawer sebagai parameter nilai drawer dari widget Scaffold
        drawer: const LeftDrawer(),
        body: FutureBuilder(
            future: fetchBooks(widget.readlistId),
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

                          // Grid layout
                          GridView.count(
                              // Container pada card kita.
                              primary: true,
                              padding: const EdgeInsets.all(10),
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              childAspectRatio: 1, // 1:1 card
                              children: (snapshot.data! as List<Book>)
                                  .map((Book book) {
                                return BookCard(book);
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
