import 'package:flutter/material.dart';
import 'package:project/book/models/book.dart';
import 'package:project/book_details/screens/bookdetail_page.dart';

class BookCardHome extends StatelessWidget {
  final Book book;

  const BookCardHome(this.book, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailPage(book: book),
          ),
        );
      },
      child: InkWell(
        splashColor: Colors.white,
        child: FadeInImage(
          placeholder: const AssetImage('assets/ReadNRate Logo 2.png'),
          image: NetworkImage(book.fields.imageLink),
          width: double.infinity,
        ),
      ),
    );
  }
}
