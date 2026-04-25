# PartimKU

Aplikasi mobile **PartimKU** adalah platform pencarian lowongan kerja part-time berbasis Flutter yang dirancang untuk memudahkan pencari kerja menemukan pekerjaan paruh waktu dan perusahaan dalam mengelola lowongan serta pelamar.

Aplikasi ini mendukung dua peran utama:
- **Pencari Kerja (Jobseeker)** — mencari, melamar, dan memantau status lamaran pekerjaan.
- **Perusahaan (Company)** — memposting lowongan, mengelola pelamar, dan berkomunikasi via chat.

---

## Fitur Utama

### Autentikasi
- Splash screen dengan animasi logo
- Login dengan pemilihan peran (Pencari Kerja / Perusahaan)
- Registrasi akun Pencari Kerja
- Registrasi akun Perusahaan (Admin)
- Validasi form input (email, password minimal 6 karakter)

### Pencari Kerja (Jobseeker)
- **Home** — Daftar lowongan kerja dengan fitur pencarian (search) dan filter (jadwal, lokasi, jenis kerja)
- **Detail Lowongan** — Informasi lengkap pekerjaan, persyaratan, rating & review perusahaan
- **Lamar Pekerjaan** — Kirim surat lamaran dengan validasi minimal 20 karakter
- **Status Lamaran** — Pantau status lamaran (Menunggu / Diterima / Ditolak)
- **Chat** — Komunikasi langsung dengan perusahaan
- **Notifikasi** — Notifikasi lowongan baru, update status, dan pesan baru
- **Review Perusahaan** — Lihat rating dan ulasan dari pekerja lain
- **Riwayat Pekerjaan** — Riwayat pekerjaan yang pernah dan sedang dijalani
- **Edit Profil** — Perbarui informasi pribadi (nama, email, telepon, lokasi, bio)

### Perusahaan (Company)
- **Dashboard** — Kelola daftar lowongan yang diposting dengan statistik pelamar
- **Posting Lowongan** — Buat lowongan baru dengan judul, lokasi, gaji, jenis kerja, jadwal, deskripsi, dan persyaratan
- **Data Pelamar** — Lihat daftar pelamar per lowongan dengan status
- **Detail Pelamar** — Review surat lamaran dan ubah status (Diterima / Ditolak)
- **Chat List** — Daftar percakapan dengan pelamar
- **Profil Perusahaan** — Kelola profil perusahaan

### UI/UX
- Desain modern dengan Material 3
- Animasi halus menggunakan `flutter_animate`
- Bottom navigation bar `salomon_bottom_bar`
- Gradient header dan card-based layout
- Badge notifikasi unread count
- Empty state illustration untuk data kosong

---

## Teknologi

- **Framework**: Flutter 3.5.3+
- **Dart SDK**: ^3.5.3
- **State Management**: StatefulWidget (setState)
- **Backend**: Mock data lokal via `ApiService` (simulasi API)
- **UI Library**:
  - `google_fonts` — Typography Inter
  - `flutter_animate` — Animasi widget
  - `shimmer` — Loading shimmer effect
  - `salomon_bottom_bar` — Bottom navigation bar
- **Networking**: `http` (siap integrasi API real)

---

## Hasil Pengujian Aplikasi

Pengujian dilakukan dengan kombinasi **analisis statis kode** (`flutter analyze`), **widget test otomatis** (`flutter test`), dan **inspeksi manual kode** terhadap seluruh fitur aplikasi.

