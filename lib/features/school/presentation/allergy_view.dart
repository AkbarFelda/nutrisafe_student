part of 'school_operation_views.dart';

class AllergyView extends StatelessWidget {
  const AllergyView({super.key});

  @override
  Widget build(BuildContext context) {
    return RoleScaffold(
      role: AppRole.school,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: context.pagePadding,
          vertical: context.isShortPhone ? 10 : 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PageHeading(
              title: 'Input Data Alergi Siswa',
              role: AppRole.school,
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Formulir Alergi Siswa',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
            const Divider(color: AppColors.schoolDark),
            const SizedBox(height: 12),
            const FormLabel('Nama Siswa'),
            TextField(decoration: appInputDecoration()),
            const SizedBox(height: 9),
            const FormLabel('Kelas'),
            SizedBox(
              width: 170,
              child: TextField(decoration: appInputDecoration()),
            ),
            const SizedBox(height: 9),
            const FormLabel('Jenis Alergi'),
            TextField(
              decoration: appInputDecoration(hint: 'Contoh: Alergi kacang'),
            ),
            const SizedBox(height: 9),
            const FormLabel('Deskripsi Alergi'),
            TextField(
              decoration: appInputDecoration(
                hint: 'Contoh: Gatal-gatal saat mengkonsumsi kacang',
              ),
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                Expanded(
                  child: PrimaryRoleButton(
                    role: AppRole.school,
                    label: 'Simpan',
                    onPressed: () =>
                        Get.snackbar('Berhasil', 'Data alergi disimpan'),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: FilledButton(
                    onPressed: Get.back,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.studentPrimary,
                    ),
                    child: const Text('Batal'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 42),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: const BoxDecoration(
                      color: Color(0xFFD3D3D3),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(9),
                      ),
                    ),
                    child: const Text(
                      'Daftar Alergi Siswa SDN 1 Subang',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(9),
                    child: Column(
                      children: [
                        _AllergyCard(),
                        SizedBox(height: 12),
                        _AllergyCard(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AllergyCard extends StatelessWidget {
  const _AllergyCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1.7),
        borderRadius: BorderRadius.circular(9),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Icha Aulia Ambarwati',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          Text('Kelas: 6A', style: TextStyle(fontSize: 12)),
          SizedBox(height: 5),
          Row(
            children: [
              Icon(Icons.circle, color: Colors.red, size: 9),
              SizedBox(width: 7),
              Expanded(
                child: Text('Alergi Kacang', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, top: 3),
            child: Text(
              'Gatal-gatal saat mengkonsumsi kacang',
              style: TextStyle(
                color: Colors.black38,
                fontSize: 11,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
