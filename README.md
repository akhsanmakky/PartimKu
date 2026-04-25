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

Cara Menggunakan Aplikasi
🔐 Login
Buka aplikasi PartimKU
Tunggu splash screen (±3 detik)
Pilih role:
👨‍💼 Pencari Kerja (Jobseeker)
🏢 Perusahaan (Company)
Masukkan:
Email (bebas, harus mengandung "@")
Password (minimal 6 karakter)
Tap Login
👨‍💼Panduan Pengguna (Jobseeker)
📱 Navigasi
Tab	Ikon	Fungsi
Lowongan	🏠	Lihat, cari, dan filter pekerjaan
Lamaran	📋	Cek status lamaran
Profil	👤	Edit profil & riwayat
📤 Cara Melamar Pekerjaan
Pilih pekerjaan di tab Lowongan
Baca detail pekerjaan
Tap Lamar Sekarang
Isi surat lamaran (minimal 20 karakter)
Tap Kirim
⭐ Fitur Tambahan
💬 Chat dengan perusahaan
🔔 Notifikasi status & pesan
⭐ Review perusahaan
🏢 5. Panduan Pengguna (Company)
📱 Navigasi
Tab	Ikon	Fungsi
Lowongan	📋	Dashboard lowongan
Pelamar	👥	Data pelamar
Chat	💬	Komunikasi
Profil	⚙️	Profil perusahaan
➕ Cara Posting Lowongan
Tap tombol ➕ / Posting Lowongan
Isi data pekerjaan:
Judul
Lokasi
Gaji
Jenis kerja
Jadwal
Deskripsi
Persyaratan
Pilih jenis kerja & jadwal
Tap Posting
👥 Cara Mengelola Pelamar
Buka tab Lowongan
Tap Lihat Pelamar →
Pilih pelamar
Ubah status:
✅ Diterima
❌ Ditolak
