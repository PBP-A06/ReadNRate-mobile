import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/leaderboard/widget/readlist_leaderboard_card.dart';
import 'dart:convert';
import 'package:project/readlist/screens/models/readlist.dart';

class ReadlistPage extends StatefulWidget {
  const ReadlistPage({Key? key}) : super(key: key);

  @override
  _ReadlistPageState createState() => _ReadlistPageState();
}

class _ReadlistPageState extends State<ReadlistPage> {
  Future<List<Readlist>> fetchReadlists() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var url =
        Uri.parse('https://readnrate.adaptable.app/readlist/get-readlists/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<Readlist> list_product = [];
    for (var d in data) {
      if (d != null) {
        list_product.add(Readlist.fromJson(d));
      }
    }
    return list_product;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // Masukkan drawer sebagai parameter nilai drawer dari widget Scaffold
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: AlignmentDirectional.topStart,
                  end: AlignmentDirectional.bottomCenter,
                  colors: [
                Color.fromARGB(255, 36, 41, 49),
                Color.fromARGB(255, 24, 28, 33)
              ])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: FutureBuilder(
              future: fetchReadlists(),
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
              }),
        ));
  }
}
