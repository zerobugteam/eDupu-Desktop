import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import 'wali/wali_dashboard_view.dart';
import 'wali/wali_raport_view.dart';
import 'tu/tu_dashboard_view.dart';
import 'kepsek/kepsek_dashboard_view.dart';
import 'guru/guru_attendance_qr_view.dart';
import 'login_screen.dart';

class MainDashboardScreen extends StatefulWidget {
  const MainDashboardScreen({super.key});

  @override
  State<MainDashboardScreen> createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends State<MainDashboardScreen> {
  String _activeMenuId = 'dashboard';

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final user = authService.currentUser;

    if (user == null) {
      return const LoginScreen();
    }

    return Scaffold(
      body: Column(
        children: [
          // 1. Full-Width Top Header Navbar
          _buildHeader(user, authService),

          // 2. Main Body: Sidebar (Left) + View Content (Right)
          Expanded(
            child: Row(
              children: [
                // Sidebar Navigation (260px)
                _buildSidebar(user),

                // View Body Area
                Expanded(
                  child: Container(
                    color: AppTheme.bgSurface,
                    child: _buildCurrentView(user),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Top Header Navbar
  Widget _buildHeader(UserModel user, AuthService authService) {
    return Container(
      height: 68,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppTheme.borderLight)),
      ),
      child: Row(
        children: [
          // Brand Logo Section (260px)
          Container(
            width: 260,
            padding: const EdgeInsets.symmetric(horizontal: 22),
            decoration: const BoxDecoration(
              border: Border(right: BorderSide(color: AppTheme.borderLight)),
            ),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppTheme.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'eD',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('eDupu Platform', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, letterSpacing: -0.4)),
                    Text('Desktop School Suite', style: TextStyle(color: AppTheme.textMuted, fontSize: 10, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),

          // Center Title
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                _getHeaderTitle(user.role),
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: AppTheme.textMain),
              ),
            ),
          ),

          // Right Controls: Quick Switch Role + User Profile + Logout
          Padding(
            padding: const EdgeInsets.only(right: 22),
            child: Row(
              children: [
                // Quick Switch Role Dropdown (for testing and multi-role staff)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.bgSurface,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppTheme.borderLight),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<UserRole>(
                      value: user.role,
                      icon: const Icon(Icons.arrow_drop_down_rounded, color: AppTheme.textMuted),
                      items: const [
                        DropdownMenuItem(
                          value: UserRole.walikelas,
                          child: Text('Wali Kelas (Bpk. Hendro)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        ),
                        DropdownMenuItem(
                          value: UserRole.admin,
                          child: Text('Admin TU (Ibu Siti Rahayu)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        ),
                        DropdownMenuItem(
                          value: UserRole.kepsek,
                          child: Text('Kepala Sekolah (Drs. H. Bambang)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        ),
                        DropdownMenuItem(
                          value: UserRole.guru,
                          child: Text('Guru Mapel (Bpk. Rian)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        ),
                      ],
                      onChanged: (newRole) {
                        if (newRole != null) {
                          setState(() {
                            authService.switchRole(newRole);
                            _activeMenuId = 'dashboard';
                          });
                        }
                      },
                    ),
                  ),
                ),

                const SizedBox(width: 14),

                // User Profile Pill
                Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: AppTheme.primaryLight,
                      child: Text(
                        user.name.substring(0, 1),
                        style: const TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        Text(user.roleLabel, style: const TextStyle(color: AppTheme.textMuted, fontSize: 10)),
                      ],
                    ),
                  ],
                ),

                const SizedBox(width: 16),

                // Logout Button
                IconButton(
                  tooltip: 'Keluar dari Sistem',
                  icon: const Icon(Icons.logout_rounded, size: 20, color: AppTheme.red),
                  onPressed: () {
                    authService.logout();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
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

  // Sidebar Menu
  Widget _buildSidebar(UserModel user) {
    final List<Map<String, dynamic>> menuItems = _getMenuItemsForRole(user.role);

    return Container(
      width: 260,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: AppTheme.borderLight)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Text(
              _getRoleSectionLabel(user.role),
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
                color: AppTheme.textLight,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                final isSelected = _activeMenuId == item['id'];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: InkWell(
                    onTap: () {
                      setState(() => _activeMenuId = item['id']);
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                      decoration: BoxDecoration(
                        color: isSelected ? AppTheme.primaryLight : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            item['icon'] as IconData,
                            size: 18,
                            color: isSelected ? AppTheme.primary : AppTheme.textMuted,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              item['label'] as String,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                color: isSelected ? AppTheme.primary : AppTheme.textMain,
                              ),
                            ),
                          ),
                          if (item['badge'] != null)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: isSelected ? AppTheme.primary : const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                item['badge'] as String,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? Colors.white : AppTheme.textMuted,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Bottom System Info
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppTheme.borderLight)),
            ),
            child: const Row(
              children: [
                Icon(Icons.wifi_rounded, size: 16, color: AppTheme.green),
                SizedBox(width: 8),
                Text('Server Lokal: Tersambung', style: TextStyle(fontSize: 11, color: AppTheme.textMuted, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Active View Switcher
  Widget _buildCurrentView(UserModel user) {
    if (user.role == UserRole.walikelas) {
      if (_activeMenuId == 'raport') return const WaliRaportView();
      if (_activeMenuId == 'attendance') return const GuruAttendanceQrView();
      return WaliDashboardView(onNavigate: (id) => setState(() => _activeMenuId = id));
    } else if (user.role == UserRole.admin) {
      return const TuDashboardView();
    } else if (user.role == UserRole.kepsek) {
      return const KepsekDashboardView();
    } else if (user.role == UserRole.guru) {
      return const GuruAttendanceQrView();
    }
    return WaliDashboardView(onNavigate: (id) => setState(() => _activeMenuId = id));
  }

  String _getHeaderTitle(UserRole role) {
    switch (role) {
      case UserRole.walikelas:
        return 'Dasbor Wali Kelas • Monitoring Peserta Didik XII RPL 1';
      case UserRole.admin:
        return 'Dasbor Administrasi Sekolah & Layanan Tata Usaha';
      case UserRole.kepsek:
        return 'Dasbor Eksekutif Monitoring Mutu & Presensi Sekolah';
      case UserRole.guru:
        return 'Dasbor Guru Pengampu Mata Pelajaran & Sesi Presensi';
      case UserRole.superadmin:
        return 'Dasbor Konfigurasi Teknis Sistem';
    }
  }

  String _getRoleSectionLabel(UserRole role) {
    switch (role) {
      case UserRole.walikelas:
        return 'MENU WALI KELAS';
      case UserRole.admin:
        return 'MENU ADMINISTRASI TU';
      case UserRole.kepsek:
        return 'MENU KEPALA SEKOLAH';
      case UserRole.guru:
        return 'MENU GURU MAPEL';
      case UserRole.superadmin:
        return 'MENU SISTEM';
    }
  }

  List<Map<String, dynamic>> _getMenuItemsForRole(UserRole role) {
    switch (role) {
      case UserRole.walikelas:
        return [
          {'id': 'dashboard', 'label': 'Dasbor Wali Kelas', 'icon': Icons.dashboard_rounded, 'badge': 'XII RPL 1'},
          {'id': 'attendance', 'label': 'Monitoring Presensi', 'icon': Icons.fact_check_rounded, 'badge': '36 Siswa'},
          {'id': 'grades', 'label': 'Leger Nilai Kelas', 'icon': Icons.assignment_turned_in_rounded, 'badge': 'Sem 5'},
          {'id': 'raport', 'label': 'Cetak Raport Siswa', 'icon': Icons.print_rounded, 'badge': 'A4 Resmi'},
          {'id': 'konseling', 'label': 'Catatan Konseling', 'icon': Icons.support_agent_rounded},
        ];
      case UserRole.admin:
        return [
          {'id': 'dashboard', 'label': 'Dasbor Master TU', 'icon': Icons.dashboard_rounded, 'badge': 'Dapodik'},
          {'id': 'students', 'label': 'Data Master Kesiswaan', 'icon': Icons.groups_rounded, 'badge': '864 Siswa'},
          {'id': 'teachers', 'label': 'Data Pendidik & Staf', 'icon': Icons.badge_rounded, 'badge': '48 Guru'},
          {'id': 'curriculum', 'label': 'Kurikulum & Jadwal', 'icon': Icons.calendar_month_rounded},
          {'id': 'reports', 'label': 'Laporan & Rekapitulasi', 'icon': Icons.file_present_rounded, 'badge': 'Ekspor'},
        ];
      case UserRole.kepsek:
        return [
          {'id': 'dashboard', 'label': 'Dasbor Eksekutif', 'icon': Icons.dashboard_rounded, 'badge': 'Pantau'},
          {'id': 'attendance', 'label': 'Monitoring Presensi', 'icon': Icons.insights_rounded, 'badge': '97.4%'},
          {'id': 'cbt', 'label': 'Hasil Belajar & CBT', 'icon': Icons.auto_graph_rounded, 'badge': 'KKTP 75'},
          {'id': 'reports', 'label': 'Laporan Mutu Sekolah', 'icon': Icons.workspace_premium_rounded, 'badge': 'Dinas'},
        ];
      case UserRole.guru:
        return [
          {'id': 'dashboard', 'label': 'Presensi Jam Pelajaran', 'icon': Icons.qr_code_scanner_rounded, 'badge': 'Tatap Muka'},
          {'id': 'schedule', 'label': 'Jadwal Mengajar', 'icon': Icons.calendar_today_rounded},
          {'id': 'grades', 'label': 'Input Nilai Siswa', 'icon': Icons.grade_rounded},
          {'id': 'cbt', 'label': 'Bank Soal Ujian CBT', 'icon': Icons.quiz_rounded, 'badge': 'Online'},
        ];
      default:
        return [];
    }
  }
}
