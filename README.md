# NutriSafe Student

NutriSafe Student adalah aplikasi mobile pendamping program distribusi makanan
bergizi. Aplikasi menghubungkan siswa/masyarakat dan sekolah dengan ekosistem
NutriSafe untuk pelaporan masalah makanan, konfirmasi penerimaan makanan,
pendataan alergi siswa, serta pemantauan tindak lanjut melalui notifikasi.

Repository ini berisi aplikasi untuk dua role pengguna: **Siswa/Umum** dan
**Sekolah**. Layanan SPPG dan Admin BGN tersedia pada backend NutriSafe, tetapi
tidak menjadi role antarmuka pada aplikasi ini.

## Fitur utama

### Fitur bersama

- Splash screen dan navigasi berbasis role.
- Login menggunakan email dan password.
- Registrasi akun siswa/umum dan pengajuan akun sekolah.
- Profil pengguna, edit profil, keamanan akun, dan pusat bantuan.
- Tema terang dan gelap dengan tampilan responsif untuk berbagai ukuran ponsel.
- Notifikasi dari backend, pull-to-refresh, jumlah notifikasi belum dibaca,
  tandai satu notifikasi, dan tandai semua sebagai sudah dibaca.
- Logout dengan pembersihan sesi pada aplikasi.

### Siswa / Umum

- Dashboard pelaporan makanan.
- Membuat laporan berdasarkan sekolah, tanggal kejadian, jenis masalah,
  deskripsi, dan bukti foto.
- Melihat status serta detail laporan.
- Melihat sekolah dan data sekolah yang terhubung dengan siswa.

### Sekolah

- Dashboard operasional sekolah.
- Melihat dan memperbarui profil sekolah.
- Melihat informasi mitra SPPG.
- Melihat menu ramah alergi serta mencatat data alergi siswa.
- Melihat pengiriman yang menunggu konfirmasi dan mengonfirmasi jumlah porsi
  yang diterima beserta foto bukti.
- Mengirim, melihat daftar, dan membuka detail komplain makanan.
- Pengelolaan kelas, siswa (termasuk bulk import), dan guru melalui API.

## Role dan alur pengguna

### Alur Siswa / Umum

1. Pengguna membuka aplikasi lalu memilih masuk atau mendaftar.
2. Setelah autentikasi berhasil, backend mengembalikan token JWT dan role
   `siswa` atau `umum`.
3. Pengguna diarahkan ke dashboard Siswa/Umum.
4. Pengguna dapat memilih sekolah, mengisi laporan masalah makanan, dan
   melampirkan foto bukti.
5. Laporan dikirim ke sekolah, mitra SPPG jika tersedia, dan Admin BGN.
6. Perubahan status laporan dapat dipantau melalui detail laporan dan
   notifikasi.
7. Pengguna dapat mengelola profil atau keluar dari aplikasi.

### Alur Sekolah

1. Perwakilan sekolah mengisi formulir pendaftaran sekolah. Email login sekolah
   dibuat oleh sistem dan kredensial dikirim ke email kontak yang didaftarkan.
2. Sekolah masuk menggunakan akun berdomain `@sch.id`.
3. Setelah autentikasi berhasil, pengguna diarahkan ke dashboard Sekolah.
4. Sekolah dapat melihat mitra SPPG dan pengiriman yang sedang menunggu.
5. Saat makanan tiba, sekolah mengisi jumlah porsi dan mengunggah foto
   penerimaan. SPPG menerima notifikasi hasil konfirmasi.
6. Sekolah dapat mengirim komplain makanan dan memantau tindak lanjutnya.
7. Sekolah dapat mencatat alergi siswa serta mengelola kelas, siswa, dan guru.
8. Aktivitas dan pembaruan penting diterima melalui halaman Notifikasi.

## Teknologi

| Bagian | Teknologi |
| --- | --- |
| Framework | Flutter |
| Bahasa | Dart |
| State management dan routing | GetX |
| HTTP client | `package:http` |
| Kamera dan galeri | `image_picker` |
| Backend | NutriSafe REST API (Go + Fiber) |
| Autentikasi | Bearer JWT, berlaku 24 jam |
| Platform | Android, iOS, dan Web |
| Testing | `flutter_test` dan mock HTTP client |

## Struktur proyek

