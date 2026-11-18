# 🎓 eDupu Desktop Platform

<p align="center">
  <img src="assets/logo/edupufulltrans.png" alt="eDupu Desktop Banner" width="450">
</p>

<p align="center">
  <strong>Modern, Integrated School Management & Academic Suite for Windows</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart">
  <img src="https://img.shields.io/badge/Platform-Windows%20Desktop-blue?style=for-the-badge&logo=windows&logoColor=white" alt="Windows Desktop">
  <img src="https://img.shields.io/badge/Architecture-Clean%20Modular-green?style=for-the-badge" alt="Clean Modular">
  <img src="https://img.shields.io/badge/Version-1.0.0%2B1-orange?style=for-the-badge" alt="Version">
</p>

---

## 📌 Tentang eDupu Desktop

**eDupu Desktop** adalah aplikasi desktop modern berbasis Flutter yang dirancang khusus untuk memenuhi kebutuhan ekosistem manajemen sekolah terpadu. Aplikasi ini menghubungkan berbagai pemangku kepentingan di sekolah—mulai dari **Kepala Sekolah**, **Tata Usaha (Admin)**, **Wali Kelas**, hingga **Guru Mata Pelajaran**—dalam satu dasbor kerja yang cepat, intuitif, dan responsif.

---

## ✨ Fitur Unggulan Berdasarkan Peran (Role-Based Features)

Sistem mengadopsi kontrol akses berbasis peran (*Role-Based Access Control / RBAC*) yang ketat dengan antarmuka yang disesuaikan secara khusus:

### 1. 👔 Dashboard Kepala Sekolah (Executive Overview)
- **Ringkasan Eksekutif & KPI**: Monitoring metrik kehadiran siswa, guru, dan staf secara *real-time*.
- **Visualisasi Tren Interaktif**: Grafik analitik tren kehadiran dan performa akademik mingguan/bulanan didukung oleh `fl_chart`.
- **Monitoring Kedisiplinan & Operasional**: Visibilitas menyeluruh terhadap ketepatan waktu dan dinamika belajar mengajar sekolah.

### 2. 📋 Dashboard Tata Usaha / Admin Sekolah
- **Manajemen Data Siswa**: Pencatatan data pokok siswa (NISN, Nama, Rombel, Status Keaktifan).
- **Rekonsiliasi Presensi Harian**: Verifikasi dan rekap data ketidakhadiran (Sakit, Izin, Alpha).
- **Status Administrasi & SPP**: Pelacakan status pemenuhan administrasi dan iuran sekolah per siswa.

### 3. 🧑‍🏫 Dashboard Wali Kelas & E-Raport
- **Manajemen Rombel Terbina**: Pemantauan statistik spesifik siswa dalam kelas asuhan.
- **Modul E-Raport Digital**: Pengelolaan input nilai kompetensi, catatan perkembangan karakter, dan kalkulasi nilai akhir semester.
- **Ekspor & Pratinjau Nilai**: Format terstruktur untuk rekap evaluasi belajar siswa.

### 4. 📱 Dashboard Guru Mata Pelajaran (Presensi QR Code)
- **Generator QR Code Dinamis**: Menghasilkan QR Code sesi mata pelajaran secara instan (`qr_flutter`).
- **Presensi Nirsentuh & Cepat**: Mendukung validasi kehadiran siswa secara langsung di dalam kelas.
- **Jadwal Mengajar Terintegrasi**: Informasi sesi kelas aktif dan alokasi waktu mata pelajaran.

---

## 🛠️ Tech Stack & Dependensi

