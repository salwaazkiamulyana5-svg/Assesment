import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.judul,
    required this.nilai,
    required this.ikon,
    required this.warna,
  });

  final String judul;
  final int nilai;
  final IconData ikon;
  final Color warna;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(ikon, color: warna, size: 25),
          const SizedBox(height: 12),
          Text('$nilai', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 3),
          Text(judul, style: Theme.of(context).textTheme.bodySmall),
        ]),
      ),
    );
  }
}
