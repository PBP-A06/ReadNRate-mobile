class Review {
  String username;
  String reviewText;

  Review({
    required this.username,
    required this.reviewText,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    String username = json["username"] ?? 'Anonymous';
    String reviewText = json["review_text"] ?? 'No review text provided';

    return Review(
      username: username,
      reviewText: reviewText,
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "review_text": reviewText,
      };
}
