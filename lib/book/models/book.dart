// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

Book bookFromJson(String str) => Book.fromJson(json.decode(str));

String bookToJson(Book data) => json.encode(data.toJson());

class Book {
    String model;
    int pk;
    Fields fields;

    Book({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Book.fromJson(Map<String, dynamic> json) => Book(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    String title;
    String category;
    int numberOfReviews;
    String bookDescription;
    String imageLink;
    int stars;
    int likes;
    List<int> likedBy;
    List<int> bookmarkedBy;

    Fields({
        required this.title,
        required this.category,
        required this.numberOfReviews,
        required this.bookDescription,
        required this.imageLink,
        required this.stars,
        required this.likes,
        required this.likedBy,
        required this.bookmarkedBy,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        title: json["title"],
        category: json["category"],
        numberOfReviews: json["number_of_reviews"],
        bookDescription: json["book_description"],
        imageLink: json["image_link"],
        stars: json["stars"],
        likes: json["likes"],
        likedBy: List<int>.from(json["liked_by"].map((x) => x)),
        bookmarkedBy: List<int>.from(json["bookmarked_by"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "category": category,
        "number_of_reviews": numberOfReviews,
        "book_description": bookDescription,
        "image_link": imageLink,
        "stars": stars,
        "likes": likes,
        "liked_by": List<dynamic>.from(likedBy.map((x) => x)),
        "bookmarked_by": List<dynamic>.from(bookmarkedBy.map((x) => x)),
    };
}
