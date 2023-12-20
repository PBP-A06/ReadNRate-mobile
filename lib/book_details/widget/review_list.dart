import 'package:flutter/material.dart';
import 'package:project/book_details/models/book_review.dart';

class ReviewListItem extends StatelessWidget {
  final Review review;

  const ReviewListItem({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 17, 21, 26),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
        border: Border.all(color: Color.fromARGB(255, 228, 106, 19)),
      ),
      child: ListTile(
        title: Text(
          review.username,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        subtitle: Text(
          review.reviewText,
          style: TextStyle(color: Colors.white.withOpacity(0.9)),
        ),
      ),
    );
  }
}
