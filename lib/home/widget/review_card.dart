import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/home/models/review_home.dart';

class ReviewCard extends StatelessWidget {
  final ReviewHome review;

  const ReviewCard(this.review, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Part 1: Book Cover on the Left
          SizedBox(
              width: 100, // Adjust the width as needed
              child: FadeInImage(
                placeholder: const AssetImage('assets/ReadNRate Logo 2.png'),
                image: NetworkImage(review.bookCover),
              ),
            ),
          
          // Part 2: Texts on the Right
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10), // Adjust padding as needed
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Padding(
                    padding: const EdgeInsets.only(top:8.0, left: 10.0),
                    child: Text(
                      review.bookTitle.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.patuaOne(
                        color: Colors.white,
                        fontSize: 20
                      )                     
                    ),
                  ),
            
                    const SizedBox(height: 3),
            
                  // Username
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.account_circle, 
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 5),
                        Column(
                          children: [
                            Text(
                              review.username,
                              style: GoogleFonts.almarai(
                                textStyle: const TextStyle(
                                  color: Colors.white, 
                                  fontSize: 16
                                )
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              review.reviewText,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 189, 203, 218),
                              )
                            ),
                          ],
                        ),
                      ]
                    ),
                  ),
            
                  ],
                ),
              ),
          ),
    
        ],
      ),
  );
  }
}