- **Core Framework**: [Flutter 3.x](https://flutter.dev/) (SDK `>=3.4.3 <4.0.0`)
- **Language**: [Dart](https://dart.dev/)
- **UI Design System**: Material Design 3 dengan palet warna enterprise
- **Komponen & Library Utama**:
  - `fl_chart: ^0.71.0` — Grafik dan data visualisasi interaktif.
  - `qr_flutter: ^4.1.0` — Rendering QR code presensi berbasis vektor presisi tinggi.
  - `google_fonts: ^6.3.0` — Tipografi modern dan konsisten.
  - `intl: ^0.20.2` — Format tanggal, waktu, dan lokalisasi numerik Indonesia (IDR).
  - `cupertino_icons: ^1.0.6` — Dukungan set ikon pelengkap.

---

## 📂 Struktur Proyek

Arsitektur aplikasi disusun secara modular untuk memudahkan pemeliharaan dan skalabilitas:

```text
eDupu-Desktop/
├── assets/
│   ├── images/              # Aset grafis & background UI
│   └── logo/                # Logo branding eDupu
├── lib/
│   ├── data/
│   │   └── mock_data.dart   # Dataset simulasi (User, Siswa, Statistik)
│   ├── models/
│   │   ├── student_model.dart  # Definisi entitas data siswa
│   │   └── user_model.dart     # Model pengguna & enumerasi role
│   ├── screens/
│   │   ├── guru/            # Modul fitur Guru (Presensi QR)
│   │   ├── kepsek/          # Modul analitik Kepala Sekolah
│   │   ├── tu/              # Modul Tata Usaha & Dapodik
│   │   ├── wali/            # Modul Wali Kelas & E-Raport
│   │   ├── login_screen.dart           # Layar otentikasi
│   │   └── main_dashboard_screen.dart  # Shell navigasi & layout utama
│   ├── services/
│   │   └── auth_service.dart   # State management & logika autentikasi
│   ├── theme/
│   │   └── app_theme.dart      # Konfigurasi skema warna dan tipografi
│   └── main.dart            # Titik masuk aplikasi (Entry Point)
├── windows/                 # Konfigurasi native Windows runner
├── pubspec.yaml             # Manajemen paket dan aset proyek
└── README.md
```

---

## 🚀 Panduan Memulai (Getting Started)

### Prasyarat Sistem
Pastikan perangkat Anda telah memenuhi spesifikasi berikut:
1. **OS**: Windows 10/11 (64-bit).
2. **Flutter SDK**: Versi `3.4.3` atau lebih tinggi ([Unduh Flutter SDK](https://docs.flutter.dev/get-started/install/windows)).
3. **Visual Studio**: Visual Studio 2022 dengan workload **"Desktop development with C++"** terpasang.
4. **Git**: Terpasang di environment PATH.

### Langkah Instalasi

1. **Clone Repositori**:
   ```bash
   git clone https://github.com/ZeroBug/eDupu-Desktop.git
   cd eDupu-Desktop
   ```

2. **Pasang Dependensi**:
   ```bash
   flutter pub get
   ```

3. **Verifikasi Toolchain**:
   Pastikan target Windows Desktop telah aktif dan siap:
   ```bash
   flutter doctor
   ```

4. **Jalankan Aplikasi dalam Mode Debug**:
   ```bash
   flutter run -d windows
   ```

5. **Build Executable Rilis (Produksi)**:
   ```bash
   flutter build windows --release
   ```
   *File binary executable (`.exe`) dan file runtime dependensi akan tersedia di folder:*  
   `build/windows/x64/runner/Release/`

---

## 🔑 Akun Demo (Mock Credentials)

Untuk keperluan pengujian antarmuka dan alur kerja, gunakan akun uji coba berikut:

| Peran (Role) | Username | Password | Deskripsi Pengguna |
| :--- | :--- | :--- | :--- |
| **Wali Kelas** | `wali` | `wali123` | Bpk. Hendro, S.Kom. (Wali Kelas XII RPL 1) |
| **Tata Usaha / Admin** | `admintu` | `admin123` | Ibu Siti Rahayu, S.Pd. (Admin Sekolah / TU) |
| **Kepala Sekolah** | `kepsek` | `kepsek123` | Drs. H. Bambang Sutrisno, M.Pd. (Pimpinan) |
| **Guru Mata Pelajaran** | `guru` | `guru123` | Bpk. Rian Hidayat, S.T. (Guru Produktif) |

> 💡 *Catatan: Sistem login ini saat ini menggunakan simulasi `MockData` lokal untuk mempermudah evaluasi tata letak dan fungsionalitas UI.*

---

## 🤝 Kontribusi

Kontribusi selalu disambut dengan baik! Jika Anda menemukan bug atau memiliki ide pengembangan:
1. *Fork* repositori ini.
2. Buat *feature branch* baru (`git checkout -b feature/FiturKeren`).
3. *Commit* perubahan Anda (`git commit -m 'feat: Menambahkan fitur keren'`).
4. *Push* ke branch Anda (`git push origin feature/FiturKeren`).
5. Buat sebuah **Pull Request**.

---

## 📄 Lisensi

Proyek ini dikembangkan oleh **Tim ZeroBug** dan dilindungi hak cipta internal. Silakan hubungi tim pengembang untuk izin penggunaan komersial dan integrasi API pihak ketiga.
