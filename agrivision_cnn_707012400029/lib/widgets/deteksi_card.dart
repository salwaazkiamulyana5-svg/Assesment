import 'package:flutter/material.dart';
import '../models/hasil_deteksi.dart';
import 'status_badge.dart';

class DeteksiCard extends StatelessWidget {
  const DeteksiCard({super.key, required this.hasil, required this.onHapus});
  final HasilDeteksi hasil;
  final VoidCallback onHapus;

  @override
  Widget build(BuildContext context) {
    final formatWaktu = '${hasil.waktu.day.toString().padLeft(2, '0')}/${hasil.waktu.month.toString().padLeft(2, '0')}/${hasil.waktu.year}';
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Icon(Icons.grass, color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
            const SizedBox(width: 10),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(hasil.kelas, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              Text('${hasil.petak} • $formatWaktu', style: Theme.of(context).textTheme.bodySmall),
            ])),
            IconButton(tooltip: 'Hapus hasil', onPressed: onHapus, icon: const Icon(Icons.delete_outline)),
          ]),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: Text('Skor deteksi', style: Theme.of(context).textTheme.bodyMedium)),
            Text('${hasil.skor}%', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(width: 10),
            StatusBadge(status: hasil.status),
          ]),
          const SizedBox(height: 7),
          LinearProgressIndicator(value: hasil.skor / 100, minHeight: 7, borderRadius: BorderRadius.circular(10)),
          const SizedBox(height: 10),
          Text('Petugas: ${hasil.namaPetugas}', style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 8),
          Text('Rekomendasi: ${hasil.rekomendasi}', style: Theme.of(context).textTheme.bodyMedium),
        ]),
      ),
    );
  }
}
