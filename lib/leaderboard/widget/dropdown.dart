import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/book/models/book.dart';

class MyDropdown extends StatefulWidget {
  @override
  _MyDropdownState createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  String selectedOption = "#HigherSelfie: Wake Up Your Li..."; // Initial value
  int selectedRank = 1;
  String selectedActualTitle =
      "#HigherSelfie: Wake Up Your Life. Free Your Soul. Find Your Tribe.";

  Future<List<Book>> fetchBooksSortedByTitle() async {
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

  /// return rank and book actual title
  Future<List<dynamic>> getBookRankByRating(String title) async {
    var url = Uri.parse(
        'https://readnrate.adaptable.app/leaderboard/get-100-best-rated-books/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Book
    List<dynamic> retval = [1, ""];
    int rank = 0;
    for (var d in data) {
      if (d != null) {
        Book book = Book.fromJson(d);
        String bookTitle = book.fields.title.length > 30
            ? '${book.fields.title.substring(0, 30)}...'
            : book.fields.title;
        rank++;
        if (bookTitle == title) {
          retval[0] = rank;
          retval[1] = book.fields.title;
        }
      }
    }
    return retval;
  }

  Future<void> handleSelectedOption(String? newValue, int index) async {
    final rankAndTitle = await getBookRankByRating(newValue!);
    setState(() {
      selectedOption = newValue;
      selectedRank = rankAndTitle[0];
      selectedActualTitle = rankAndTitle[1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchBooksSortedByTitle(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return const Column(
                children: [
                  Text(
                    "Tidak ada data buku/readlist.",
                    style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              return Column(
                children: [
                  SizedBox(
                    height: 50,
                    width: 260,
                    child: ListView(
                      children: [
                        DropdownButton<String>(
                          value: selectedOption,
                          style: const TextStyle(
                              color: Color.fromRGBO(97, 97, 97, 1)),
                          onChanged: (newValue) {
                            int index = snapshot.data!.indexWhere(
                              (book) => book.fields.title == newValue,
                            );
                            handleSelectedOption(newValue, index);
                          },
                          items: List.generate(
                            100,
                            (index) => DropdownMenuItem<String>(
                              value:
                                  '${snapshot.data![index].fields.title.length > 30 ? snapshot.data![index].fields.title.substring(0, 30) + '...' : snapshot.data![index].fields.title}',
                              child: Text(
                                '${snapshot.data![index].fields.title.length > 30 ? snapshot.data![index].fields.title.substring(0, 30) + '...' : snapshot.data![index].fields.title}',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Text(
                      '"$selectedActualTitle" is currently ranked $selectedRank by rating.',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        // overflow: TextOverflow.ellipsis,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 5),
                ],
              );
            }
          }
        });
  }
}
