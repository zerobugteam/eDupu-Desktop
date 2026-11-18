import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../data/mock_data.dart';
import '../../models/student_model.dart';

class TuDashboardView extends StatefulWidget {
  const TuDashboardView({super.key});

  @override
  State<TuDashboardView> createState() => _TuDashboardViewState();
}

class _TuDashboardViewState extends State<TuDashboardView> {
  String _searchQuery = '';
  String _selectedMajor = 'Semua Jurusan';
  final List<StudentModel> _students = List.from(MockData.studentsList);

  List<StudentModel> get _filteredStudents {
    return _students.where((s) {
      final matchesSearch = s.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          s.nisn.contains(_searchQuery) ||
          s.rombel.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesMajor = _selectedMajor == 'Semua Jurusan' || s.major == _selectedMajor;
      return matchesSearch && matchesMajor;
    }).toList();
  }

  void _showAddStudentDialog() {
    final nisnController = TextEditingController();
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    String major = 'RPL';
    String rombel = 'XII RPL 1';

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: const Row(
                children: [
                  Icon(Icons.person_add_alt_1_rounded, color: AppTheme.primary),
                  SizedBox(width: 10),
                  Text('Tambah Peserta Didik Baru', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              content: SizedBox(
                width: 480,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nisnController,
                      decoration: const InputDecoration(
                        labelText: 'Nomor Induk Siswa Nasional (NISN)',
                        hintText: 'Contoh: 0058291055',
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nama Lengkap Siswa',
                        hintText: 'Nama sesuai akta lahir / ijazah',
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: major,
                            decoration: const InputDecoration(labelText: 'Kompetensi Keahlian'),
                            items: const [
                              DropdownMenuItem(value: 'RPL', child: Text('Rekayasa Perangkat Lunak')),
                              DropdownMenuItem(value: 'TKJ', child: Text('Teknik Komputer Jaringan')),
                              DropdownMenuItem(value: 'DKV', child: Text('Desain Komunikasi Visual')),
                            ],
                            onChanged: (val) {
                              if (val != null) setDialogState(() => major = val);
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: rombel,
                            decoration: const InputDecoration(labelText: 'Rombongan Belajar'),
                            items: const [
                              DropdownMenuItem(value: 'XII RPL 1', child: Text('XII RPL 1')),
                              DropdownMenuItem(value: 'XII RPL 2', child: Text('XII RPL 2')),
                              DropdownMenuItem(value: 'XI TKJ 1', child: Text('XI TKJ 1')),
                              DropdownMenuItem(value: 'XI DKV 1', child: Text('XI DKV 1')),
                            ],
                            onChanged: (val) {
                              if (val != null) setDialogState(() => rombel = val);
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Nomor WhatsApp Orang Tua / Wali',
                        hintText: '08xxxxxxxxxx',
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Batal', style: TextStyle(color: AppTheme.textMuted)),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (nameController.text.trim().isNotEmpty && nisnController.text.trim().isNotEmpty) {
                      setState(() {
                        _students.insert(
                          0,
                          StudentModel(
                            nisn: nisnController.text.trim(),
                            name: nameController.text.trim(),
                            rombel: rombel,
                            major: major,
                            parentPhone: phoneController.text.trim().isEmpty ? '081234567890' : phoneController.text.trim(),
                            attendanceRate: 100.0,
                          ),
                        );
                      });
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Data siswa baru berhasil ditambahkan dan disinkronkan ke master Dapodik!'),
                          backgroundColor: AppTheme.green,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Simpan & Daftarkan'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner TU
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppTheme.borderLight),
            ),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryLight,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.admin_panel_settings_rounded, color: AppTheme.primary, size: 28),
                ),
                const SizedBox(width: 18),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dasbor Layanan Administrasi Tata Usaha & Dapodik',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, letterSpacing: -0.5),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Kelola data master kesiswaan, tenaga pendidik, dan arsip presensi seluruh sekolah.',
                        style: TextStyle(color: AppTheme.textMuted, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _showAddStudentDialog,
                  icon: const Icon(Icons.person_add_rounded, size: 18),
                  label: const Text('Tambah Siswa Baru'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Stat Cards TU
          Row(
            children: [
              _buildTuStat('Total Peserta Didik', '864 Siswa', 'Terdaftar di Dapodik', Icons.groups_rounded, AppTheme.primary),
              const SizedBox(width: 16),
              _buildTuStat('Tenaga Pendidik & Staf', '48 Guru', '100% Aktif Mengajar', Icons.badge_rounded, AppTheme.green),
              const SizedBox(width: 16),
              _buildTuStat('Rombongan Belajar', '24 Kelas', 'X, XI, dan XII', Icons.meeting_room_rounded, AppTheme.purple),
              const SizedBox(width: 16),
              _buildTuStat('Sinkronisasi Dapodik', 'Tersambung', 'Update: Hari ini 07:00 WIB', Icons.sync_rounded, AppTheme.amber),
            ],
          ),

          const SizedBox(height: 28),

          // Data Master Siswa Table
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppTheme.borderLight),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Filter & Search Controls
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: TextField(
                        onChanged: (val) => setState(() => _searchQuery = val),
                        decoration: InputDecoration(
                          hintText: 'Cari berdasarkan NISN, Nama Siswa, atau Rombel...',
                          prefixIcon: const Icon(Icons.search_rounded, size: 20, color: AppTheme.textMuted),
                          filled: true,
                          fillColor: const Color(0xFFF8FAFC),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 200,
                      child: DropdownButtonFormField<String>(
                        value: _selectedMajor,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          filled: true,
                          fillColor: const Color(0xFFF8FAFC),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                        ),
                        items: const [
                          DropdownMenuItem(value: 'Semua Jurusan', child: Text('Semua Jurusan', style: TextStyle(fontSize: 12))),
                          DropdownMenuItem(value: 'RPL', child: Text('RPL', style: TextStyle(fontSize: 12))),
                          DropdownMenuItem(value: 'TKJ', child: Text('TKJ', style: TextStyle(fontSize: 12))),
                          DropdownMenuItem(value: 'DKV', child: Text('DKV', style: TextStyle(fontSize: 12))),
                        ],
                        onChanged: (val) {
                          if (val != null) setState(() => _selectedMajor = val);
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Mengekspor data master siswa ke format Excel (.xlsx)...')),
                        );
                      },
                      icon: const Icon(Icons.file_download_outlined, size: 18),
                      label: const Text('Ekspor Excel'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.textMain,
                        side: const BorderSide(color: AppTheme.borderLight),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Table Header
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    children: [
                      SizedBox(width: 120, child: Text('NISN', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                      Expanded(flex: 3, child: Text('Nama Lengkap', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                      SizedBox(width: 100, child: Text('Jurusan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                      SizedBox(width: 110, child: Text('Rombel', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                      SizedBox(width: 140, child: Text('No. WhatsApp Ortu', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                      SizedBox(width: 110, child: Text('Kehadiran', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                      SizedBox(width: 80, child: Text('Status', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // Table Content
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _filteredStudents.length,
                  separatorBuilder: (_, __) => const Divider(color: AppTheme.borderLight, height: 1),
                  itemBuilder: (context, index) {
                    final student = _filteredStudents[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 120,
                            child: Text(
                              student.nisn,
                              style: const TextStyle(fontFamily: 'JetBrains Mono', fontSize: 12, color: AppTheme.textMuted),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(student.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                          ),
                          SizedBox(
                            width: 100,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryLight,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                student.major,
                                style: const TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold, fontSize: 11),
                              ),
                            ),
                          ),
                          SizedBox(width: 110, child: Text(student.rombel, style: const TextStyle(fontSize: 12))),
                          SizedBox(
                            width: 140,
                            child: Text(student.parentPhone, style: const TextStyle(fontSize: 12, color: AppTheme.textMuted)),
                          ),
                          SizedBox(
                            width: 110,
                            child: Row(
                              children: [
                                Text(
                                  '${student.attendanceRate}%',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: student.attendanceRate >= 95 ? AppTheme.green : AppTheme.amber,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 80,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: AppTheme.greenLight,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                'Aktif',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: AppTheme.green, fontWeight: FontWeight.bold, fontSize: 11),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTuStat(String title, String value, String desc, IconData icon, Color color) {
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
                Icon(icon, color: color, size: 22),
              ],
            ),
            const SizedBox(height: 10),
            Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
            const SizedBox(height: 4),
            Text(desc, style: const TextStyle(fontSize: 11, color: AppTheme.textMuted)),
          ],
        ),
      ),
    );
  }
}
