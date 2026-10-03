part of 'school_operation_views.dart';

class FoodReceiptView extends StatelessWidget {
  const FoodReceiptView({super.key, this.completed = false});

  final bool completed;

  @override
  Widget build(BuildContext context) {
    return RoleScaffold(
      role: AppRole.school,
      child: ResponsiveScrollableBody(
        padding: EdgeInsets.symmetric(horizontal: context.pagePadding),
        child: Column(
          children: [
            SizedBox(height: context.isShortPhone ? 10 : 20),
            const PageHeading(
              title: 'Penerimaan Makanan',
              role: AppRole.school,
            ),
            const SizedBox(height: 8),
            const Align(alignment: Alignment.centerRight, child: _DateChip()),
            const SizedBox(height: 18),
            Text(
              completed
                  ? 'Makanan Telah Diterima!'
                  : 'Konfirmasi Kedatangan Makanan',
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
            const Divider(color: AppColors.schoolDark),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FormLabel('SPPG Pemasok'),
                  TextFormField(
                    readOnly: true,
                    initialValue: 'SPPG Indonesia',
                    decoration: appInputDecoration(),
                  ),
                  const SizedBox(height: 14),
                  const FormLabel('Jumlah Porsi yang Diterima'),
                  TextFormField(
                    readOnly: completed,
                    initialValue: completed ? '196' : null,
                    keyboardType: TextInputType.number,
                    decoration: appInputDecoration(),
                  ),
                  const SizedBox(height: 14),
                  const FormLabel('Upload Foto'),
                  UploadPlaceholder(height: 110, readOnly: completed),
                ],
              ),
            ),
            const Spacer(),
            if (!completed)
              Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: PrimaryRoleButton(
                  role: AppRole.school,
                  label: 'Konfirmasi Makanan Diterima',
                  onPressed: () => Get.offNamed(AppRoutes.foodReceived),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _DateChip extends StatelessWidget {
  const _DateChip();

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: context.screenWidth - (context.pagePadding * 2),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.calendar_month_rounded, size: 15),
            SizedBox(width: 4),
            Flexible(
              child: Text(
                'Rabu, 4 Februari 2026',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
