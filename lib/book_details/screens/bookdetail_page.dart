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
                color: Colors.white24, // Warna latar belakang kontainer
                borderRadius:
                    BorderRadius.circular(8), // Radius sudut kontainer
              ),
              child: Text(
                widget.book.fields.bookDescription, // Deskripsi buku
                style: const TextStyle(
                  color: Colors.white, // Warna teks
                  fontSize: 16, // Ukuran font
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Center(
                child: ElevatedButton(
                  onPressed:
                      _toggleReviewForm, // Memanggil fungsi untuk mengganti visibilitas form review
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color.fromARGB(255, 18, 40, 58),
                  ),
                  child: const Text('Review'),
                ),
              ),
            ),
            if (_isReviewVisible) // Jika _isReviewVisible true, tampilkan form review
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Write your review here...',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
