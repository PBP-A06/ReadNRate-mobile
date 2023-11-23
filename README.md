# ReadNRate - _Mobile Version_ ![Jekyll site CI](https://github.com/gede-books/gede-books/workflows/Jekyll%20site%20CI/badge.svg)
https://readnrate.adaptable.app/
[![Deploy](https://github.com/PBP-A06/ReadNRate/workflows/Deploy/badge.svg)](https://github.com/PBP-A06/ReadNRate/actions?query=workflow:"Deploy")
[![GitHub tag](https://img.shields.io/github/tag/PBP-A06/ReadNRate?include_prereleases=&sort=semver&color=blue)](https://github.com/PBP-A06/ReadNRate/releases/)
[![License](https://img.shields.io/badge/License-MIT-blue)](#license)


## Link _Spreadsheet_ Berita Acara:
https://docs.google.com/spreadsheets/d/1d7Pe_p0Om0DrqAAr2B95EZXYwV76Dnk9ytXRWAJyIvQ/edit?usp=sharing

## Daftar Anggota A06:

- 2206083445 - Soros Febriano <br>
- 2206824073 - Muhammad Fatih Zain <br>
- 2206031864 - Ravie Hasan Abud <br>
- 2206083451 - Arditheus Immanuel Hanfree <br>
- 2206813662 - Daffa Al Fathan Zaki <br>

## Latar Belakang dan Deskripsi Aplikasi

Seiring berkembangnya zaman, aktivitas literasi semakin beralih ke digitalisasi. Sebagaimana kita ketahui, Indonesia memiliki tingkat literasi di bawah rata-rata. Masyarakat Indonesia memiliki motivasi yang tergolong rendah karena kurangnya dorongan untuk membaca. Selain itu, mereka juga menghadapi kesulitan untuk mencari buku yang sesuai dengan preferensi mereka karena tidak tersedianya platform yang membantu hal tersebut. Oleh karena itu, muncul sebuah ide untuk membuat sebuah platform berbasis interaksi pengguna untuk meningkatkan efisiensi pencarian buku dan minat baca masyarakat. Aplikasi tersebut adalah **ReadNRate**.

**ReadNRate** dirancang dengan harapan dapat membuka minat masyarakat Indonesia terhadap budaya membaca yang sebenarnya menarik, sehingga pengetahuan dan keterampilan masyarakat meningkat. **ReadNRate** menyediakan berbagai fitur, seperti rekomendasi buku bacaan sesuai preferensi pembaca, sistem leaderboard yang menunjukkan buku favorit seluruh pengguna, hingga katalog buku yang dapat dibuat pembaca sesuai tema yang diinginkan. Pembaca diberikan kebebasan untuk menuliskan ulasan dan menyimpan koleksi buku pada profile yang dapat dilihat oleh teman atau publik. Semua ini sesuai dengan misi **ReadNRate**, yaitu menjadi platform bagi para pembaca untuk menemukan buku yang mereka suka dan mendorong mereka untuk menggali dunia literasi lebih dalam.

**ReadNRate** adalah sebuah aplikasi global berbasis _mobile_ yang didirikan pada 2023 dan dirancang sebagai komunitas tempat berkumpul para penggemar buku sejati. Situs ini mengajak seluruh pembaca untuk menilai dan memberikan saran pada buku yang sudah mereka baca sehingga dapat menjadi pertimbangan buku bacaan selanjutnya bagi orang lain.

Misi kami adalah untuk membantu para pembaca menemukan buku yang mereka sukai dan mendapat lebih banyak ilmu dari membaca.

Kami menyediakan dan menganalisis lebih dari 100 buku untuk Anda nilai dan juga memberikan saran yang disesuaikan dengan selera literasi Anda.

## Daftar Modul dan Pengembang

1. **Leaderboard** (Ravie Hasan Abud)
   - Dibagi menjadi 3 jenis leaderboard:
     1. Books Leaderboard by Rating: buku dengan rating tertinggi
     2. Books Leaderboard by Likes: buku paling populer (likes terbanyak)
     3. Readlist Leaderboard: readlist terbaik (likes terbanyak)
   - Dapat mencari peringkat suatu buku berdasarkan rating
2. **Readlist** (Arditheus Immanuel Hanfree)
   - Pengguna dapat menambahkan daftar bacaan sendiri, seperti fitur “playlist” pada music player.
   - Merupakan halaman yang menampilkan 5 readlist yang telah dibuat oleh seluruh user yang terdaftar.
3. **Profile: History & Top 3 Books** (Daffa Al Fathan Zaki)
   - Menampilkan seluruh buku yang telah dibaca user.
   - Menampilkan 3 buku terbaik menurut user.
4. **Bookmarks & Likes** (Muhammad Fatih Zain & Daffa Al Fathan Zaki)
   - Melacak buku yang sedang Anda baca, telah Anda baca, dan ingin Anda baca.
   - Halaman bookmarks dapat digunakan untuk lihat buku mana saja yang sedang dibaca atau ingin dibaca di masa depan.
   - Merupakan sebuah tombol pada halaman review.
   - Hanya dapat dilihat oleh user sendiri secara private.
5. **Review** (Muhammad Fatih Zain)
   - Menambahkan buku yang dipilih ke daftar buku yang telah dibaca user dan meminta rating user mengenai buku tersebut.
   - User dapat memberikan comment untuk menyampaikan review terhadap buku.
   - Pengguna dapat memberikan rating buku dengan skala 5.
6. **Home Page** (Soros Febriano)
   - Menampilkan 5 buku secara acak
   - Menampilkan _navigation bar_ yang mengarah ke list seluruh buku, readlist, leaderboard, dan sign in atau sign up.
7. **Register dan Sign In** (Soros Febriano)
   - Autentikasi dan otorisasi pengguna

## Daftar Peran Pengguna

1. _Reader_ (Telah Login):
   - Menelusuri buku yang terdaftar
   - Menelusuri Leaderboard
   - Menelusuri Readlists
   - Menelusuri profile user lain
   - Menghapus atau menambahkan penilaian buku
   - Mengelola profil pribadi (profile picture, username, dan lain-lain)
   - Memberikan buku review dan/atau rating
   - Menandai (bookmark) dan/atau menyukai (like) buku
   - Menentukan top 3 buku pribadi
   - Mengelola readlist pribadi
2. _Guest_ (Tidak Login):
   - Menelusuri buku yang terdaftar
   - Menelusuri Leaderboard
   - Menelusuri Readlists

## Alur Pengintegrasian dengan Aplikasi Web
Mengimplementasikan sebuah wrapper class dengan menggunakan library http dan map untuk mendukung penggunaan cookie-based authentication pada aplikasi. 
<br>
↓
<br>
Mengimplementasikan REST API pada Django (views.py) dengan menggunakan JsonResponse atau Django JSON Serializer.
<br>
↓
<br>
Mengimplementasikan desain front-end untuk aplikasi berdasarkan desain website yang sudah ada sebelumnya.
<br>
↓
<br>
Melakukan integrasi antara front-end dengan back-end dengan menggunakan konsep asynchronous HTTP.<br>
