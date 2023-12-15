import 'package:flutter/material.dart';
import 'package:project/book/models/book.dart';

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
  final List<Map<String, String>> _reviews = [];

  void _toggleReviewForm() {
    setState(() {
      _isReviewVisible = !_isReviewVisible;
    });
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _likeCount += _isLiked ? 1 : -1;
    });
  }

  void _toggleBookmark() {
    setState(() {
      _isBookmarked = !_isBookmarked;
    });
  }

  void _submitReview() {
    if (_reviewController.text.isNotEmpty) {
      setState(() {
        _reviews.add({
          'username': 'xx', // Temporary username
          'review': _reviewController.text,
        });
        _reviewController.clear();
        _isReviewVisible = false;
      });
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

    // Adjusted the proportions
    double imageWidth =
        screenWidth * 0.35; // Reduced the width to 35% of the screen width
    double imageHeight =
        imageWidth * 1.5; // Maintaining aspect ratio of the image
    double outerPadding =
        screenWidth * 0.04; // Increased padding to 4% of the screen width
    double innerSpace =
        screenHeight * 0.01; // Adjusted space to 1% of the screen height
    double descriptionFontSize =
        screenWidth * 0.033; // Reduced font size for the description

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Detail'),
        backgroundColor: Colors.grey[850],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
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
                                fontSize:
                                    screenWidth * 0.05, // Adjusted font size
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
                            color: Colors.grey[850], // Changed to a gray color
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: ListTile(
                            title: Text(
                              review['username']!,
                              style: TextStyle(
                                color:
                                    Colors.white, // Text color changed to white
                                fontWeight:
                                    FontWeight.bold, // Make the username bold
                                fontSize: 16.0, // Increase the font size
                              ),
                            ),
                            subtitle: Text(
                              review['review']!,
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
