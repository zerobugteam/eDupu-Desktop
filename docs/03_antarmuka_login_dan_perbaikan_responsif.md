# 03. Antarmuka Login & Perbaikan Responsif (RenderFlex Overflow)

Dokumen ini merangkum penyelarasan desain antarmuka layar masuk (*Login Screen*) dengan portal web resmi eDupu, serta solusi teknis penanganan masalah tampilan *overflow* bergaris kuning-hitam di Flutter Desktop.

---

## 1. Penyelarasan Desain Layar Masuk (Login Screen)

File implementasi: **`lib/screens/login_screen.dart`**

Tampilan dirancang dalam tata letak split 50:50 yang seimbang dan elegan:

```
┌──────────────────────────────────────┬──────────────────────────────────────┐
│  ←  edupu                            │  Selamat Datang!                     │
│                                      │  Masukkan nama pengguna dan kata     │
│  [Foto Wisuda Siswa Soft Bokeh Blur] │  sandi akun Anda.                    │
│                                      │                                      │
│  Portal Pembelajaran Digital &       │  Nama Pengguna                       │
│  Presensi Cerdas                     │  [ 👤 Masukkan nama pengguna       ] │
│                                      │                                      │
│  Sistem informasi pembelajaran       │  Kata Sandi              Lupa Sandi? │
│  terpadu untuk absensi GPS           │  [ 🔒 Masukkan kata sandi         👁 ] │
│  geofence, CBT, dan administrasi.    │                                      │
│                                      │  [✓] Ingat sesi saya di perangkat ini│
│                                      │                                      │
│                                      │  [  Masuk ke Dasbor Sistem →       ] │
│                                      │                                      │
│  © 2026 eDupu Platform               │  Pilih Akun Demo (1-Click Isi Cepat) │
└──────────────────────────────────────┴──────────────────────────────────────┘
```

### Komponen Kunci Panel Kiri (50% Branding):
* **Aset Latar Belakang:** Berkas gambar lokal [assets/images/login-bg.jpg](file:///c:/Dev/Projects/eDupu-Desktop/assets/images/login-bg.jpg) beresolusi tinggi yang menampilkan siswa merayakan kelulusan.
* **Efek Bokeh Blur & Ambient Darkener:** Menggunakan widget `BackdropFilter` dengan `ImageFilter.blur(sigmaX: 3.5, sigmaY: 3.5)` dan overlay warna hitam transparan (`Colors.black.withOpacity(0.28)`) agar teks putih di atasnya memiliki tingkat keterbacaan yang sempurna.
* **Branding Logo:** Logo resmi [assets/logo/edupufulltrans.png](file:///c:/Dev/Projects/eDupu-Desktop/assets/logo/edupufulltrans.png) di samping tombol panah navigasi melingkar.

### Komponen Kunci Panel Kanan (50% Form Autentikasi):
* **Kontainer Form:** Lebar maksimal dibatasi 420px (*max-width constraint*) dan terpusat secara vertikal maupun horizontal.
* **Desain Input Textfield:** Warna dasar *Slate-50* (`#F8FAFC`) dengan border halus *Slate-200* (`#E2E8F0`), sudut membulat 12px (*rounded-xl*), serta ikon garis tipis (*line icons*).
* **Fitur Kemudahan Demo:** Dilengkapi tombol *chip* 1-klik untuk langsung mengisi username dan kata sandi dari 4 role utama:
  * **Wali Kelas:** `wali` / `wali123`
  * **Admin TU:** `admintu` / `admin123`
  * **Kepala Sekolah:** `kepsek` / `kepsek123`
  * **Guru Mapel:** `guru` / `guru123`

---

## 2. Analisis & Solusi Garis Kuning-Hitam (RenderFlex Overflow)

### Penyebab Munculnya Garis Kuning-Hitam
Garis bergaris kuning dan hitam dengan teks peringatan seperti:
```
A RenderFlex overflowed by 142 pixels on the right
```
adalah fitur visual bawaan *debug mode* Flutter yang memperingatkan pengembang bahwa konten widget horizontal (`Row`) atau vertikal (`Column`) **melebihi ukuran batas piksel yang tersedia pada jendela**. Hal ini sering terjadi pada aplikasi desktop ketika pengguna mengubah ukuran jendela aplikasi menjadi lebih kecil, atau saat jendela tidak berada dalam mode *maximize* (layar penuh).

Secara spesifik, pada layar presensi guru ([guru_attendance_qr_view.dart](file:///c:/Dev/Projects/eDupu-Desktop/lib/screens/guru/guru_attendance_qr_view.dart)):
* Teks judul `"Daftar Hadir Terverifikasi (6 / 36 Siswa)"` bersama tombol `"Simulasi Scan HP Masuk"` berada di dalam satu baris `Row` kaku tanpa pembungkus responsif.

### Solusi yang Diimplementasikan:
1. **Menggunakan Widget `Wrap`:**
   Mengganti `Row` kaku dengan `Wrap` yang memiliki atribut `alignment: WrapAlignment.spaceBetween` dan `runSpacing: 8`.
   * **Hasil:** Jika ukuran jendela desktop dipersempit, tombol *"Simulasi Scan HP Masuk"* secara otomatis turun ke baris berikutnya dengan rapi tanpa menimbulkan *overflow*.
2. **Penerapan `LayoutBuilder` Adaptif:**
   Menggunakan `LayoutBuilder` untuk mendeteksi lebar jendela secara dinamis:
   * **Layar Lebar (≥ 900px):** Kartu QR Code (380px) dan Tabel Daftar Hadir bersanding sejajar secara horizontal (`Row`).
   * **Layar Sempit (< 900px):** Kartu QR Code dan Tabel Daftar Hadir otomatis bertumpuk secara vertikal (`Column`).
3. **Penyelarasan di Dasbor Wali Kelas:**
   Pola responsif serupa juga diterapkan pada [lib/screens/wali/wali_dashboard_view.dart](file:///c:/Dev/Projects/eDupu-Desktop/lib/screens/wali/wali_dashboard_view.dart) untuk kartu statistik dan tabel rekapitulasi presensi.

---

## 3. Verifikasi & Pengujian Kode

Seluruh berkas kode telah diverifikasi menggunakan *tooling* resmi Dart & Flutter:

```powershell
# 1. Pengecekan Kualitas Kode (Clean 0 Errors/Warnings)
dart analyze lib
# Output: No issues found!

# 2. Pengujian Unit & Widget Test Desktop
flutter test
# Output: 00:01 +1: All tests passed!
```

---

## 4. Panduan Menjalankan Aplikasi

```powershell
# Jalankan langsung pada target Windows Desktop
flutter run -d windows

# Atau pratinjau melalui browser Google Chrome Desktop
flutter run -d chrome
```

Saat aplikasi sedang berjalan, Anda dapat menekan tombol:
* `r` di konsol terminal untuk melakukan **Hot Reload** (memperbarui perubahan kode secara instan).
* `R` untuk melakukan **Hot Restart** (mengulang aplikasi dari awal).
* `q` untuk menghentikan aplikasi.
