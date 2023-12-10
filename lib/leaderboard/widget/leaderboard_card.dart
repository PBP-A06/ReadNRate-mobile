import 'package:flutter/material.dart';
import 'package:project/book/models/book.dart';

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard(this.book, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Material(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(40),
        child: Container(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ClipRRect(
              //   // rounded image
              //   borderRadius: BorderRadius.circular(15.0),
              //   child: Image.network(
              //     "${book.fields.imageLink}",
              //     width: 150.0,
              //   ),
              // ),
              Center(
                child: ClipRRect(
                  // rounded image
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    "https://placehold.co/170x200/png",
                    width: 170,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "${book.fields.title}",
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "--${book.fields.category}",
                textAlign: TextAlign.right,
                style: const TextStyle(color: Colors.white),
              ),
              const Spacer(),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.grey.shade500),
                  ),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => BookDetailsPage(
                    //           book)),
                    // );
                  },
                  child: const Text(
                    "See Details",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
