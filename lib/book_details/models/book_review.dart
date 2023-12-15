import 'dart:convert';

Review reviewFromJson(String str) => Review.fromJson(json.decode(str));

String reviewToJson(Review data) => json.encode(data.toJson());

class Review {
  String username;
  String reviewText;

  Review({
    required this.username,
    required this.reviewText,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        username: json["username"],
        reviewText: json["review_text"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "review_text": reviewText,
      };
}
