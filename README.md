# ReadNRate - _Mobile Version_ 

![staging](https://github.com/PBP-A06/ReadNRate-mobile/actions/workflows/staging.yml/badge.svg)
![pre-release](https://github.com/PBP-A06/ReadNRate-mobile/actions/workflows/pre-release.yml/badge.svg)
![release](https://github.com/PBP-A06/ReadNRate-mobile/actions/workflows/release.yml/badge.svg)
[![Build status](https://build.appcenter.ms/v0.1/apps/3ed7a656-b1f2-40a1-9b7b-538c7a9913d8/branches/main/badge)](https://appcenter.ms)

[![License](https://img.shields.io/badge/License-MIT-blue)](#license)

#### _Web Version_: https://readnrate.adaptable.app/
#### APK _Mobile Version_: https://install.appcenter.ascacascxms/orgs/readnrate/apps/readnrate/distribution_groups/public

## Daftar Anggota A06:

- 2206083445 - Soros Febriano <br>
- 2206824073 - Muhammad Fatih Zain <br>
- 2206031864 - Ravie Hasan Abud <br>
- 2206083451 - Arditheus Immanuel Hanfree <br>
- 2206813662 - Daffa Al Fathan Zaki <br>

## Latar Belakang dan Deskripsi Aplikasi

Seiring berkembangnya zaman, aktivitas literasi semakin beralih ke digitalisasi. Sebagaimana kita ketahui, Indonesia memiliki tingkat literasi di bawah rata-rata. Masyarakat Indonesia memiliki motivasi yang tergolong rendah karena kurangnya dorongan untuk membaca. Selain itu, mereka juga menghadapi kesulitan untuk mencari buku yang sesuai dengan preferensi mereka karena tidak tersedianya platform yang membantu hal tersebut. Oleh karena itu, muncul sebuah ide untuk membuat sebuah platform berbasis interaksi pengguna untuk meningkatkan efisiensi pencarian buku dan minat baca masyarakat. Aplikasi tersebut adalah **ReadNRate**.

**ReadNRate** dirancang dengan harapan dapat membuka minat masyarakat Indonesia terhadap budaya membaca yang sebenarnya menarik, sehingga pengetahuan dan keterampilan masyarakat meningkat. **ReadNRate** menyediakan berbagai fitur, seperti rekomendasi buku bacaan sesuai preferensi pembaca, sistem leaderboard yang menunjukkan buku favorit seluruh pengguna, hingga katalog buku yang dapat dibuat pembaca sesuai tema yang diinginkan. Pembaca diberikan kebebasan untuk menuliskan ulasan dan menyimpan koleksi buku pada profile yang dapat dilihat oleh teman atau publik. Semua ini sesuai dengan misi **ReadNRate**, yaitu menjadi platform bagi para pembaca untuk menemukan buku yang mereka suka dan mendorong mereka untuk menggali dunia literasi lebih dalam.

**ReadNRate** adalah sebuah aplikasi global berbasis _mobile_ yang didirikan pada 2023 dan dirancang sebagai komunitas tempat berkumpul para penggemar buku sejati. Situs ini mengajak seluruh pembaca untuk menilai dan memberikan saran pada buku yang sudah mereka baca sehingga dapat menjadi pertimbangan buku bacaan selanjutnya bagi orang lain. Misi kami adalah untuk membantu para pembaca menemukan buku yang mereka sukai dan mendapat lebih banyak ilmu dari membaca. Kami menyediakan dan menganalisis lebih dari 100 buku untuk Anda nilai dan juga memberikan saran yang disesuaikan dengan selera literasi Anda.

## Daftar Modul dan Pengembang

1. **_Leaderboard_** (Ravie Hasan Abud)
   - Dibagi menjadi 3 jenis _leaderboard_:
     1. _Books Leaderboard by Rating_: buku dengan _rating_ tertinggi.
     2. _Books Leaderboard by Likes_: buku paling populer (_likes_ terbanyak).
     3. _Readlist Leaderboard_: _readlist_ terbaik (_likes_ terbanyak).
   - Dapat mencari peringkat suatu buku berdasarkan rating.
2. **_Readlist_** (Arditheus Immanuel Hanfree)
   - Pengguna dapat menambahkan daftar bacaan sendiri, seperti fitur “_playlist_” pada _music player_.
   - Merupakan halaman yang menampilkan 5 _readlist_ yang telah dibuat oleh seluruh pengguna yang terdaftar.
3. **_Profile: History & Top 3 Books_** (Daffa Al Fathan Zaki)
   - Menampilkan seluruh buku yang telah dibaca pengguna.
   - Menampilkan 3 buku terbaik menurut pengguna.
4. **_Bookmarks & Likes_** (Muhammad Fatih Zain & Daffa Al Fathan Zaki)
   - Melacak buku yang sedang Anda baca, telah Anda baca, dan ingin Anda baca.
   - Halaman _bookmarks_ dapat digunakan untuk melihat buku mana saja yang sedang dibaca atau ingin dibaca di masa depan.
   - Merupakan sebuah tombol pada halaman _review_.
   - Hanya dapat dilihat oleh user sendiri (_private_).
5. **_Review_** (Muhammad Fatih Zain)
   - Menambahkan buku yang dipilih ke daftar buku yang telah dibaca pengguna dan meminta _rating_ pengguna mengenai buku tersebut.
   - Pengguna dapat memberikan komen untuk menyampaikan _review_ terhadap buku.
   - Pengguna dapat memberikan _rating_ buku dengan skala 5.
6. **_Home Page_** (Soros Febriano)
   - Menampilkan 5 buku secara acak.
   - Menampilkan _navigation bar_ yang mengarah ke daftar seluruh buku, _readlist_, _leaderboard_, dan _sign in_ atau _register_.
7. **_Register_ dan _Sign In_** (Soros Febriano)
   - Autentikasi dan otorisasi pengguna.

## Daftar Peran Pengguna

1. _Reader_ (Telah Login):
   - Menelusuri buku yang terdaftar.
   - Menelusuri _Leaderboard_.
   - Menelusuri _Readlist(s)_.
   - Menelusuri _profile_ pengguna lain.
   - Menghapus atau menambahkan penilaian buku.
   - Mengelola profil pribadi (_profile picture_, _username_, dan lain-lain).
   - Memberikan _review_ dan/atau _rating_ pada buku.
   - Menandai (_bookmark_) dan/atau menyukai (_like_) buku.
   - Menentukan top 3 buku pribadi.
   - Mengelola _readlist_ pribadi.
2. _Guest_ (Tidak Login):
   - Menelusuri buku yang terdaftar.
   - Menelusuri _Leaderboard_.
   - Menelusuri _Readlist(s)_.

## Alur Pengintegrasian dengan Aplikasi Web

Menyesuaikan tampilan versi _mobile app_ agar selaras dengan tampilan _web app_.
<br>
↓
<br>
Menggunakan `package:pbp_django_auth/pbp_django_auth.dart` untuk beberapa fungsi, seperti `postJson`, `login`, `logout`, dan lain sebagainya.
<br>
↓
<br>
Membuat _class_ untuk _model_ dan mengimplementasikannya sesuai dengan _object_ yang diperlukan pada _web app_.
<br>
↓
<br>
Mengimplementasikan Django REST API untuk sinkronisasi data _web app_ dan _mobile app_ dengan memanfaatkan JSON, baik ketika mengambil data (_GET_) maupun menyimpan data ke (_POST_).
<br>
↓
<br>
Menggunakan `Future` untuk _fetch_ data dari _web app_ melalui HTTP GET request dan melakukan _parse_ data JSON dari _response_ tersebut menjadi _object_ Dart sesuai dengan atribut yang telah dibuat pada _class_ untuk _model_.
<br>
↓
<br>
Menggunakan `postJson` untuk menyimpan data (_POST_) dan memastikan data tersebut terintegrasi dengan _web app_.

## Tautan _Spreadsheet_ Berita Acara:
https://docs.google.com/spreadsheets/d/1d7Pe_p0Om0DrqAAr2B95EZXYwV76Dnk9ytXRWAJyIvQ/edit?usp=sharing
