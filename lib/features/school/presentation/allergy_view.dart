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
                    onPressed: () => showAppDialog(
                      title: 'Berhasil',
                      message: 'Data alergi berhasil disimpan.',
                      icon: Icons.check_circle_outline_rounded,
                      iconColor: AppRole.school.primary,
                    ),
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
                color: Theme.of(context).colorScheme.surfaceContainer,
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
                  Padding(
                    padding: const EdgeInsets.all(9),
                    child: Column(
                      children: DummyData.allergies
                          .map(
                            (allergy) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _AllergyCard(allergy: allergy),
                            ),
                          )
                          .toList(),
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
  const _AllergyCard({required this.allergy});

  final DummyAllergy allergy;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface,
          width: 1.7,
        ),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            allergy.studentName,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
          Text(
            'Kelas: ${allergy.studentClass}',
            style: const TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(Icons.circle, color: Colors.red, size: 9),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  'Alergi ${allergy.allergen}',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 3),
            child: Text(
              allergy.description,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
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
