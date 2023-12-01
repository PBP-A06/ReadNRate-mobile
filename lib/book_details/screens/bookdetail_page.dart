import 'package:flutter/material.dart';
import 'package:project/book/models/book.dart'; // Make sure to import your Book model correctly

class BookDetailPage extends StatelessWidget {
  final Book book;

  // Add 'const' before the constructor to make it a constant constructor
  const BookDetailPage({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Detail'),
        backgroundColor:
            Colors.grey[850], // Adjust the color to match the screenshot
      ),
      body: Container(
        color: Colors.black, // Background color
        child: Column(
          children: [
            Image.network(
              book.fields
                  .imageLink, // This should be the URL to the book cover image
              width: 150, // Set width for the image
              height: 220, // Set height for the image
              fit: BoxFit.cover, // Cover the bounds of the widget
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                book.fields.title, // Book title
                style: const TextStyle(
                  color: Colors.white, // Text color
                  fontSize: 24, // Font size
                  fontWeight: FontWeight.bold, // Font weight
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                book.fields.bookDescription, // Book description
                style: const TextStyle(
                  color: Colors.white, // Text color
                  fontSize: 16, // Font size
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                ),
                child: const Text('Review'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
