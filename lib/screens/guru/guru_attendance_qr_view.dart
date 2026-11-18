import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../theme/app_theme.dart';
import '../../data/mock_data.dart';
import '../../models/student_model.dart';

class GuruAttendanceQrView extends StatefulWidget {
  const GuruAttendanceQrView({super.key});

  @override
  State<GuruAttendanceQrView> createState() => _GuruAttendanceQrViewState();
}

class _GuruAttendanceQrViewState extends State<GuruAttendanceQrView> {
  int _secondsRemaining = 15;
  String _qrToken = 'edupu_token_${DateTime.now().millisecondsSinceEpoch}';
  Timer? _timer;
  bool _isSessionOpen = true;

  final List<AttendanceRecord> _scannedList = List.from(MockData.attendanceRecords);

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_secondsRemaining > 1) {
        setState(() => _secondsRemaining--);
      } else {
        setState(() {
          _secondsRemaining = 15;
          _qrToken = 'edupu_token_${DateTime.now().millisecondsSinceEpoch}';
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 900;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Bar with Responsive Wrap
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 16,
                runSpacing: 12,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: constraints.maxWidth > 500 ? constraints.maxWidth - 240 : constraints.maxWidth),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Presensi Jam Pelajaran Tatap Muka (QR Sync)',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, letterSpacing: -0.5),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Mata Pelajaran: Pemrograman Web & Perangkat Bergerak • Kelas XII RPL 1',
                          style: TextStyle(color: AppTheme.textMuted, fontSize: 12.5),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                        decoration: BoxDecoration(
                          color: _isSessionOpen ? AppTheme.greenLight : AppTheme.redLight,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: _isSessionOpen ? AppTheme.green : AppTheme.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _isSessionOpen ? 'Sesi Presensi Aktif' : 'Sesi Ditutup',
                              style: TextStyle(
                                color: _isSessionOpen ? AppTheme.green : AppTheme.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 11.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          setState(() => _isSessionOpen = !_isSessionOpen);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isSessionOpen ? AppTheme.red : AppTheme.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: Text(
                          _isSessionOpen ? 'Tutup Sesi' : 'Buka Kembali',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // Main Content Area: Responsive Layout (Row on wide, Column on narrow)
              if (isNarrow)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildQrCard(),
                    const SizedBox(height: 20),
                    _buildScannedListCard(),
                  ],
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 380,
                      child: _buildQrCard(),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _buildScannedListCard(),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQrCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.borderLight),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.primaryLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.timer_outlined, size: 15, color: AppTheme.primary),
                const SizedBox(width: 6),
                Text(
                  'Segarkan otomatis dalam $_secondsRemaining dtk',
                  style: const TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold, fontSize: 11.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.borderLight, width: 2),
            ),
            child: QrImageView(
              data: 'edupu://attend?session=rpl1_web&token=$_qrToken',
              version: QrVersions.auto,
              size: 220,
              backgroundColor: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Tampilkan di Layar Proyektor Kelas',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13.5),
          ),
          const SizedBox(height: 6),
          const Text(
            'Siswa membuka aplikasi eDupu Mobile Flutter lalu mengarahkan kamera scanner ke kode QR di atas.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppTheme.textMuted, fontSize: 11, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildScannedListCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header inside list card with Wrap to prevent any overflow!
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 8,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Daftar Hadir Terverifikasi (${_scannedList.length} / 36 Siswa)',
                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    'Data terupdate instan via WebSocket tanpa perlu refresh.',
                    style: TextStyle(color: AppTheme.textMuted, fontSize: 11.5),
                  ),
                ],
              ),
              OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    _scannedList.insert(
                      0,
                      AttendanceRecord(
                        nisn: '0058291048',
                        studentName: 'Iqbal Kurniawan (Simulasi Scan)',
                        rombel: 'XII RPL 1',
                        status: AttendanceStatus.hadir,
                        timestamp: DateTime.now(),
                        method: 'QR Mobile Flutter',
                      ),
                    );
                  });
                },
                icon: const Icon(Icons.add_task_rounded, size: 15),
                label: const Text('Simulasi Scan HP Masuk'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.primary,
                  side: const BorderSide(color: Color(0xFFBFDBFE)),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  textStyle: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: AppTheme.borderLight, height: 1),
          const SizedBox(height: 8),
          // Scanned Students List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _scannedList.length,
            separatorBuilder: (_, __) => const Divider(color: AppTheme.borderLight, height: 1),
            itemBuilder: (context, index) {
              final rec = _scannedList[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: AppTheme.primaryLight,
                      child: Text(
                        rec.studentName.substring(0, 1),
                        style: const TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(rec.studentName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12.5)),
                          Text('${rec.nisn} • ${rec.method}', style: const TextStyle(fontSize: 11, color: AppTheme.textMuted)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppTheme.greenLight,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text('Hadir', style: TextStyle(color: AppTheme.green, fontWeight: FontWeight.bold, fontSize: 10.5)),
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
}
