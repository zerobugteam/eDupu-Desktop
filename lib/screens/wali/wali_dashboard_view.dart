import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../data/mock_data.dart';
import '../../models/student_model.dart';

class WaliDashboardView extends StatelessWidget {
  final Function(String menuId)? onNavigate;

  const WaliDashboardView({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Welcome
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1E40AF), Color(0xFF2563EB), Color(0xFF3B82F6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primary.withOpacity(0.25),
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
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Kelas Binaan • XII Rekayasa Perangkat Lunak 1',
                          style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Selamat Datang, Bpk. Hendro, S.Kom.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Seluruh 36 peserta didik terhubung secara realtime dengan aplikasi eDupu Mobile Siswa.',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => onNavigate?.call('raport'),
                  icon: const Icon(Icons.print_rounded, size: 18),
                  label: const Text('Cetak Raport Kelas'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppTheme.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                    textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Stat Cards
          LayoutBuilder(
            builder: (context, c) {
              if (c.maxWidth < 750) {
                return Column(
                  children: [
                    Row(
                      children: [
                        _buildStatCard(title: 'Total Siswa Binaan', value: '36', subtitle: '100% Aktif Terdaftar', icon: Icons.people_alt_rounded, color: AppTheme.primary, bgColor: AppTheme.primaryLight),
                        const SizedBox(width: 12),
                        _buildStatCard(title: 'Kehadiran Hari Ini', value: '97.2%', subtitle: '35 Hadir • 1 Sakit', icon: Icons.fact_check_rounded, color: AppTheme.green, bgColor: AppTheme.greenLight),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _buildStatCard(title: 'Rata-Rata Leger', value: '88.4', subtitle: 'Semester Ganjil', icon: Icons.auto_graph_rounded, color: AppTheme.purple, bgColor: AppTheme.purpleLight),
                        const SizedBox(width: 12),
                        _buildStatCard(title: 'Catatan Konseling', value: '3 Kasus', subtitle: 'Tindak Lanjut', icon: Icons.support_agent_rounded, color: AppTheme.amber, bgColor: AppTheme.amberLight),
                      ],
                    ),
                  ],
                );
              }

              return Row(
                children: [
                  _buildStatCard(title: 'Total Siswa Binaan', value: '36', subtitle: '100% Aktif Terdaftar', icon: Icons.people_alt_rounded, color: AppTheme.primary, bgColor: AppTheme.primaryLight),
                  const SizedBox(width: 16),
                  _buildStatCard(title: 'Kehadiran Hari Ini', value: '97.2%', subtitle: '35 Hadir • 1 Izin Sakit', icon: Icons.fact_check_rounded, color: AppTheme.green, bgColor: AppTheme.greenLight),
                  const SizedBox(width: 16),
                  _buildStatCard(title: 'Rata-Rata Nilai Leger', value: '88.4', subtitle: 'Semester Ganjil 2026/2027', icon: Icons.auto_graph_rounded, color: AppTheme.purple, bgColor: AppTheme.purpleLight),
                  const SizedBox(width: 16),
                  _buildStatCard(title: 'Catatan Konseling', value: '3 Kasus', subtitle: 'Tindak Lanjut Karakter', icon: Icons.support_agent_rounded, color: AppTheme.amber, bgColor: AppTheme.amberLight),
                ],
              );
            },
          ),

          const SizedBox(height: 28),

          // Presensi Siswa Realtime Table & Side Actions
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 920;

              if (isNarrow) {
                return Column(
                  children: [
                    _buildPresensiTable(onNavigate),
                    const SizedBox(height: 20),
                    _buildSideActions(onNavigate),
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 7,
                    child: _buildPresensiTable(onNavigate),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 3,
                    child: _buildSideActions(onNavigate),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  static Widget _buildPresensiTable(Function(String menuId)? onNavigate) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppTheme.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 8,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Aktivitas Presensi Terkini (Mobile Flutter Sync)',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Data sinkron langsung saat siswa scan QR atau verifikasi GPS dari HP.',
                    style: TextStyle(color: AppTheme.textMuted, fontSize: 12),
                  ),
                ],
              ),
              OutlinedButton.icon(
                onPressed: () => onNavigate?.call('attendance'),
                icon: const Icon(Icons.open_in_new_rounded, size: 16),
                label: const Text('Buka Semua Rombel'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.primary,
                  side: const BorderSide(color: AppTheme.borderLight),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          // Table Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              children: [
                SizedBox(width: 100, child: Text('NISN', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                Expanded(child: Text('Nama Siswa', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                SizedBox(width: 130, child: Text('Metode Presensi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                SizedBox(width: 80, child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                SizedBox(width: 75, child: Text('Waktu', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Table Rows
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: MockData.attendanceRecords.length,
            separatorBuilder: (_, __) => const Divider(color: AppTheme.borderLight, height: 1),
            itemBuilder: (context, index) {
              final rec = MockData.attendanceRecords[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        rec.nisn,
                        style: const TextStyle(fontFamily: 'JetBrains Mono', fontSize: 11.5, color: AppTheme.textMuted),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        rec.studentName,
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12.5),
                      ),
                    ),
                    SizedBox(
                      width: 130,
                      child: Row(
                        children: [
                          Icon(
                            rec.method.contains('QR') ? Icons.qr_code_scanner_rounded : Icons.location_on_rounded,
                            size: 14,
                            color: AppTheme.primary,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              rec.method,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 11, color: AppTheme.textMuted),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 80,
                      child: _buildStatusBadge(rec.status),
                    ),
                    SizedBox(
                      width: 75,
                      child: Text(
                        '${rec.timestamp.hour.toString().padLeft(2, '0')}:${rec.timestamp.minute.toString().padLeft(2, '0')} WIB',
                        style: const TextStyle(fontSize: 11, color: AppTheme.textMuted),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  static Widget _buildSideActions(Function(String menuId)? onNavigate) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppTheme.borderLight),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tindakan Cepat Wali Kelas',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
              ),
              const SizedBox(height: 14),
              _buildActionTile(
                icon: Icons.description_rounded,
                title: 'Leger Nilai Semester',
                subtitle: 'Periksa nilai seluruh mapel',
                onTap: () => onNavigate?.call('grades'),
              ),
              const SizedBox(height: 10),
              _buildActionTile(
                icon: Icons.print_rounded,
                title: 'Cetak Lembar Raport',
                subtitle: 'Format A4 standar dinas',
                onTap: () => onNavigate?.call('raport'),
              ),
              const SizedBox(height: 10),
              _buildActionTile(
                icon: Icons.edit_note_rounded,
                title: 'Catatan Konseling',
                subtitle: 'Evaluasi perilaku & disiplin',
                onTap: () => onNavigate?.call('konseling'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppTheme.borderLight),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: AppTheme.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'eDupu Gateway Sinkron',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Sesi presensi online aktif. Wali murid menerima notifikasi otomatis saat absensi diverifikasi.',
                style: TextStyle(color: AppTheme.textMuted, fontSize: 11, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _buildStatCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Color bgColor,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(18),
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
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: AppTheme.textMuted),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Icon(icon, color: color, size: 18),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, letterSpacing: -0.5),
            ),
            const SizedBox(height: 3),
            Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 10.5, color: AppTheme.textMuted),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildStatusBadge(AttendanceStatus status) {
    Color bg;
    Color fg;
    String label;

    switch (status) {
      case AttendanceStatus.hadir:
        bg = AppTheme.greenLight;
        fg = AppTheme.green;
        label = 'Hadir';
        break;
      case AttendanceStatus.sakit:
        bg = AppTheme.amberLight;
        fg = AppTheme.amber;
        label = 'Sakit';
        break;
      case AttendanceStatus.izin:
        bg = AppTheme.primaryLight;
        fg = AppTheme.primary;
        label = 'Izin';
        break;
      case AttendanceStatus.alfa:
        bg = AppTheme.redLight;
        fg = AppTheme.red;
        label = 'Alfa';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(color: fg, fontWeight: FontWeight.bold, fontSize: 10.5),
      ),
    );
  }

  static Widget _buildActionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.borderLight),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.borderLight),
              ),
              child: Icon(icon, size: 18, color: AppTheme.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  Text(subtitle, style: const TextStyle(color: AppTheme.textMuted, fontSize: 11)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, size: 18, color: AppTheme.textLight),
          ],
        ),
      ),
    );
  }
}
