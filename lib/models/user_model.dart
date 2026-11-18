enum UserRole {
  walikelas,
  admin,
  kepsek,
  guru,
  superadmin,
}

extension UserRoleExtension on UserRole {
  String get key {
    switch (this) {
      case UserRole.walikelas:
        return 'walikelas';
      case UserRole.admin:
        return 'admin';
      case UserRole.kepsek:
        return 'kepsek';
      case UserRole.guru:
        return 'guru';
      case UserRole.superadmin:
        return 'superadmin';
    }
  }

  String get displayName {
    switch (this) {
      case UserRole.walikelas:
        return 'Wali Kelas';
      case UserRole.admin:
        return 'Admin Sekolah / TU';
      case UserRole.kepsek:
        return 'Kepala Sekolah';
      case UserRole.guru:
        return 'Guru Mata Pelajaran';
      case UserRole.superadmin:
        return 'Super Admin IT';
    }
  }
}

class UserModel {
  final String id;
  final String username;
  final String password;
  final String name;
  final String nip;
  final UserRole role;
  final String roleLabel;
  final String avatar;
  final String school;
  final String? classManaged;
  final String? department;
  final String? subject;

  const UserModel({
    required this.id,
    required this.username,
    required this.password,
    required this.name,
    required this.nip,
    required this.role,
    required this.roleLabel,
    required this.avatar,
    required this.school,
    this.classManaged,
    this.department,
    this.subject,
  });
}
