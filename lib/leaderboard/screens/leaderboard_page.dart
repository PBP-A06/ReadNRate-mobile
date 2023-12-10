import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/book/models/book.dart';
import 'package:project/home/widget/left_drawer.dart';
import 'package:project/leaderboard/widget/leaderboard_card.dart';

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
          // 'https://readnrate.adaptable.app/leaderboard/get-10-best-rated-books/');
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
                  return SingleChildScrollView(
                    // Widget wrapper yang dapat discroll
                    child: Padding(
                      padding:
                          const EdgeInsets.all(10), // Set padding dari halaman
                      child: Column(
                        // Widget untuk menampilkan children secara vertikal
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(10),
                            // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
                            child: Text(
                              'Leaderboard by Rating', // Text yang menandakan toko
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          // Grid layout
                          GridView.count(
                            // Container pada card kita.
                            primary: true,
                            padding: const EdgeInsets.all(10),
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            childAspectRatio: 0.55,
                            children:
                                (snapshot.data! as List<Book>).map((Book book) {
                              return BookCard(book);
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              }
            }));
  }
}

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:project/book/models/book.dart';
// import 'package:project/home/widget/left_drawer.dart';

// class LeaderboardPage extends StatefulWidget {
//   const LeaderboardPage({Key? key}) : super(key: key);

//   @override
//   _LeaderboardPageState createState() => _LeaderboardPageState();
// }

// class _LeaderboardPageState extends State<LeaderboardPage> {
//   @override
//   Widget build(BuildContext context) {
//     Future<List<Book>> fetchBook() async {
//       var url = Uri.parse(
//           // 'https://readnrate.adaptable.app/leaderboard/get-10-best-rated-books/');
//           'http://localhost:8000/leaderboard/get-10-best-rated-books/');
//       var response = await http.get(
//         url,
//         headers: {"Content-Type": "application/json"},
//       );

//       // melakukan decode response menjadi bentuk json
//       var data = jsonDecode(utf8.decode(response.bodyBytes));

//       // melakukan konversi data json menjadi object Book
//       List<Book> list_book = [];
//       for (var d in data) {
//         if (d != null) {
//           list_book.add(Book.fromJson(d));
//         }
//       }
//       return list_book;
//     }

//     return Scaffold(
//         backgroundColor: Colors.black,
//         appBar: AppBar(
//           title: const Text('Daftar Buku'),
//           backgroundColor: Colors.grey[800],
//           foregroundColor: Colors.white,
//         ),
//         // Masukkan drawer sebagai parameter nilai drawer dari widget Scaffold
//         drawer: const LeftDrawer(),
//         body: FutureBuilder(
//             future: fetchBook(),
//             builder: (context, AsyncSnapshot snapshot) {
//               if (snapshot.data == null) {
//                 return const Center(child: CircularProgressIndicator());
//               } else {
//                 if (!snapshot.hasData) {
//                   return const Column(
//                     children: [
//                       Text(
//                         "Tidak ada data buku.",
//                         style:
//                             TextStyle(color: Color(0xff59A5D8), fontSize: 20),
//                       ),
//                       SizedBox(height: 8),
//                     ],
//                   );
//                 } else {
//                   return ListView.builder(
//                       itemCount: snapshot.data!.length,
//                       itemBuilder: (_, index) => Container(
//                           margin: const EdgeInsets.symmetric(
//                               horizontal: 12, vertical: 12),
//                           padding: const EdgeInsets.all(10.0),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "${index + 1}. ${snapshot.data![index].fields.title}",
//                                 style: const TextStyle(
//                                   fontSize: 18.0,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                   fontStyle: FontStyle.italic,
//                                 ),
//                               ),
//                               const SizedBox(height: 10),
//                               Text(
//                                 "${snapshot.data![index].fields.category}",
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               const SizedBox(height: 10),
//                               Image.network(
//                                 "${snapshot.data![index].fields.imageLink}",
//                                 width: 125.0,
//                               ),
//                               const SizedBox(height: 10),
//                               ElevatedButton(
//                                 style: ButtonStyle(
//                                   backgroundColor:
//                                       MaterialStateProperty.all<Color>(
//                                           Colors.grey.shade700),
//                                 ),
//                                 onPressed: () {
//                                   // Navigator.push(
//                                   //   context,
//                                   //   MaterialPageRoute(
//                                   //       builder: (context) => BookDetailsPage(
//                                   //           snapshot.data![index])),
//                                   // );
//                                 },
//                                 child: const Text(
//                                   "See Details",
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                               ),
//                             ],
//                           )));
//                 }
//               }
//             }));
//   }
// }
