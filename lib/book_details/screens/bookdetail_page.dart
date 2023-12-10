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
    double cmToPixels(double cm) =>
        cm * 38.8; // Adjust the multiplier according to your screen's dpi

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
            padding: EdgeInsets.symmetric(horizontal: cmToPixels(1)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: cmToPixels(1)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      widget.book.fields.imageLink,
                      width: cmToPixels(7),
                      height: cmToPixels(10),
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: cmToPixels(1)),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: cmToPixels(1)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.book.fields.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
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
                SizedBox(height: cmToPixels(1)),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Text(
                    widget.book.fields.bookDescription,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.white)),
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
                    .map((review) => ListTile(
                          title: Text(
                            review['username']!,
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            review['review']!,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ))
                    .toList(),
                SizedBox(
                    height: 50), // Add more space at the bottom of the page
              ],
            ),
          ),
        ),
      ),
    );
  }
}
