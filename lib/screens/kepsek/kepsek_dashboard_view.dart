import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class KepsekDashboardView extends StatelessWidget {
  const KepsekDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Kepala Sekolah
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0F172A), Color(0xFF1E293B), Color(0xFF334155)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Dasbor Eksekutif Pimpinan Sekolah',
                          style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Drs. H. Bambang Sutrisno, M.Pd.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Monitoring real-time kedisiplinan 864 peserta didik dan 48 tenaga pendidik eDupu Academy.',
                        style: TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 13),
                      ),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Mengunduh Laporan_Evaluasi_Mutu_Pendidikan_Semester_Ganjil_2026.pdf...'),
                        backgroundColor: AppTheme.green,
                      ),
                    );
                  },
                  icon: const Icon(Icons.download_rounded, size: 18),
                  label: const Text('Unduh Laporan Mutu'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Executive KPI Cards
          Row(
            children: [
              _buildKpiCard('Tingkat Kehadiran Sekolah', '97.4%', '842 dari 864 Siswa Hadir', Icons.trending_up_rounded, AppTheme.green, AppTheme.greenLight),
              const SizedBox(width: 16),
              _buildKpiCard('Kehadiran Pendidik', '100%', '48 Guru Aktif di Kelas', Icons.verified_user_rounded, AppTheme.primary, AppTheme.primaryLight),
              const SizedBox(width: 16),
              _buildKpiCard('Ketercapaian Nilai KKTP', '86.8', 'Standar Min: 75.0', Icons.auto_awesome_rounded, AppTheme.purple, AppTheme.purpleLight),
              const SizedBox(width: 16),
              _buildKpiCard('Tingkat Ketidakhadiran', '2.6%', '14 Sakit • 6 Izin • 2 Alfa', Icons.info_outline_rounded, AppTheme.amber, AppTheme.amberLight),
            ],
          ),

          const SizedBox(height: 28),

          // Row Analytics & Breakdown
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Kehadiran per Jurusan (60%)
              Expanded(
                flex: 6,
                child: Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppTheme.borderLight),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ringkasan Kehadiran per Program Keahlian',
                        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Data terintegrasi otomatis dari GPS Geofence & QR Scanner aplikasi siswa.',
                        style: TextStyle(color: AppTheme.textMuted, fontSize: 12),
                      ),
                      const SizedBox(height: 20),
                      _buildMajorProgress('Rekayasa Perangkat Lunak (RPL)', 0.985, '98.5%', '335 dari 340 Siswa Hadir', AppTheme.primary),
                      const SizedBox(height: 16),
                      _buildMajorProgress('Teknik Komputer & Jaringan (TKJ)', 0.972, '97.2%', '280 dari 288 Siswa Hadir', AppTheme.green),
                      const SizedBox(height: 16),
                      _buildMajorProgress('Desain Komunikasi Visual (DKV)', 0.961, '96.1%', '227 dari 236 Siswa Hadir', AppTheme.purple),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 20),

              // Status Monitoring Guru Hari Ini (40%)
              Expanded(
                flex: 4,
                child: Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppTheme.borderLight),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Status Guru Jam Pelajaran Aktif',
                            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                          ),
                          Text('Sesi 3 (09:45 WIB)', style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold, fontSize: 11)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildTeacherStatusTile('Bpk. Hendro, S.Kom.', 'XII RPL 1 • Basis Data Lanjut', 'Tatap Muka di Lab 2', true),
                      const SizedBox(height: 10),
                      _buildTeacherStatusTile('Bpk. Rian Hidayat, S.T.', 'XII RPL 2 • Pemrograman Web', 'Sesi Ujian CBT Online', true),
                      const SizedBox(height: 10),
                      _buildTeacherStatusTile('Ibu Maya Lestari, M.Pd.', 'XI TKJ 1 • Jaringan Komputer', 'Tatap Muka di Ruang 14', true),
                      const SizedBox(height: 10),
                      _buildTeacherStatusTile('Bpk. Joko Anwar, S.Sn.', 'XI DKV 1 • Desain Grafis', 'Praktik Studio Foto', true),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _buildKpiCard(String title, String value, String desc, IconData icon, Color color, Color bg) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppTheme.borderLight),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.textMuted)),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
                  child: Icon(icon, color: color, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
            const SizedBox(height: 4),
            Text(desc, style: const TextStyle(fontSize: 11, color: AppTheme.textMuted)),
          ],
        ),
      ),
    );
  }

  static Widget _buildMajorProgress(String title, double progress, String percent, String count, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            Text(percent, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: color)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: const Color(0xFFF1F5F9),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 10,
          ),
        ),
        const SizedBox(height: 4),
        Text(count, style: const TextStyle(fontSize: 11, color: AppTheme.textMuted)),
      ],
    );
  }

  static Widget _buildTeacherStatusTile(String name, String subject, String room, bool active) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderLight),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(color: AppTheme.green, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                Text(subject, style: const TextStyle(fontSize: 11, color: AppTheme.textMuted)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6), border: Border.all(color: AppTheme.borderLight)),
            child: Text(room, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppTheme.textMain)),
          ),
        ],
      ),
    );
  }
}