| No | Modul | Fitur yang Diuji | Skenario Pengujian | Hasil yang Diharapkan | Hasil Aktual | Status |
|:---|:---|:---|:---|:---|:---|:---:|
| **1** | **Autentikasi** | Splash Screen | Buka aplikasi | Menampilkan splash screen dengan logo dan animasi selama 3 detik, lalu navigasi ke halaman login | Splash screen muncul dengan animasi fade & scale, navigasi ke login berfungsi | ✅ Pass |
| **2** | **Autentikasi** | Login — Pencari Kerja | Pilih role "Pencari Kerja", masukkan email & password valid, tap tombol Login | Navigasi ke `MainNavigationScreen` (tab Home) | Navigasi berhasil, bottom bar muncul | ✅ Pass |
| **3** | **Autentikasi** | Login — Perusahaan | Pilih role "Perusahaan", masukkan email & password valid, tap tombol Login | Navigasi ke `CompanyMainNavigationScreen` (tab Dashboard) | Navigasi berhasil, bottom bar muncul | ✅ Pass |
| **4** | **Autentikasi** | Validasi Login | Biarkan email/password kosong atau email tanpa "@", tap Login | Muncul pesan error validasi form | Validasi email & password minimal 6 karakter berfungsi | ✅ Pass |
| **5** | **Autentikasi** | Registrasi Pencari Kerja | Pilih role Pencari Kerja, isi nama/email/password/konfirmasi password valid, tap Daftar | Pendaftaran berhasil, kembali ke login dengan SnackBar sukses | Pendaftaran berhasil, data user tersimpan | ✅ Pass |
| **6** | **Autentikasi** | Registrasi Perusahaan | Pilih role Perusahaan, isi nama perusahaan/email/password valid, tap Daftar | Pendaftaran berhasil, kembali ke login dengan SnackBar sukses | Pendaftaran berhasil, data perusahaan tersimpan | ✅ Pass |
| **7** | **Autentikasi** | Toggle Password Visibility | Tap ikon mata di field password | Password ditampilkan/sembunyikan | Toggle visibility berfungsi | ✅ Pass |
| **8** | **Pencari Kerja** | Home — Daftar Lowongan | Buka halaman Home (tab Lowongan) | Menampilkan daftar 6 lowongan kerja dengan card modern | Daftar lowongan tampil lengkap dengan animasi stagger | ✅ Pass |
| **9** | **Pencari Kerja** | Home — Search | Ketik kata kunci di search bar (contoh: "Admin") | Filter lowongan sesuai kata kunci di judul/perusahaan/lokasi | Search real-time berfungsi | ✅ Pass |
| **10** | **Pencari Kerja** | Home — Filter Jadwal | Tap ikon filter, pilih jadwal "Weekend", tap Terapkan | Hanya menampilkan lowongan dengan jadwal Weekend | Filter jadwal berfungsi | ✅ Pass |
| **11** | **Pencari Kerja** | Home — Filter Lokasi | Tap ikon filter, pilih lokasi "Jakarta Selatan", tap Terapkan | Hanya menampilkan lowongan di Jakarta Selatan | Filter lokasi berfungsi | ✅ Pass |
| **12** | **Pencari Kerja** | Home — Filter Jenis Kerja | Tap ikon filter, pilih jenis "Part-time", tap Terapkan | Hanya menampilkan lowongan part-time | Filter jenis kerja berfungsi | ✅ Pass |
| **13** | **Pencari Kerja** | Home — Reset Filter | Tap tombol Reset di bottom sheet filter | Semua filter ter-reset, daftar kembali ke awal | Reset filter berfungsi | ✅ Pass |
| **14** | **Pencari Kerja** | Home — Active Filter Chip | Tap chip filter aktif untuk menghapus | Chip filter terhapus, daftar lowongan diperbarui | Chip filter removable berfungsi | ✅ Pass |
| **15** | **Pencari Kerja** | Home — Empty State | Cari kata kunci yang tidak ada hasilnya | Menampilkan ilustrasi empty state dengan pesan | Empty state tampil | ✅ Pass |
| **16** | **Pencari Kerja** | Job Detail | Tap salah satu card lowongan | Menampilkan detail lengkap: judul, perusahaan, lokasi, jadwal, gaji, deskripsi, persyaratan | Detail tampil lengkap dengan animasi | ✅ Pass |
| **17** | **Pencari Kerja** | Job Detail — Company Rating | Lihat section "Rating & Review Perusahaan" | Menampilkan nilai rata-rata rating, jumlah review, dan bintang | Rating 4.5/5.0 untuk Cafe Kita tampil akurat | ✅ Pass |
| **18** | **Pencari Kerja** | Job Detail — Navigate to Reviews | Tap card rating perusahaan | Navigasi ke `CompanyReviewsScreen` | Navigasi ke review berfungsi | ✅ Pass |
| **19** | **Pencari Kerja** | Apply Job — Success | Dari detail job, tap "Lamar Sekarang", isi surat lamaran valid, tap Kirim | Lamaran berhasil dikirim, SnackBar sukses, kembali ke detail | Lamaran tersimpan di `ApiService` | ✅ Pass |
| **20** | **Pencari Kerja** | Apply Job — Validation | Biarkan surat lamaran kosong atau < 20 karakter | Muncul error validasi form | Validasi minimal 20 karakter berfungsi | ✅ Pass |
| **21** | **Pencari Kerja** | Apply Job — Duplicate | Lamar pekerjaan yang sudah pernah dilamar sebelumnya | Muncul SnackBar "Anda sudah melamar pekerjaan ini sebelumnya" | Pencegahan duplikat berfungsi | ✅ Pass |
| **22** | **Pencari Kerja** | Application Status | Buka halaman Status Lamaran (tab Lamaran) | Menampilkan daftar lamaran dengan status (Menunggu/Diterima/Ditolak) dan warna badge | Daftar lamaran tampil dengan badge status | ✅ Pass |
| **23** | **Pencari Kerja** | Application Status — Empty | Belum pernah melamar pekerjaan | Menampilkan empty state dengan ilustrasi | Empty state tampil | ✅ Pass |
| **24** | **Pencari Kerja** | Chat — Send Message | Dari detail job, tap "Chat", ketik pesan, kirim | Pesan tersimpan dan tampil di daftar chat | Chat message tersimpan di `ApiService` | ✅ Pass |
| **25** | **Pencari Kerja** | Notifications | Buka halaman Notifikasi (ikon bell di Home) | Menampilkan daftar notifikasi dengan indikator unread | 5 notifikasi mock tampil, 2 unread | ✅ Pass |
| **26** | **Pencari Kerja** | Notifications — Mark Read | Tap notifikasi yang belum dibaca | Notifikasi ditandai sudah dibaca, badge count berkurang | Mark as read berfungsi | ✅ Pass |
| **27** | **Pencari Kerja** | Notifications — Mark All Read | Tap "Tandai semua dibaca" | Semua notifikasi menjadi read, badge count = 0 | Mark all as read berfungsi | ✅ Pass |
| **28** | **Pencari Kerja** | Company Reviews | Dari detail job, tap card rating | Menampilkan daftar review perusahaan dengan nama reviewer, rating, dan komentar | 3 review Cafe Kita tampil akurat | ✅ Pass |
| **29** | **Pencari Kerja** | Job History | Buka halaman Riwayat Pekerjaan dari profil | Menampilkan riwayat pekerjaan (Selesai / Berjalan) dengan periode kerja | 5 riwayat mock tampil | ✅ Pass |
| **30** | **Pencari Kerja** | Edit Profile | Buka Edit Profil, ubah nama/telepon/lokasi/bio, tap Simpan | Profil terupdate di halaman profil | Update profil berfungsi | ✅ Pass |
| **31** | **Pencari Kerja** | Profile Stats | Buka halaman Profil (tab Profil) | Menampilkan statistik: jumlah lamaran, selesai, berjalan | Statistik card tampil akurat | ✅ Pass |
| **32** | **Pencari Kerja** | Navigation | Tap item bottom navigation bar (Lowongan/Lamaran/Profil) | Berpindah halaman sesuai tab yang dipilih | Navigasi indexed stack berfungsi | ✅ Pass |
| **33** | **Pencari Kerja** | Logout | Tap tombol "Keluar" di halaman Profil | Navigasi kembali ke halaman login | Logout berfungsi | ✅ Pass |
| **34** | **Perusahaan** | Dashboard | Buka halaman Dashboard (tab Lowongan) | Menampilkan daftar lowongan perusahaan dengan jumlah pelamar total & pending | 2 lowongan Cafe Kita tampil dengan statistik | ✅ Pass |
| **35** | **Perusahaan** | Dashboard — Empty | Belum ada lowongan yang diposting | Menampilkan empty state | Empty state tampil | ✅ Pass |
| **36** | **Perusahaan** | Post Job | Tap FAB "Posting", isi semua field form, tap Posting | Lowongan baru ditambahkan ke dashboard | Lowongan tersimpan di `ApiService` | ✅ Pass |
| **37** | **Perusahaan** | Post Job — Validation | Biarkan field kosong, tap Posting | Muncul error validasi form | Validasi form berfungsi | ✅ Pass |
| **38** | **Perusahaan** | Post Job — Job Type & Schedule | Pilih jenis kerja "Full-time" dan jadwal "Weekday" | Choice chip terpilih dengan warna aktif | Toggle choice chip berfungsi | ✅ Pass |
| **39** | **Perusahaan** | View Applicants | Dari dashboard, tap "Lihat Pelamar →" | Menampilkan detail pelamar per lowongan dengan surat lamaran | 3 pelamar mock tampil | ✅ Pass |
| **40** | **Perusahaan** | Update Applicant Status | Dari detail pelamar, ubah status ke "Diterima" atau "Ditolak" | Status lamaran terupdate dan tampil di card pelamar | Update status berfungsi | ✅ Pass |
| **41** | **Perusahaan** | Chat List | Buka halaman Chat (tab Chat) | Menampilkan daftar percakapan dengan pelamar | Chat list tampil | ✅ Pass |
| **42** | **Perusahaan** | Profile | Buka halaman Profil (tab Profil) | Menampilkan profil perusahaan | Profil perusahaan tampil | ✅ Pass |
| **43** | **Perusahaan** | Navigation | Tap item bottom navigation bar | Berpindah halaman sesuai tab (Lowongan/Pelamar/Chat/Profil) | Navigasi indexed stack berfungsi | ✅ Pass |
| **44** | **Code Quality** | Static Analysis | Jalankan `flutter analyze` | Tidak ada error fatal | **43 issues**: 1 unused_import warning, 42 info (prefer_const_constructors, library_private_types_in_public_api, use_build_context_synchronously). **Tidak ada error fatal.** | ⚠️ Warning |
| **45** | **Testing** | Widget Test — Smoke Test | Jalankan `flutter test` | Test berhasil (app launch, find widget) | **Test gagal**: Widget test mencari teks "Selamat Datang" langsung setelah pump widget, tetapi aplikasi dimulai dengan `SplashScreen` yang memiliki delay 3 detik sebelum navigasi ke `LoginScreen`. Test tidak menunggu navigasi selesai. | ❌ Fail |

