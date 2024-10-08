# Cinetix.id 🎬🎟️  
Cinetix.id adalah aplikasi pemesanan tiket bioskop secara online yang dikembangkan menggunakan Flutter. Dengan Cinetix.id, pengguna dapat dengan mudah memesan tiket film favorit mereka hanya dalam beberapa langkah.

## Fitur Utama ✨
- **Pemesanan Tiket Bioskop**: Pilih film, jadwal, dan tempat duduk langsung dari aplikasi.
- **State Management dengan Riverpod**: Manajemen state yang efisien dan reaktif menggunakan Riverpod.
- **Database Firebase**: Pengguna dan data pemesanan disimpan dengan aman menggunakan Firebase Firestore.

## Teknologi yang Digunakan 🛠️
- **Flutter**: Framework UI modern untuk pengembangan aplikasi mobile lintas platform (iOS dan Android).
- **Riverpod**: Paket state management yang sederhana namun powerful, mendukung dependency injection dan mempermudah pemeliharaan kode.
- **Firebase**: Backend yang menangani autentikasi pengguna dan penyimpanan data secara real-time.

## Instalasi & Penggunaan 🚀
1. Clone repository ini:
   ```bash
   git clone https://github.com/FernandJerico/cinetix_id.git
2. Masuk ke direktori proyek:
   ```bash
   cd cinetix.id
3. Install dependencies:
   ```bash
   flutter pub get
4. Jalankan aplikasi:
   ```bash
   flutter run

## Arsitektur 🔧
Aplikasi ini mengikuti prinsip Clean Architecture, sehingga mudah untuk dikembangkan dan di-maintain. Saya menggunakan Riverpod untuk manajemen state agar logika bisnis terpisah dari UI, serta Firebase untuk penyimpanan data secara terpusat.