```text
lib/
├── app/                    # App, dependency binding, route, dan tema
├── core/                   # Konfigurasi, konstanta, utilitas, dan widget bersama
└── features/
    ├── auth/               # Login, registrasi, sesi pengguna
    ├── home/               # Dashboard berdasarkan role
    ├── notifications/      # Fetch dan aksi notifikasi
    ├── profile/            # Profil, keamanan akun, bantuan
    ├── reporting/          # Form dan detail laporan makanan
    └── school/             # Operasional dan data sekolah
```

Setiap feature dipisahkan menjadi lapisan `data`, `controllers`, dan
`presentation` sesuai kebutuhan.

## API

- Base URL produksi: `https://api.nutrisafe.id/`
- Dokumentasi: [NutriSafe API — Semua Role](https://documenter.getpostman.com/view/28796164/2sBYHSwzid)
- Endpoint berada langsung pada root domain dan **tidak** memakai prefix
  `/api`.
- Endpoint terproteksi mengirim header `Authorization: Bearer <token>`.
- Kredensial dan token tidak boleh ditulis langsung ke source code atau Git.

## Menjalankan proyek

Prasyarat:

- Flutter SDK yang kompatibel dengan Dart `^3.13.4`.
- Android Studio/Android SDK untuk Android.
- Xcode dan CocoaPods pada macOS untuk iOS.

```bash
flutter pub get
flutter run
```

Mode demo dapat digunakan tanpa memanggil backend:

```bash
flutter run --dart-define=DEMO_MODE=true
```

## Pemeriksaan kualitas

```bash
dart format lib test
flutter analyze
flutter test
```

Test mencakup repository autentikasi, kontrak endpoint sekolah, notifikasi,
asset, interaksi komponen, dan smoke test layout pada beberapa ukuran layar.

## Build

### Android

```bash
flutter build apk --release
```

Hasil build berada di `build/app/outputs/flutter-apk/app-release.apk`.
Konfigurasi release saat ini masih menggunakan debug signing; siapkan keystore
release sebelum mendistribusikan aplikasi.

### Web

```bash
flutter build web --release
```

### iOS

Build iOS final memerlukan macOS dan Xcode. Dari Windows, source code dan
konfigurasi iOS dapat disiapkan, tetapi `.ipa` tidak dapat dikompilasi secara
lokal.

Pada macOS:

```bash
flutter pub get
cd ios
pod install
cd ..
flutter build ipa --release
```

Sebelum distribusi, atur Bundle Identifier, Apple Development Team,
certificate, dan provisioning profile melalui Xcode. Alternatifnya, jalankan
build pada layanan CI macOS seperti Codemagic, GitHub Actions macOS, atau Xcode
Cloud.

## Nilai unggulan NutriSafe

NutriSafe dirancang bukan hanya sebagai aplikasi pelaporan, tetapi sebagai
jembatan komunikasi yang terstruktur antara penerima manfaat, sekolah, dan
penyedia makanan. Setiap laporan, data alergi, dan konfirmasi penerimaan
membentuk alur informasi yang dapat ditindaklanjuti dengan cepat.

- **Pelaporan lebih mudah** — siswa dan masyarakat dapat menyampaikan masalah
  makanan melalui alur sederhana dengan bukti foto.
- **Respons lebih cepat** — sekolah dan SPPG menerima informasi yang relevan
  melalui notifikasi dan status laporan.
- **Distribusi lebih transparan** — jumlah porsi yang dikirim dan diterima dapat
  dikonfirmasi secara digital.
- **Makanan lebih aman** — data alergi membantu sekolah mengidentifikasi siswa
  dengan kebutuhan khusus dan menyesuaikan menu.
- **Data lebih terintegrasi** — kelas, siswa, guru, laporan, dan mitra SPPG
  dikelola melalui satu ekosistem.
- **Siap dikembangkan** — arsitektur berbasis feature memudahkan penambahan
  dashboard analitik, integrasi AI, dan perluasan ke lebih banyak sekolah.

## Dampak yang diharapkan

Dengan NutriSafe, proses pengawasan makanan bergizi dapat menjadi lebih cepat,
inklusif, dan berbasis data. Sekolah memperoleh alat operasional yang praktis,
siswa memiliki kanal pelaporan yang mudah diakses, dan pemangku kepentingan
mendapatkan informasi yang lebih akurat untuk meningkatkan kualitas program.

> **NutriSafe — makanan bergizi, distribusi transparan, siswa terlindungi.**