---

## Ringkasan Hasil Pengujian

| Kategori | Pass | Warning | Fail | Total |
|:---|:---:|:---:|:---:|:---:|
| Fitur Aplikasi | 43 | 0 | 0 | 43 |
| Code Quality | 0 | 1 | 0 | 1 |
| Automated Testing | 0 | 0 | 1 | 1 |
| **Total** | **43** | **1** | **1** | **45** |

---

## Rekomendasi Perbaikan

### 1. Perbaiki Widget Test (High Priority)
Test saat ini gagal karena mengharapkan teks "Selamat Datang" muncul langsung, padahal aplikasi dimulai dari `SplashScreen`. Perbaiki `test/widget_test.dart`:

```dart
// Sebelum (gagal):
expect(find.text('Selamat Datang'), findsOneWidget);

// Sesudah (berhasil):
// Tunggu navigasi dari SplashScreen ke LoginScreen
await tester.pumpAndSettle(const Duration(seconds: 4));
expect(find.text('Selamat Datang'), findsOneWidget);
expect(find.text('Login'), findsOneWidget);
```

### 2. Perbaiki Code Quality Issues (Medium Priority)
Jalankan perbaikan otomatis dengan:
```bash
flutter analyze --fix
```
Atau perbaiki secara manual:
- Tambahkan `const` di constructor yang memungkinkan (`prefer_const_constructors`)
- Ganti `_ScreenState` menjadi public atau gunakan generic type yang sesuai (`library_private_types_in_public_api`)
- Tambahkan pengecekan `mounted` sebelum menggunakan `BuildContext` di dalam async gap (`use_build_context_synchronously`)
- Hapus import `flutter_animate` yang tidak digunakan di `post_job_screen.dart`

