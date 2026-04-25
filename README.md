# 🚀 PartimKU

Aplikasi mobile **PartimKU** adalah platform pencarian lowongan kerja part-time berbasis Flutter yang dirancang untuk memudahkan pencari kerja menemukan pekerjaan paruh waktu dan perusahaan dalam mengelola lowongan serta pelamar.

---

## 🔗 Link Project
- 📂 Source Code: https://github.com/akhsanmakky/PartimKu
- 📱 APK:(https://drive.google.com/drive/folders/1QYOwqiHKQaDeaZSne4C8oLP3RSx2kKuS?usp=drive_link)


---

## 👥 Role Pengguna

| Role | Deskripsi |
|------|----------|
| 👨‍💼 Jobseeker | Mencari, melamar, dan memantau status pekerjaan |
| 🏢 Company | Memposting lowongan dan mengelola pelamar |

---

## ✨ Fitur Utama

### 🔐 Autentikasi
- Splash screen animasi
- Login multi-role
- Registrasi user & perusahaan
- Validasi form

### 👨‍💼 Jobseeker
- 🔍 Cari & filter lowongan
- 📄 Detail pekerjaan
- 📤 Lamar pekerjaan
- 📊 Status lamaran
- 💬 Chat perusahaan
- 🔔 Notifikasi
- ⭐ Review perusahaan
- 📁 Riwayat pekerjaan
- 👤 Edit profil

### 🏢 Company
- 📊 Dashboard lowongan
- ➕ Posting pekerjaan
- 👥 Data pelamar
- 📝 Update status pelamar
- 💬 Chat pelamar
- 👤 Profil perusahaan

---

## 🎨 UI/UX
- Material 3 Design
- Animasi (`flutter_animate`)
- Shimmer loading
- Bottom navigation modern
- Badge notifikasi
- Empty state UI

---

## 🛠️ Teknologi

| Teknologi | Keterangan |
|----------|-----------|
| Flutter | Framework utama |
| Dart | Bahasa pemrograman |
| StatefulWidget | State management |
| HTTP | Simulasi API |
| Google Fonts | Typography |
| Shimmer | Loading effect |

---

## 🧪 Metode Pengujian

Pengujian dilakukan dengan:

| Metode | Tools |
|-------|------|
| Static Analysis | `flutter analyze` |
| Widget Testing | `flutter test` |
| Manual Testing | Uji langsung fitur |

---

## 📊 Ringkasan Hasil Pengujian

| Kategori | Pass | Warning | Fail |
|----------|:---:|:---:|:---:|
| Fitur Aplikasi | 43 | 0 | 0 |
| Code Quality | 0 | 1 | 0 |
| Testing | 0 | 0 | 1 |
| **Total** | **43** | **1** | **1** |

---

## ⚠️ Catatan

- Tidak ada error fatal pada aplikasi
- Terdapat 1 warning minor pada code quality
- Widget test gagal karena delay splash screen (sudah diketahui dan bisa diperbaiki)

Berikut cara menggunakan aplikasi PartimKU langsung di HP :

1. Install Aplikasi ke HP
Opsi A: Transfer File APK
Cari file APK di folder proyek:
build/app/outputs/flutter-apk/app-release.apk
Copy/pindahkan file APK ke HP Anda (via USB, Bluetooth, atau cloud seperti Google Drive/WA)
Di HP, buka file APK yang sudah ditransfer
Opsi B: Install via ADB (jika HP terhubung ke laptop)

adb install build/app/outputs/flutter-apk/app-release.apk
2. Izinkan Instalasi dari Sumber Tidak Dikenal
Saat pertama kali install APK:

Akan muncul notifikasi "Sumber tidak dikenal"
Tap Pengaturan pada notifikasi tersebut
Aktifkan izin "Izinkan dari sumber ini"
Kembali dan tap Install
3. Cara Menggunakan Aplikasi di HP
Splash Screen & Login
Buka aplikasi PartimKU
Tampil splash screen logo selama 3 detik
Pilih role login:
Pencari Kerja → untuk mencari lowongan part-time
Perusahaan → untuk mengelola lowongan & pelamar
Masukkan email & password apa saja (minimal 6 karakter)
Tap tombol Login
4. Panduan Penggunaan (Role Pencari Kerja)
Setelah login sebagai Pencari Kerja, akan muncul Bottom Navigation dengan 3 tab:

Tab	Ikon	Fungsi
Lowongan	🏠	Lihat daftar lowongan, search, filter jadwal/lokasi/jenis kerja
Lamaran	📋	Pantau status lamaran (Menunggu/Diterima/Ditolak)
Profil	👤	Lihat/edit profil, riwayat pekerjaan, logout
Cara Melamar Pekerjaan:
Di tab Lowongan, tap card pekerjaan yang diminati
Baca detail lowongan (gaji, lokasi, jadwal, deskripsi)
Tap "Lamar Sekarang"
Isi surat lamaran (minimal 20 karakter)
Tap Kirim
Fitur Tambahan:
Chat → dari detail lowongan, tap "Chat" untuk ngobrol langsung dengan perusahaan
Notifikasi → di pojok kanan atas Home, cek notifikasi update status & pesan baru
Review Perusahaan → di detail lowongan, tap rating untuk lihat ulasan
5. Panduan Penggunaan (Role Perusahaan)
Setelah login sebagai Perusahaan, akan muncul Bottom Navigation dengan 4 tab:

Tab	Ikon	Fungsi
Lowongan	📋	Dashboard lowongan yang sudah diposting
Pelamar	👥	Lihat data pelamar per lowongan
Chat	💬	Daftar percakapan dengan pelamar
Profil	⚙️	Profil perusahaan
Cara Posting Lowongan:
Di tab Lowongan, tap tombol FAB (+) atau "Posting Lowongan"
Isi form: judul, lokasi, gaji, jenis kerja, jadwal, deskripsi, persyaratan
Pilih jenis kerja (Full-time/Part-time/Freelance) dan jadwal (Weekday/Weekend/Flexible)
Tap Posting
Cara Kelola Pelamar:
Di tab Lowongan, tap "Lihat Pelamar →"
Tap salah satu pelamar untuk lihat detail lamaran
Ubah status menjadi Diterima atau Ditolak
Catatan Penting
Aplikasi ini menggunakan data mock/simulasi lokal, tidak memerlukan internet
Semua data (lowongan, lamaran, chat, notifikasi) tersimpan di memori aplikasi
Jika aplikasi ditutup paksa, data mock akan kembali ke default awal
Login bisa menggunakan email & password apa saja selama validasi terpenuhi (email mengandung "@" dan password minimal 6 karakter)
