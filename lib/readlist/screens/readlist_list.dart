import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/home/widget/left_drawer.dart';
import 'dart:convert';

import 'package:project/readlist/screens/models/readlist.dart';



class ReadlistPage extends StatefulWidget {
  const ReadlistPage({Key? key}) : super(key: key);

  @override
  _ReadlistPageState createState() => _ReadlistPageState();
}

class _ReadlistPageState extends State<ReadlistPage> {
  Future<List<Readlist>> fetchProduct() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var url = Uri.parse('https://readnrate.adaptable.app/readlist/get-readlists/');
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
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Readlists'),
          backgroundColor: Colors.grey[800],
          foregroundColor: Colors.white,
        ),
        drawer: const LeftDrawer(),
        body: FutureBuilder(
            future: fetchProduct(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return const Column(
                    children: [
                      Text(
                        "Tidak ada data produk.",
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${snapshot.data![index].fields.name}",
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text("${snapshot.data![index].fields.likes}",
                                style: const TextStyle(color: Colors.white),),
                                const SizedBox(height: 10),
                                Text(
                                    "${snapshot.data![index].fields.description}",
                                  style: const TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ));
                }
              }
            }));
  }
}
