Aplikasi Pemesanan Tiket Bioskop - JSP Web App

Aplikasi web sederhana untuk memesan tiket bioskop menggunakan teknologi JSP (Java Server Pages) tanpa menggunakan database. Aplikasi ini mencakup tampilan daftar film, form pemesanan, dan struk digital. Didesain dengan antarmuka modern menggunakan Bootstrap dan animasi emoji yang menarik.

Struktur Halaman:
1. `index.jsp`
   Halaman utama yang menampilkan daftar film yang tersedia. Pengguna dapat mencari film dan melihat informasi seperti genre, durasi, harga, dan jam tayang. Terdapat tombol untuk menuju ke form pemesanan.
2. `formPesan.jsp`  
   Halaman formulir pemesanan tiket. Pengguna diminta mengisi nama, jumlah tiket, memilih film dan jam tayang. Data film diambil dari `session` yang disetel di `index.jsp`.
3. `struk.jsp`  
   Halaman ini menampilkan struk digital sebagai konfirmasi pemesanan berdasarkan input dari `formPesan.jsp`.

Teknologi yang Digunakan :
- Java JSP (Jakarta Server Pages)
- Bootstrap 5
- HTML & CSS Custom
- Session Handling (tanpa database)
- Java ArrayList dan JavaBean (`Film`)

Cara Menjalankan:
1. Buka proyek di NetBeans atau IDE Java lainnya yang mendukung JSP.
2. Letakkan file .jsp dan folder images pada direktori web/Web Pages.
3. Letakkan kelas Film.java di package model dalam folder Source Packages.
4. Jalankan di server lokal (seperti Apache Tomcat).
5. Akses http://localhost:8080/proyek-bioskop/index.jsp melalui browser.

![Screenshot 2025-05-16 192324](https://github.com/user-attachments/assets/027bc881-00df-40a4-8a4c-4950923b2b8e)
![Screenshot 2025-05-16 192337](https://github.com/user-attachments/assets/32f41670-d663-45ae-9b7b-02b4507e7bea)
![Screenshot 2025-05-16 192356](https://github.com/user-attachments/assets/c6d0b542-dee1-4d75-bedb-1477bd137fb2)
