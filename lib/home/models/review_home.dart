// To parse this JSON data, do
//
//     final reviewHome = reviewHomeFromJson(jsonString);

import 'dart:convert';

ReviewHome reviewHomeFromJson(String str) => ReviewHome.fromJson(json.decode(str));

String reviewHomeToJson(ReviewHome data) => json.encode(data.toJson());

class ReviewHome {
    int bookId;
    String bookTitle;
    String bookCover;
    String username;
    String reviewText;

    ReviewHome({
        required this.bookId,
        required this.bookTitle,
        required this.bookCover,
        required this.username,
        required this.reviewText,
    });

    factory ReviewHome.fromJson(Map<String, dynamic> json) => ReviewHome(
        bookId: json["book_id"],
        bookTitle: json["book_title"],
        bookCover: json["book_cover"],
        username: json["username"],
        reviewText: json["review_text"],
    );

    Map<String, dynamic> toJson() => {
        "book_id": bookId,
        "book_title": bookTitle,
        "book_cover": bookCover,
        "username": username,
        "review_text": reviewText,
    };
}
