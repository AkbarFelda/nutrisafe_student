import 'package:flutter/material.dart';
import 'package:nutrisafe_student/core/utils/responsive.dart';
import 'package:nutrisafe_student/core/widgets/app_shell_widgets.dart';

class HelpView extends StatelessWidget {
  const HelpView({super.key, required this.role});

  final AppRole role;

  static const _faqs = <({String question, String answer})>[
    (
      question: 'Bagaimana cara melaporkan masalah makanan?',
      answer: 'Buka Beranda, pilih Pelaporan Makanan, lengkapi detail kejadian dan bukti foto, lalu tekan Kirim Laporan.',
    ),
    (
      question: 'Bagaimana cara melihat status laporan?',
      answer: 'Perkembangan laporan dapat dilihat melalui menu Notifikasi di bagian bawah aplikasi.',
    ),
    (
      question: 'Bagaimana cara memperbarui data profil?',
      answer: 'Buka Profil Saya, pilih Edit profile, ubah informasi yang diperlukan, lalu simpan perubahan.',
    ),
    (
      question: 'Apa yang dilakukan jika lupa password?',
      answer: 'Hubungi pusat bantuan melalui nomor kontak di bawah untuk proses verifikasi dan pemulihan akun.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return RoleScaffold(
      role: role,
      child: ListView(
        padding: EdgeInsets.fromLTRB(
          context.pagePadding,
          context.isShortPhone ? 10 : 20,
          context.pagePadding,
          28,
        ),
        children: [
          PageHeading(title: 'Bantuan', role: role),
          const SizedBox(height: 18),
          Text(
            'Pertanyaan yang Sering Diajukan',
            style: TextStyle(
              color: role.foreground(context),
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 12),
          Material(
            color: Theme.of(context).colorScheme.surfaceContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: _faqs
                  .map(
                    (faq) => ExpansionTile(
                      iconColor: role.primary,
                      collapsedIconColor: Theme.of(context)
                          .colorScheme
                          .onSurface,
                      title: Text(
                        faq.question,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            faq.answer,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                              fontSize: 12,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: role.primary.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: role.primary,
                  foregroundColor: Colors.white,
                  child: const Icon(Icons.phone_in_talk_outlined),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Pusat Bantuan NutriSafe',
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                      SizedBox(height: 3),
                      const Text(
                        '0800-123-6784',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        'Senin–Jumat, 08.00–17.00 WIB',
                        style: TextStyle(
                          fontSize: 11,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
