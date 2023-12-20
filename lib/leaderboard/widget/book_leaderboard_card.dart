import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/book/models/book.dart';
import 'package:project/book_details/screens/bookdetail_page.dart';

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
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: FadeInImage(
                    placeholder:
                        const AssetImage('assets/ReadNRate Logo 2.png'),
                    // rounded image
                    image: NetworkImage(
                      book.fields.imageLink,
                    ),
                    width: 115.0,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text("${book.fields.title}",
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.almarai(
                      textStyle: const TextStyle(color: Colors.white))),
              const SizedBox(height: 5),
              Text(
                "--${book.fields.category}",
                textAlign: TextAlign.right,
                style: GoogleFonts.almarai(
                    textStyle: const TextStyle(color: Colors.white)),
              ),
              const Spacer(),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.grey.shade500),
                  ),
                  // nanti redirect to details page di modul book_review
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BookDetailPage(book: book)),
                    );
                  },
                  child: Text(
                    "See Details",
                    style: GoogleFonts.almarai(
                        textStyle:
                            const TextStyle(color: Colors.white, fontSize: 13,)),
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
