part of 'report_views.dart';

class ReportDetailView extends StatelessWidget {
  const ReportDetailView({super.key, required this.role});

  final AppRole role;

  @override
  Widget build(BuildContext context) {
    return RoleScaffold(
      role: role,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          context.pagePadding,
          context.isShortPhone ? 10 : 20,
          context.pagePadding,
          24,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: Get.back,
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                color: role.heading,
              ),
            ),
            const Align(
              alignment: Alignment.centerRight,
              child: Text('Hari ini pada 12:00', style: TextStyle(fontSize: 8)),
            ),
            const Text(
              'Laporan Terkirim!',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 7),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Laporan makanan kepada SPPG Indonesia pada tanggal 1 Februari 2026 berhasil terkirim!',
                style: TextStyle(fontSize: 11),
              ),
            ),
            const SizedBox(height: 35),
            Container(
              padding: const EdgeInsets.fromLTRB(9, 14, 9, 40),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF888888)),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Detail Laporan',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: _MetaChip(
                      icon: Icons.domain_rounded,
                      label: 'SPPG Indonesia',
                    ),
                  ),
                  const SizedBox(height: 12),
                  const FormLabel('Tanggal Kejadian'),
                  TextFormField(
                    readOnly: true,
                    initialValue: '1 Februari 2026',
                    decoration: appInputDecoration(
                      prefixIcon: const Icon(Icons.calendar_month_rounded),
                      suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const FormLabel('Jenis Masalah'),
                  TextFormField(
                    readOnly: true,
                    initialValue: 'Makanan Basi',
                    decoration: appInputDecoration(
                      prefixIcon: const Icon(Icons.list_alt_rounded),
                      suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const FormLabel('Deskripsi Masalah'),
                  TextFormField(
                    readOnly: true,
                    initialValue: 'Makanan sayur sop basi',
                    minLines: 4,
                    maxLines: 4,
                    decoration: appInputDecoration(),
                  ),
                  const SizedBox(height: 12),
                  const FormLabel('Bukti Foto'),
                  const UploadPlaceholder(height: 106, readOnly: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