### 3. Tambahkan Unit Test (Low Priority)
Tambahkan test untuk `ApiService`:
- Test filter jobs
- Test apply job (success & duplicate)
- Test update application status
- Test notification count

---

## Cara Menjalankan Aplikasi

```bash
# Clone repository
git clone <repository-url>
cd partimku

# Install dependencies
flutter pub get

# Jalankan aplikasi
flutter run

# Jalankan analisis kode
flutter analyze

# Jalankan test
flutter test
```

---

## Struktur Folder

```
lib/
├── main.dart
├── models/
│   ├── application.dart
│   ├── chat_message.dart
│   ├── company_review.dart
│   ├── job.dart
│   ├── job_history.dart
│   ├── notification.dart
│   └── user.dart
├── screens/
│   ├── auth/
│   │   ├── login_screen.dart
│   │   ├── register_screen.dart
│   │   └── registration_admin_screen.dart
│   ├── company/
│   │   ├── company_applicant_detail_screen.dart
│   │   ├── company_applicants_screen.dart
│   │   ├── company_chat_list_screen.dart
│   │   ├── company_dashboard_screen.dart
│   │   ├── company_profile_screen.dart
│   │   └── post_job_screen.dart
│   ├── navigation/
│   │   ├── company_main_navigation_screen.dart
│   │   └── main_navigation_screen.dart
│   ├── user/
│   │   ├── application_status_screen.dart
│   │   ├── apply_job_screen.dart
│   │   ├── chat_screen.dart
│   │   ├── company_reviews_screen.dart
│   │   ├── edit_profile_screen.dart
│   │   ├── home_screen.dart
│   │   ├── job_detail_screen.dart
│   │   ├── job_history_screen.dart
│   │   └── notifications_screen.dart
│   └── splash_screen.dart
├── services/
│   └── api_service.dart
└── widgets/
    └── app_logo.dart
```

---

## Lisensi

Proyek ini adalah hasil pengembangan untuk keperluan pembelajaran Flutter.

#   P a r t i m K u  
 