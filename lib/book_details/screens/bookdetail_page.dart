import 'package:flutter/material.dart';
import 'package:project/book/models/book.dart'; // Pastikan mengimpor model Book dengan benar

class BookDetailPage extends StatefulWidget {
  final Book book;

  const BookDetailPage({Key? key, required this.book}) : super(key: key);

  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  bool _isReviewVisible = false; // Flag untuk mengatur visibilitas form review

  void _toggleReviewForm() {
    setState(() {
      _isReviewVisible = !_isReviewVisible; // Mengganti status visibilitas
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Detail'),
        backgroundColor: Colors.grey[850],
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  widget.book.fields.imageLink, // URL ke gambar sampul buku
                  width: 150, // Lebar gambar
                  height: 220, // Tinggi gambar
                  fit: BoxFit
                      .cover, // Sesuaikan ukuran gambar dengan batas widget
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.book.fields.title, // Judul buku
                          style: const TextStyle(
                            color: Colors.white, // Warna teks
                            fontSize: 24, // Ukuran font
                            fontWeight: FontWeight.bold, // Berat font
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                  Icons.favorite), // Ikon berbentuk hati
                              color: Colors.white,
                              onPressed: () {}, // Fungsi untuk 'like'
                            ),
                            IconButton(
                              icon: const Icon(Icons.bookmark),
                              color: Colors.white,
                              onPressed: () {}, // Fungsi untuk 'bookmark'
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white), // Menambahkan border
              ),
              child: Text(
                widget.book.fields.bookDescription,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),

            // Padding untuk tombol Review dengan container border
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

            // Kondisi untuk menampilkan TextFormField dan TextButton Submit
            if (_isReviewVisible)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      maxLines: 5,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Write your review here...',
                        fillColor: Colors.grey,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        hintStyle:
                            TextStyle(color: Colors.white.withOpacity(0.6)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
                    child: TextButton(
                      onPressed: () {
                        // TODO: Implement submit review action
                      },
                      child: Text(
                        'Submit Review',
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
