# 02. Role, Kredensial & Konfigurasi Lingkungan Windows

Dokumen ini merangkum pembagian hak akses (*Role-Based Access Control*), akun pengujian, fitur khusus per role, struktur berkas proyek, serta panduan konfigurasi lingkungan sistem operasi Windows.

---

## 1. Matriks Kredensial Login Resmi

Aplikasi Desktop eDupu disinkronkan dengan data akun pada portal [eDupu Platform](https://zerobugteam.github.io/eDupu/login.html):

| Role Pengguna | Nama Pejabat / Staf | Username / NIP Login | Kata Sandi | Fokus Dasbor Utama |
| :--- | :--- | :--- | :--- | :--- |
| **Wali Kelas** | Bpk. Hendro, S.Kom. | `wali` atau `19840212` | `wali123` | Monitoring 36 siswa binaan XII RPL 1, Leger Nilai, dan Cetak Raport A4 Resmi. |
| **Admin Sekolah / TU** | Ibu Siti Rahayu, S.Pd. | `admintu` atau `admin` | `admin123` | Data master 864 siswa, 48 guru, dialog tambah siswa baru, & ekspor data Dapodik/Excel. |
| **Kepala Sekolah** | Drs. H. Bambang Sutrisno, M.Pd. | `kepsek` atau `19671108` | `kepsek123` | Dasbor Eksekutif mutu sekolah, analitik kehadiran 97.4%, monitoring guru aktif, & Laporan Mutu. |
| **Guru Mata Pelajaran** | Bpk. Rian Hidayat, S.T. | `guru` | `guru123` | Generator Dynamic QR Code presensi tatap muka & sinkronisasi scan HP siswa secara realtime. |

---

## 2. Fitur Khusus Desktop Tiap Role yang Sudah Dibangun

### A. Wali Kelas ([wali_dashboard_view.dart](file:///c:/Dev/Projects/eDupu-Desktop/lib/screens/wali/wali_dashboard_view.dart) & [wali_raport_view.dart](file:///c:/Dev/Projects/eDupu-Desktop/lib/screens/wali/wali_raport_view.dart)):
* **Rekap kehadiran kelas XII RPL 1:** 97.2% hadir, 1 sakit dari total 36 peserta didik.
* **Feed realtime presensi siswa:** Memantau siswa yang masuk via mobile secara instan (lengkap dengan timestamp & metode presensi QR/GPS).
* **Cetak Lembar Raport Akademik:** Template cetak A4 Kurikulum Merdeka lengkap dengan capaian kompetensi, predikat nilai, dan kolom tanda tangan resmi Wali Kelas & Orang Tua.
* **Catatan Konseling:** Fitur evaluasi kedisiplinan dan pembinaan karakter siswa binaan.

### B. Admin Tata Usaha ([tu_dashboard_view.dart](file:///c:/Dev/Projects/eDupu-Desktop/lib/screens/tu/tu_dashboard_view.dart)):
* **Ringkasan kesiswaan:** 864 Peserta Didik, 48 Guru/Staf, 24 Rombel, status integrasi Dapodik tersinkronisasi.
* **Pencarian interaktif & filter jurusan:** Pencarian cepat berbasis NISN, Nama, atau Rombel serta penyaringan kategori RPL, TKJ, dan DKV.
* **Modal Dialog Tambah Siswa Baru:** Registrasi data siswa baru langsung ke master data lokal (NISN, Nama, Rombel, No. WhatsApp Orang Tua).
* **Tombol aksi cepat ekspor data master:** Mengunduh basis data kesiswaan ke format file Excel (`.xlsx`).

### C. Kepala Sekolah ([kepsek_dashboard_view.dart](file:///c:/Dev/Projects/eDupu-Desktop/lib/screens/kepsek/kepsek_dashboard_view.dart)):
* **Metrik eksekutif tingkat kehadiran sekolah:** Statistik presensi harian 97.4% (842 dari 864 siswa hadir).
* **Visual progress kehadiran per jurusan:** Indikator tingkat kehadiran real-time per keahlian (RPL 98.5%, TKJ 97.2%, DKV 96.1%).
* **Monitoring status guru pada jam pelajaran aktif:** Pemantauan status guru tatap muka di lab/kelas vs guru yang sedang mengawas ujian CBT online.
* **Tombol unduh berkas Laporan Mutu:** Unduh langsung berkas resmi Laporan Evaluasi Mutu Pendidikan semesteran.

### D. Guru Mapel - Sinkronisasi Mobile ([guru_attendance_qr_view.dart](file:///c:/Dev/Projects/eDupu-Desktop/lib/screens/guru/guru_attendance_qr_view.dart)):
* **Dynamic QR Code Generator:** Menampilkan QR Code presensi di layar laptop/proyektor yang berganti otomatis tiap 15 detik untuk mencegah kecurangan/titip absen.
* **Sinkronisasi Kamera Mobile:** Siswa membuka aplikasi eDupu Mobile Flutter dan melakukan scan langsung ke layar desktop.
* **Simulasi Scan Mobile:** Dilengkapi tombol uji coba scan instan untuk menguji alur data absensi masuk tanpa membutuhkan HP fisik saat pengembangan.

---

## 3. Struktur Berkas Proyek di Workspace

* 📁 **[lib/main.dart](file:///c:/Dev/Projects/eDupu-Desktop/lib/main.dart)**: Entry point aplikasi dengan tema kustom eDupu Platform.
* 📁 **[lib/theme/app_theme.dart](file:///c:/Dev/Projects/eDupu-Desktop/lib/theme/app_theme.dart)**: Skema warna (Royal Blue `#2563EB`, Emerald Green, Slate) & tipografi *Inter*.
* 📁 **[lib/services/auth_service.dart](file:///c:/Dev/Projects/eDupu-Desktop/lib/services/auth_service.dart)**: Logika otentikasi login, session user, dan fitur *Quick Switch Role*.
* 📁 **[lib/screens/login_screen.dart](file:///c:/Dev/Projects/eDupu-Desktop/lib/screens/login_screen.dart)**: Tampilan login split-screen branding & chip akun demo 1-klik.
* 📁 **[lib/screens/main_dashboard_screen.dart](file:///c:/Dev/Projects/eDupu-Desktop/lib/screens/main_dashboard_screen.dart)**: Shell master navbar & sidebar role switcher adaptif.
* 📁 **[lib/screens/wali/](file:///c:/Dev/Projects/eDupu-Desktop/lib/screens/wali/)**: Tampilan dasbor rombel dan lembar cetak raport A4 wali kelas.
* 📁 **[lib/screens/tu/](file:///c:/Dev/Projects/eDupu-Desktop/lib/screens/tu/)**: Tampilan master kesiswaan, modal registrasi siswa, dan ekspor data TU.
* 📁 **[lib/screens/kepsek/](file:///c:/Dev/Projects/eDupu-Desktop/lib/screens/kepsek/)**: Tampilan KPI eksekutif dan monitoring pengajar aktif.
* 📁 **[lib/screens/guru/](file:///c:/Dev/Projects/eDupu-Desktop/lib/screens/guru/)**: Generator Dynamic QR Code presensi jam pelajaran.
* 📁 **[test/widget_test.dart](file:///c:/Dev/Projects/eDupu-Desktop/test/widget_test.dart)**: Unit & widget test desktop *(Status: Passed 100%)*.

---

## 4. Cara Menjalankan Aplikasi di Windows

Untuk menjalankan aplikasi di perangkat Windows:

```powershell
# 1. Pastikan berada di folder proyek
cd c:\Dev\Projects\eDupu-Desktop

# 2. Jalankan target desktop Windows
flutter run -d windows
```

> [!NOTE]
> **Panduan Setup Windows (Symlink Support & Developer Mode):**
> Jika muncul pesan `Building with plugins requires symlink support`:
> * **Solusi 1 (Developer Mode ON):** Buka terminal dan jalankan `start ms-settings:developers`, lalu aktifkan opsi **Developer Mode** ke posisi **ON**.
> * **Solusi 2 (Admin Terminal):** Buka PowerShell dengan memilih **"Run as administrator"** lalu jalankan `flutter run -d windows`.
> * **Alternatif Browser:** Anda juga dapat menguji di peramban Chrome desktop dengan `flutter run -d chrome`.
