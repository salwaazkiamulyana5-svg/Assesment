import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final Color warna;
    final IconData ikon;
    switch (status) {
      case 'Sehat':
        warna = scheme.tertiary;
        ikon = Icons.check_circle;
        break;
      case 'Tidak Pasti':
        warna = scheme.secondary;
        ikon = Icons.help;
        break;
      default:
        warna = scheme.error;
        ikon = Icons.warning_amber_rounded;
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: warna.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(ikon, size: 15, color: warna),
        const SizedBox(width: 5),
        Text(status, style: TextStyle(color: warna, fontWeight: FontWeight.w700, fontSize: 12)),
      ]),
    );
  }
}
