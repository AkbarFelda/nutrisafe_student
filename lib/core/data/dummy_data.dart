import 'package:nutrisafe_student/core/widgets/app_role.dart';

class DummyNotification {
  const DummyNotification({
    required this.title,
    required this.message,
    required this.time,
    required this.isRead,
  });

  final String title;
  final String message;
  final String time;
  final bool isRead;
}

class DummyAllergy {
  const DummyAllergy({
    required this.studentName,
    required this.studentClass,
    required this.allergen,
    required this.description,
  });

  final String studentName;
  final String studentClass;
  final String allergen;
  final String description;
}

class DummyProfile {
  const DummyProfile({
    required this.name,
    required this.email,
    required this.phone,
  });

  final String name;
  final String email;
  final String phone;
}

abstract final class DummyData {
  static const notifications = <DummyNotification>[
    DummyNotification(
      title: 'Laporan Terkirim!',
      message: 'Laporan makanan kepada SPPG Indonesia pada tanggal 1 Februari 2026 berhasil terkirim.',
      time: '12:00',
      isRead: false,
    ),
    DummyNotification(
      title: 'Laporan Ditindaklanjuti',
      message:
          'Laporan kemasan rusak sedang ditinjau oleh petugas SPPG Indonesia.',
      time: '09:45',
      isRead: false,
    ),
    DummyNotification(
      title: 'Makanan Telah Diterima',
      message: 'Sebanyak 196 porsi makanan telah dikonfirmasi oleh sekolah.',
      time: 'Kemarin',
      isRead: true,
    ),
    DummyNotification(
      title: 'Data Alergi Diperbarui',
      message: 'Data alergi siswa kelas 6A berhasil diperbarui.',
      time: '2 Feb',
      isRead: true,
    ),
  ];

  static const allergies = <DummyAllergy>[
    DummyAllergy(
      studentName: 'Icha Aulia Ambarwati',
      studentClass: '6A',
      allergen: 'Kacang',
      description: 'Gatal-gatal saat mengonsumsi kacang.',
    ),
    DummyAllergy(
      studentName: 'Raka Pratama',
      studentClass: '5B',
      allergen: 'Susu sapi',
      description: 'Mual dan sakit perut setelah mengonsumsi produk susu.',
    ),
    DummyAllergy(
      studentName: 'Nadia Putri',
      studentClass: '4A',
      allergen: 'Udang',
      description: 'Ruam kemerahan setelah mengonsumsi udang.',
    ),
  ];

  static const studentProfile = DummyProfile(
    name: 'Icha Aulia Ambarwati',
    email: 'icha@student.id',
    phone: '0812 3456 7890',
  );

  static const schoolProfile = DummyProfile(
    name: 'SDN 1 Subang',
    email: 'admin@sdn1subang.sch.id',
    phone: '0260 411 234',
  );

  static DummyProfile profileFor(AppRole role) =>
      role == AppRole.student ? studentProfile : schoolProfile;
}
