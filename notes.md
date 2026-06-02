notes update:

1. Layar penuh mungkin tidak ditampilkan untuk semua pengguna
   Mulai Android 15, semua aplikasi yang menargetkan SDK 35 akan menampilkan tata letak layar penuh secara default. Aplikasi yang menargetkan SDK 35 harus menangani inset untuk memastikan aplikasi ditampilkan dengan benar di Android 15 dan yang lebih baru. Selidiki masalah ini dan luangkan waktu untuk menguji aplikasi secara menyeluruh dan melakukan update yang diperlukan. Atau, panggil enableEdgeToEdge() untuk Kotlin atau EdgeToEdge.enable() untuk Java untuk kompatibilitas mundur.
   Aplikasi harus menargetkan Android 15 (API level 35) atau yang lebih tinggi
   Untuk memberi pengguna pengalaman yang aman dan terlindungi, Google Play mewajibkan semua aplikasi memenuhi persyaratan level API target.
   Mulai 31 Agu 2025, jika level API target Anda lebih lama dari 1 tahun sejak rilis Android terbaru, Anda tidak akan dapat mengupdate aplikasi Anda.

2. Aplikasi Anda menggunakan API atau parameter tata letak layar penuh yang tidak digunakan lagi
   Satu atau beberapa API yang Anda gunakan atau parameter yang Anda tetapkan untuk tampilan layar penuh dan jendela telah dihentikan penggunaannya di Android 15. Aplikasi Anda menggunakan API atau parameter berikut yang tidak digunakan lagi:

android.view.Window.setNavigationBarDividerColor
android.view.Window.setStatusBarColor
android.view.Window.setNavigationBarColor
API atau parameter ini dimulai di tempat berikut:

E.s.t
M.f.onCreate
io.flutter.plugin.platform.d.b
Untuk memperbaikinya, lakukan migrasi dari API atau parameter ini.

3. Kompilasi ulang aplikasi Anda dengan penyelarasan library native 16 KB
   Aplikasi Anda menggunakan library native yang tidak sesuai untuk mendukung perangkat dengan ukuran halaman memori 16 KB. Perangkat ini mungkin tidak dapat menginstal atau memulai aplikasi Anda, atau aplikasi Anda mungkin mulai berjalan lalu mengalami error.

Ada app bundle baru dalam rilis ini yang tidak mendukung ukuran halaman memori 16 KB.

Kode versi:

3
Android 15 mendukung perangkat dengan ukuran halaman memori 16 KB, yang dapat meningkatkan performa aplikasi Anda. Sebaiknya kompilasi ulang aplikasi Anda saat bermigrasi ke Android 15 dan uji aplikasi Anda dalam lingkungan 16 KB untuk menghindari masalah bagi pengguna.
