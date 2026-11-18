import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/auth_service.dart';
import 'main_dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController(text: 'wali');
  final _passwordController = TextEditingController(text: 'wali123');
  bool _obscurePassword = true;
  bool _rememberMe = true;
  bool _isLoading = false;
  String? _errorMessage;

  void _handleLogin() {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final auth = AuthService();
    final success = auth.login(
      _usernameController.text,
      _passwordController.text,
    );

    Future.delayed(const Duration(milliseconds: 350), () {
      if (!mounted) return;
      setState(() => _isLoading = false);

      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainDashboardScreen()),
        );
      } else {
        setState(() {
          _errorMessage = 'Nama pengguna atau kata sandi tidak ditemukan! Contoh: wali (wali123), admintu (admin123), kepsek (kepsek123).';
        });
      }
    });
  }

  void _fillAccount(String username, String password) {
    setState(() {
      _usernameController.text = username;
      _passwordController.text = password;
      _errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          // ============================================================
          // LEFT PANEL: 50% BRANDING BACKGROUND FOTO DENGAN SOFT BLUR
          // ============================================================
          Expanded(
            flex: 1,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Background Photo with soft blur
                Image.asset(
                  'assets/images/login-bg.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF0F172A), Color(0xFF1E3A8A), Color(0xFF2563EB)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    );
                  },
                ),

                // Blur filter layer
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3.5, sigmaY: 3.5),
                  child: Container(
                    color: Colors.black.withOpacity(0.28), // Darkener overlay
                  ),
                ),

                // Content over background
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Top Row: Back Button Arrow & Logo eDupu Bersebelahan
                      Row(
                        children: [
                          InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Image.asset(
                            'assets/logo/edupufulltrans.png',
                            height: 42,
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) {
                              return const Row(
                                children: [
                                  Icon(Icons.school_rounded, color: Colors.white, size: 28),
                                  SizedBox(width: 8),
                                  Text(
                                    'edupu',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 24, letterSpacing: -0.5),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),

                      // Middle: Deskripsi Sistem (Tata Letak Bersih & Elegan)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Portal Pembelajaran Digital &\nPresensi Cerdas',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 34,
                              fontWeight: FontWeight.w800,
                              height: 1.25,
                              letterSpacing: -0.6,
                              shadows: [
                                Shadow(color: Colors.black38, offset: Offset(0, 2), blurRadius: 8),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 480),
                            child: Text(
                              'Sistem informasi pembelajaran terpadu untuk absensi GPS geofence, modul ujian digital CBT, dan administrasi akademik terintegrasi.',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.95),
                                fontSize: 13.5,
                                height: 1.55,
                                fontWeight: FontWeight.w500,
                                shadows: const [
                                  Shadow(color: Colors.black38, offset: Offset(0, 1), blurRadius: 4),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Bottom: Copyright
                      Text(
                        '© 2026 eDupu • Sistem Manajemen Pembelajaran Sekolah',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ============================================================
          // RIGHT PANEL: 50% AUTH FORM (CLEAN UNIFIED PORTAL LOGIN)
          // ============================================================
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white,
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 36),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Heading
                        const Text(
                          'Selamat Datang!',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF0F172A), // Slate 900
                            letterSpacing: -0.6,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Masukkan nama pengguna dan kata sandi akun Anda untuk melanjutkan ke sistem.',
                          style: TextStyle(
                            color: Color(0xFF64748B), // Slate 500
                            fontSize: 12.5,
                            height: 1.4,
                          ),
                        ),

                        const SizedBox(height: 26),

                        // Error message alert if any
                        if (_errorMessage != null)
                          Container(
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.only(bottom: 18),
                            decoration: BoxDecoration(
                              color: AppTheme.redLight,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppTheme.red.withOpacity(0.2)),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.error_outline_rounded, color: AppTheme.red, size: 18),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    _errorMessage!,
                                    style: const TextStyle(color: AppTheme.red, fontSize: 11.5, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        // Username Label & Input
                        const Text(
                          'Nama Pengguna',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF334155), // Slate 700
                          ),
                        ),
                        const SizedBox(height: 7),
                        TextField(
                          controller: _usernameController,
                          style: const TextStyle(fontSize: 13, color: Color(0xFF0F172A)),
                          decoration: InputDecoration(
                            hintText: 'Masukkan nama pengguna',
                            hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12.5),
                            prefixIcon: const Icon(Icons.person_outline_rounded, size: 18, color: Color(0xFF94A3B8)),
                            filled: true,
                            fillColor: const Color(0xFFF8FAFC),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFF2563EB), width: 1.8),
                            ),
                          ),
                        ),

                        const SizedBox(height: 18),

                        // Password Label with "Lupa Sandi?" link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Kata Sandi',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF334155),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Silakan hubungi administrator Tata Usaha sekolah untuk reset kata sandi.'),
                                  ),
                                );
                              },
                              child: const Text(
                                'Lupa Sandi?',
                                style: TextStyle(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF2563EB),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 7),
                        TextField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          style: const TextStyle(fontSize: 13, color: Color(0xFF0F172A)),
                          decoration: InputDecoration(
                            hintText: 'Masukkan kata sandi',
                            hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12.5),
                            prefixIcon: const Icon(Icons.lock_outline_rounded, size: 18, color: Color(0xFF94A3B8)),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                size: 18,
                                color: const Color(0xFF94A3B8),
                              ),
                              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF8FAFC),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFF2563EB), width: 1.8),
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        // Remember me checkbox
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Checkbox(
                                value: _rememberMe,
                                activeColor: const Color(0xFF2563EB),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                side: const BorderSide(color: Color(0xFFCBD5E1), width: 1.5),
                                onChanged: (val) => setState(() => _rememberMe = val ?? false),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Ingat sesi saya di perangkat ini',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF475569), // Slate 600
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Submit Button "Masuk ke Dasbor Sistem →"
                        SizedBox(
                          width: double.infinity,
                          height: 46,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _handleLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2563EB),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              elevation: 0,
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                  )
                                : const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Masuk ke Dasbor Sistem',
                                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5),
                                      ),
                                      SizedBox(width: 8),
                                      Icon(Icons.arrow_forward_rounded, size: 16),
                                    ],
                                  ),
                          ),
                        ),

                        const SizedBox(height: 28),

                        // Quick 1-Click Demo Accounts Chips
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(Icons.touch_app_rounded, size: 14, color: Color(0xFF64748B)),
                                  SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      'Pilih Akun Demo (1-Click Isi Cepat):',
                                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11.5, color: Color(0xFF475569)),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  _buildQuickChip('Wali Kelas', 'wali', 'wali123', const Color(0xFF2563EB)),
                                  _buildQuickChip('Admin TU', 'admintu', 'admin123', const Color(0xFF059669)),
                                  _buildQuickChip('Kepala Sekolah', 'kepsek', 'kepsek123', const Color(0xFF0F172A)),
                                  _buildQuickChip('Guru Mapel', 'guru', 'guru123', const Color(0xFF6366F1)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickChip(String label, String user, String pass, Color dotColor) {
    return ActionChip(
      label: Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF334155))),
      backgroundColor: Colors.white,
      side: const BorderSide(color: Color(0xFFE2E8F0)),
      avatar: CircleAvatar(radius: 4, backgroundColor: dotColor),
      onPressed: () => _fillAccount(user, pass),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
    );
  }
}
