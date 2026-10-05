class SchoolProfileModel {
  const SchoolProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.npsn,
    required this.location,
    required this.grade,
  });

  final int id;
  final String name;
  final String email;
  final String phone;
  final String npsn;
  final String location;
  final String grade;

  factory SchoolProfileModel.fromJson(Map<String, dynamic> json) =>
      SchoolProfileModel(
        id: int.tryParse('${json['id'] ?? 0}') ?? 0,
        name: '${json['name'] ?? json['school_name'] ?? ''}',
        email: '${json['email'] ?? ''}',
        phone: '${json['phone'] ?? ''}',
        npsn: '${json['npsn'] ?? ''}',
        location: '${json['lokasi'] ?? json['address'] ?? ''}',
        grade: '${json['grade'] ?? ''}',
      );
}

class SchoolAllergyModel {
  const SchoolAllergyModel({
    this.id = 0,
    required this.studentName,
    required this.className,
    required this.allergyType,
    required this.description,
    required this.severity,
    required this.actionRequired,
  });

  final int id;
  final String studentName;
  final String className;
  final String allergyType;
  final String description;
  final String severity;
  final String actionRequired;

  factory SchoolAllergyModel.fromJson(Map<String, dynamic> json) =>
      SchoolAllergyModel(
        id: int.tryParse('${json['id'] ?? 0}') ?? 0,
        studentName: '${json['student_name'] ?? ''}',
        className: '${json['class_name'] ?? ''}',
        allergyType: '${json['allergy_type'] ?? ''}',
        description: '${json['description'] ?? ''}',
        severity: '${json['severity'] ?? ''}',
        actionRequired: '${json['action_required'] ?? ''}',
      );

  Map<String, dynamic> toJson() => {
    'student_name': studentName,
    'class_name': className,
    'allergy_type': allergyType,
    'description': description,
    'severity': severity,
    'action_required': actionRequired,
  };
}

class SchoolStudentModel {
  const SchoolStudentModel({
    this.id = 0,
    required this.name,
    required this.email,
    required this.phone,
    required this.schoolName,
    required this.npsn,
    required this.address,
  });

  final int id;
  final String name;
  final String email;
  final String phone;
  final String schoolName;
  final String npsn;
  final String address;

  factory SchoolStudentModel.fromJson(Map<String, dynamic> json) =>
      SchoolStudentModel(
        id: int.tryParse('${json['id'] ?? 0}') ?? 0,
        name: '${json['name'] ?? ''}',
        email: '${json['email'] ?? ''}',
        phone: '${json['phone'] ?? ''}',
        schoolName: '${json['school_name'] ?? ''}',
        npsn: '${json['npsn'] ?? ''}',
        address: '${json['address'] ?? json['lokasi'] ?? ''}',
      );

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'phone': phone,
    'school_name': schoolName,
    'npsn': npsn,
    'address': address,
  };
}
