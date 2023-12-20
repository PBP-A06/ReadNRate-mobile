import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:project/book/models/book.dart';
import 'package:provider/provider.dart';

Future<List<Book>> fetchBooks(CookieRequest cookieRequest) async {
  final response = await http.get(
    Uri.parse('https://readnrate.adaptable.app/profile/json/'),
  );

  if (response.statusCode == 200) {
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    List<Book> listBook = [];

    for (var d in data['books_read']) {
      if (d != null) {
        listBook.add(Book.fromJson(d['fields']));
      }
    }

    for (var d in data['bookmarked_books']) {
      if (d != null) {
        listBook.add(Book.fromJson(d['fields']));
      }
    }

    for (var d in data['liked_books']) {
      if (d != null) {
        listBook.add(Book.fromJson(d['fields']));
      }
    }

    return listBook;
  } else {
    throw Exception('Failed to load profile data');
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cookieRequest = Provider.of<CookieRequest>(context, listen: false);
    return FutureBuilder<List<Book>>(
      future: fetchBooks(cookieRequest),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          if (snapshot.hasData) {
            List<Book>? books = snapshot.data;
            return Container(
              child: Text('Fetched ${books?.length} books!'),
            );
          } else {
            return Text('No data available');
          }
        }
      },
    );
  }
}
