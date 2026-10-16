part of 'report_views.dart';

class ReportFormView extends StatefulWidget {
  const ReportFormView({super.key, required this.role});

  final AppRole role;

  @override
  State<ReportFormView> createState() => _ReportFormViewState();
}

class _ReportFormViewState extends State<ReportFormView> {
  String? _issue;
  final _dateController = TextEditingController();
  final _picker = ImagePicker();
  Uint8List? _imageBytes;

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
    );
    if (selected == null) return;
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    _dateController.text =
        '${selected.day} ${months[selected.month - 1]} ${selected.year}';
  }

  Future<void> _pickImage(ImageSource source) async {
    final image = await _picker.pickImage(
      source: source,
      imageQuality: 82,
      maxWidth: 1600,
    );
    if (image == null) return;
    final bytes = await image.readAsBytes();
    if (!mounted) return;
    setState(() => _imageBytes = bytes);
  }

  void _showImageSource() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Pilih Sumber Foto',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 12),
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: const Text('Ambil dari Kamera'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: const Text('Pilih dari Galeri'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final role = widget.role;
    return RoleScaffold(
      role: role,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.pagePadding),
        child: Column(
          children: [
            SizedBox(height: context.isShortPhone ? 10 : 20),
            PageHeading(title: 'Pelaporan Makanan', role: role),
            const SizedBox(height: 7),
            const _ReportMeta(),
            SizedBox(height: context.isShortPhone ? 10 : 18),
            Text(
              'Formulir Pelaporan Masalah',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: role.foreground(context),
              ),
            ),
            Divider(color: role.foreground(context)),
            const SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FormLabel('Tanggal Kejadian'),
                    TextField(
                      controller: _dateController,
                      readOnly: true,
                      decoration: appInputDecoration(
                        hint: 'Masukkan Tanggal',
                        prefixIcon: const Icon(Icons.calendar_month_rounded),
                        suffixIcon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                        ),
                      ),
                      onTap: _selectDate,
                    ),
                    const SizedBox(height: 9),
                    const FormLabel('Jenis Masalah'),
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      initialValue: _issue,
                      decoration: appInputDecoration(
                        hint: 'Pilih Jenis Masalah',
                        prefixIcon: const Icon(Icons.list_alt_rounded),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'basi',
                          child: Text('Makanan Basi'),
                        ),
                        DropdownMenuItem(
                          value: 'rusak',
                          child: Text('Kemasan Rusak'),
                        ),
                        DropdownMenuItem(
                          value: 'kurang',
                          child: Text('Porsi Kurang'),
                        ),
                      ],
                      onChanged: (value) => setState(() => _issue = value),
                    ),
                    const SizedBox(height: 9),
                    const FormLabel('Deskripsi Masalah'),
                    TextField(
                      minLines: 4,
                      maxLines: 5,
                      decoration: appInputDecoration(
                        hint: 'Jelaskan Masalah......',
                      ),
                    ),
                    const SizedBox(height: 9),
                    const FormLabel('Upload Foto'),
                    UploadPlaceholder(
                      height: 150,
                      imageBytes: _imageBytes,
                      onTap: _showImageSource,
                    ),
                    const SizedBox(height: 28),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: PrimaryRoleButton(
                role: role,
                label: 'Kirim Laporan',
                onPressed: () => _showSuccess(role),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccess(AppRole role) {
    Get.dialog<void>(
      AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.fromLTRB(44, 38, 44, 40),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle_outline_rounded, size: 44),
            const SizedBox(height: 25),
            const Text(
              'Laporan Terkirim!',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () {
                Get.back();
                Get.offNamed(
                  role == AppRole.student
                      ? AppRoutes.studentNotifications
                      : AppRoutes.schoolNotifications,
                );
              },
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF00AD19),
                foregroundColor: Colors.white,
                minimumSize: const Size(190, 44),
              ),
              child: const Text(
                'OK',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
      ),
      barrierColor: Colors.black54,
    );
  }
}

class _ReportMeta extends StatelessWidget {
  const _ReportMeta();

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      alignment: WrapAlignment.end,
      spacing: 7,
      runSpacing: 5,
      children: [
        _MetaChip(icon: Icons.domain_rounded, label: 'SPPG Indonesia'),
        _MetaChip(
          icon: Icons.calendar_month_rounded,
          label: 'Rabu, 4 Februari 2026',
        ),
      ],
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: context.screenWidth - (context.pagePadding * 2),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer
              .withValues(alpha: .92),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 15),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
