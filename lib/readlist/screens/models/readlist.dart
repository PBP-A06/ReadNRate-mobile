// To parse this JSON data, do
//
//     final readlist = readlistFromJson(jsonString);

import 'dart:convert';

List<Readlist> readlistFromJson(String str) =>
    List<Readlist>.from(json.decode(str).map((x) => Readlist.fromJson(x)));

String readlistToJson(List<Readlist> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Readlist {
  String model;
  int pk;
  Fields fields;

  Readlist({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Readlist.fromJson(Map<String, dynamic> json) => Readlist(
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
  int user;
  String name;
  String description;
  int likes;
  List<int> books;
  List<int> likedBy;

  Fields({
    required this.user,
    required this.name,
    required this.description,
    required this.likes,
    required this.books,
    required this.likedBy,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        name: json["name"],
        description: json["description"],
        likes: json["likes"],
        books: List<int>.from(json["books"].map((x) => x)),
        likedBy: List<int>.from(json["liked_by"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "name": name,
        "description": description,
        "likes": likes,
        "books": List<dynamic>.from(books.map((x) => x)),
        "liked_by": List<dynamic>.from(likedBy.map((x) => x)),
      };
}
