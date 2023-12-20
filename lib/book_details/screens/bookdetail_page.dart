import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'dart:convert';
import 'package:project/book/models/book.dart';
import 'package:project/book_details/models/book_review.dart';
import 'package:project/main/screens/login.dart';
import 'package:provider/provider.dart';

class BookDetailPage extends StatefulWidget {
  final Book book;

  const BookDetailPage({Key? key, required this.book}) : super(key: key);

  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  bool _isReviewVisible = false;
  bool _isLiked = false;
  bool _isBookmarked = false;
  int _likeCount = 0;
  final TextEditingController _reviewController = TextEditingController();
  List<Review> _reviews = [];

  @override
  void initState() {
    super.initState();
    if (isLoggedIn()) {
      _fetchLikeStatus();
      _fetchBookmarkStatus();
    } else {
      _fetchLikeCount();
    }
    _fetchReviews();
  }

  Future<void> _fetchReviews() async {
    String bookId = widget.book.pk.toString();
    var url = 'https://readnrate.adaptable.app/get_reviews/$bookId/';
    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> reviewsJson = json.decode(response.body.trim());
        setState(() {
          _reviews = reviewsJson.map((json) => Review.fromJson(json)).toList();
        });
      } else {
        print('Failed to load reviews: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching reviews: $e');
    }
  }

  Future<void> _fetchLikeStatus() async {
    final cookieRequest = Provider.of<CookieRequest>(context, listen: false);
    await cookieRequest.init();

    String bookId = widget.book.pk.toString();
    var url = 'https://readnrate.adaptable.app/get_like_status/$bookId/';

    try {
      var response = await cookieRequest.get(url);
      if (response['is_liked'] != null) {
        setState(() {
          _isLiked = response['is_liked'];
          _likeCount = response['like_count'];
        });
      }
    } catch (e) {
      print('Error fetching like status: $e');
    }
  }

  Future<void> _fetchBookmarkStatus() async {
    final cookieRequest = Provider.of<CookieRequest>(context, listen: false);
    if (!cookieRequest.initialized) await cookieRequest.init();

    if (!cookieRequest.loggedIn) {
      _fetchLikeCount();
      return;
    }

    String bookId = widget.book.pk.toString();
    var url = 'https://readnrate.adaptable.app/get_bookmark_status/$bookId/';

    try {
      var response = await cookieRequest.get(url);
      if (response['is_bookmarked'] != null) {
        setState(() {
          _isBookmarked = response['is_bookmarked'];
        });
      }
    } catch (e) {
      print('Error fetching bookmark status: $e');
    }
  }

  Future<void> _fetchLikeCount() async {
    String bookId = widget.book.pk.toString();
    var url = 'https://readnrate.adaptable.app/get_like_count/$bookId/';

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        setState(() {
          _likeCount = responseData['like_count'];
        });
      }
    } catch (e) {
      print('Error fetching like count: $e');
    }
  }

  bool isLoggedIn() {
    return usernameGlobal != null;
  }

  String getCurrentLoggedInUsername() {
    return usernameGlobal ?? '';
  }

  void _toggleReviewForm() {
    final cookieRequest = Provider.of<CookieRequest>(context, listen: false);
    if (!cookieRequest.loggedIn) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please log in to write a review.')),
      );
      return;
    }

    setState(() {
      _isReviewVisible = !_isReviewVisible;
    });
  }

  Future<void> _toggleLike() async {
    final cookieRequest = Provider.of<CookieRequest>(context, listen: false);
    if (!cookieRequest.loggedIn) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please log in to like the book.')),
      );
      return;
    }
    await cookieRequest.init();

    String bookId = widget.book.pk.toString();
    var url = 'https://readnrate.adaptable.app/toggle_like/$bookId/';

    try {
      var response = await cookieRequest.postJson(
        url,
        jsonEncode({}),
      );

      if (response['status'] == 'success') {
        setState(() {
          _isLiked = !_isLiked;
          _likeCount = response['total_likes'];
        });
      }
    } catch (e) {
      print('Error toggling like: $e');
    }
  }

  Future<void> _toggleBookmark() async {
    final cookieRequest = Provider.of<CookieRequest>(context, listen: false);
    if (!cookieRequest.loggedIn) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please log in to bookmark the book.')),
      );
      return;
    }
    await cookieRequest.init();

    String bookId = widget.book.pk.toString();
    var url = 'https://readnrate.adaptable.app/toggle_bookmark/$bookId/';

    try {
      var response = await cookieRequest.postJson(
        url,
        jsonEncode({}),
      );

      if (response['status'] == 'success') {
        setState(() {
          _isBookmarked = !_isBookmarked;
        });
      }
    } catch (e) {
      print('Error toggling bookmark: $e');
    }
  }

  void _submitReview() async {
    final cookieRequest = Provider.of<CookieRequest>(context, listen: false);
    await cookieRequest.init();

    if (!cookieRequest.loggedIn) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please log in to submit the review.')),
      );
      return;
    }

    String bookId = widget.book.pk.toString();
    var url = 'https://readnrate.adaptable.app/add_review/$bookId/';

    var responseJson = await cookieRequest.postJson(
      url,
      jsonEncode({'review_text': _reviewController.text}),
    );

    if (responseJson['success']) {
      Review review = Review.fromJson(responseJson);
      setState(() {
        _reviews.add(review);
        _reviewController.clear();
        _isReviewVisible = false;
      });
    } else {
      print('Failed to submit review: ${responseJson['error']}');
    }
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;

    double imageWidth = screenWidth * 0.35;
    double imageHeight = imageWidth * 1.5;
    double outerPadding = screenWidth * 0.04;
    double innerSpace = screenHeight * 0.01;
    double descriptionFontSize = screenWidth * 0.033;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomCenter,
          colors: [ Color.fromARGB(255, 36, 41, 49), Color.fromARGB(255, 24, 28, 33)]
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          // backgroundColor: const Color.fromARGB(255, 36, 41, 49), 
          backgroundColor: Colors.transparent, 
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: outerPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: innerSpace),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      widget.book.fields.imageLink,
                      width: imageWidth,
                      height: imageHeight,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: outerPadding),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: innerSpace),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.book.fields.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenWidth * 0.05,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(_isLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border),
                                  color: _isLiked ? Colors.red : Colors.white,
                                  onPressed: _toggleLike,
                                ),
                                Text(
                                  '$_likeCount',
                                  style: TextStyle(color: Colors.white),
                                ),
                                IconButton(
                                  icon: Icon(_isBookmarked
                                      ? Icons.bookmark
                                      : Icons.bookmark_border),
                                  color: _isBookmarked
                                      ? Colors.yellow
                                      : Colors.white,
                                  onPressed: _toggleBookmark,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: innerSpace),
                Container(
                  margin: EdgeInsets.symmetric(vertical: innerSpace),
                  padding: EdgeInsets.all(innerSpace),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Text(
                    widget.book.fields.bookDescription,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: descriptionFontSize,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border:
                                Border(bottom: BorderSide(color: Colors.white)),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              onPressed: _toggleReviewForm,
                              child: Text(
                                'Review',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Icon(Icons.chat_bubble_outline, color: Colors.white),
                    ],
                  ),
                ),
                if (_isReviewVisible)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      color: Colors.grey[850],
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextField(
                              controller: _reviewController,
                              maxLines: null,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Write your review here...',
                                hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.6)),
                                border: InputBorder.none,
                              ),
                            ),
                            TextButton(
                              onPressed: _submitReview,
                              child: Text(
                                'Submit Review',
                                style: TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ..._reviews
                    .map((review) => Container(
                          margin: EdgeInsets.all(8.0),
                          padding: EdgeInsets.only(
                            top: 8.0,
                            bottom: 8.0,
                            left: 16.0,
                            right: 16.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[850],
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            border: Border.all(color: Colors.grey[300]!),
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
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.7)),
                            ),
                          ),
                        ))
                    .toList(),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
