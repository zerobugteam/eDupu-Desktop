class StudentModel {
  final String nisn;
  final String name;
  final String rombel;
  final String major;
  final String parentPhone;
  final double attendanceRate;
  final String status;

  const StudentModel({
    required this.nisn,
    required this.name,
    required this.rombel,
    required this.major,
    required this.parentPhone,
    required this.attendanceRate,
    this.status = 'Aktif',
  });
}

enum AttendanceStatus { hadir, sakit, izin, alfa }

class AttendanceRecord {
  final String nisn;
  final String studentName;
  final String rombel;
  final AttendanceStatus status;
  final DateTime timestamp;
  final String method; // 'QR Mobile', 'GPS Geofence', 'Manual Guru'

  const AttendanceRecord({
    required this.nisn,
    required this.studentName,
    required this.rombel,
    required this.status,
    required this.timestamp,
    required this.method,
  });
}

class GradeRecord {
  final int no;
  final String subject;
  final double kktp;
  final double score;
  final String letterGrade;
  final String description;

  const GradeRecord({
    required this.no,
    required this.subject,
    required this.kktp,
    required this.score,
    required this.letterGrade,
    required this.description,
  });
}
