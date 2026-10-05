class AuthUser {
  const AuthUser({required this.email, required this.role, this.name});

  final String email;
  final String role;
  final String? name;

  factory AuthUser.fromJson(Map<String, dynamic> json, String fallbackEmail) {
    final roleValue = json['role_name'] ?? json['role'] ?? json['type'];
    final role = roleValue is Map<String, dynamic>
        ? roleValue['name']?.toString()
        : roleValue?.toString();
    return AuthUser(
      email: json['email']?.toString() ?? fallbackEmail,
      role: role ?? roleFromEmail(fallbackEmail),
      name: json['name']?.toString(),
    );
  }
}

class AuthSession {
  const AuthSession({required this.user, this.token});

  final AuthUser user;
  final String? token;

  factory AuthSession.fromJson(
    Map<String, dynamic> json, {
    required String fallbackEmail,
  }) {
    final data = json['data'] is Map<String, dynamic>
        ? json['data'] as Map<String, dynamic>
        : json;
    final userJson = data['user'] is Map<String, dynamic>
        ? data['user'] as Map<String, dynamic>
        : data;
    return AuthSession(
      user: AuthUser.fromJson(userJson, fallbackEmail),
      token: (data['token'] ?? data['access_token'] ?? json['token'])
          ?.toString(),
    );
  }
}

String roleFromEmail(String email) {
  final normalized = email.trim().toLowerCase();
  if (normalized.endsWith('@siswa.sch.id')) return 'siswa';
  if (normalized.endsWith('@sch.id')) return 'sekolah';
  return 'umum';
}

class GeneralRegistration {
  const GeneralRegistration({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  final String name;
  final String email;
  final String phone;
  final String password;

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'phone': phone,
    'password': password,
    'role_name': 'umum',
  };
}

class SchoolRegistration {
  const SchoolRegistration({
    required this.name,
    required this.email,
    required this.phone,
    required this.schoolName,
    required this.npsn,
    required this.address,
    required this.grade,
  });

  final String name;
  final String email;
  final String phone;
  final String schoolName;
  final String npsn;
  final String address;
  final String grade;

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'phone': phone,
    'school_name': schoolName,
    'npsn': npsn,
    'address': address,
    'grade': grade,
  };
}
