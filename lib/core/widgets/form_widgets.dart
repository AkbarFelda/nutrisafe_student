import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutrisafe_student/core/constants/app_colors.dart';
import 'package:nutrisafe_student/core/widgets/app_role.dart';

class FormLabel extends StatelessWidget {
  const FormLabel(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.w700)),
  );
}

InputDecoration appInputDecoration({
  String? hint,
  Widget? prefixIcon,
  Widget? suffixIcon,
}) {
  return InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(color: Color(0xFFBBBBBB), fontSize: 13),
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    filled: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: AppColors.border),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Color(0xFF777777), width: 1.4),
    ),
  );
}

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    this.controller,
    this.hint,
    this.textInputAction,
  });

  final TextEditingController? controller;
  final String? hint;
  final TextInputAction? textInputAction;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscureText,
      enableSuggestions: false,
      autocorrect: false,
      textInputAction: widget.textInputAction,
      decoration: appInputDecoration(
        hint: widget.hint,
        prefixIcon: const Icon(Icons.lock_outline_rounded),
        suffixIcon: IconButton(
          tooltip: _obscureText ? 'Tampilkan password' : 'Sembunyikan password',
          onPressed: () => setState(() => _obscureText = !_obscureText),
          icon: Icon(
            _obscureText
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
          ),
        ),
      ),
    );
  }
}

class UploadPlaceholder extends StatelessWidget {
  const UploadPlaceholder({
    super.key,
    this.height = 108,
    this.readOnly = false,
    this.imageAsset,
    this.imageBytes,
    this.onTap,
  });

  final double height;
  final bool readOnly;
  final String? imageAsset;
  final Uint8List? imageBytes;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final content = imageBytes != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(13),
            child: Image.memory(
              imageBytes!,
              width: double.infinity,
              height: height,
              fit: BoxFit.cover,
              semanticLabel: 'Foto laporan yang dipilih',
            ),
          )
        : imageAsset != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(13),
            child: Image.asset(
              imageAsset!,
              width: double.infinity,
              height: height,
              fit: BoxFit.cover,
              semanticLabel: 'Bukti foto makanan bermasalah',
              errorBuilder: (_, _, _) =>
                  const Center(child: Icon(Icons.broken_image_outlined)),
            ),
          )
        : Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!readOnly)
                  const Icon(
                    Icons.upload_rounded,
                    color: AppColors.muted,
                    size: 36,
                  ),
                Text(
                  readOnly ? 'Foto Makanan' : 'PNG, JPG, JPEG',
                  style: const TextStyle(color: AppColors.muted),
                ),
              ],
            ),
          );
    return Material(
      color: readOnly
          ? Colors.transparent
          : Theme.of(context).inputDecorationTheme.fillColor,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF888888)),
            borderRadius: BorderRadius.circular(14),
          ),
          child: content,
        ),
      ),
    );
  }
}

class ImagePickerField extends StatefulWidget {
  const ImagePickerField({super.key, this.height = 150, this.onChanged});

  final double height;
  final ValueChanged<XFile>? onChanged;

  @override
  State<ImagePickerField> createState() => _ImagePickerFieldState();
}

class _ImagePickerFieldState extends State<ImagePickerField> {
  final ImagePicker _picker = ImagePicker();
  Uint8List? _imageBytes;

  Future<void> _pickImage(ImageSource source) async {
    Navigator.of(context).pop();
    final image = await _picker.pickImage(
      source: source,
      imageQuality: 85,
      maxWidth: 1600,
    );
    if (image == null || !mounted) return;

    final bytes = await image.readAsBytes();
    if (!mounted) return;
    setState(() => _imageBytes = bytes);
    widget.onChanged?.call(image);
  }

  Future<void> _showImageSource() async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('Kamera'),
              onTap: () => _pickImage(ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Galeri'),
              onTap: () => _pickImage(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return UploadPlaceholder(
      height: widget.height,
      imageBytes: _imageBytes,
      onTap: _showImageSource,
    );
  }
}

class PrimaryRoleButton extends StatelessWidget {
  const PrimaryRoleButton({
    super.key,
    required this.role,
    required this.label,
    required this.onPressed,
  });

  final AppRole role;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: role.primary,
        foregroundColor: Colors.white,
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
      ),
    );
  }
}
