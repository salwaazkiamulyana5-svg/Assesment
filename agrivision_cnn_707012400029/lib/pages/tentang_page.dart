import 'package:flutter/material.dart';

class TentangPage extends StatelessWidget {
  const TentangPage({super.key});

  @override
  Widget build(BuildContext context) {
    final informasi = <Map<String, String>>[
      {'judul': 'Tujuan aplikasi', 'isi': 'Mencatat hasil pengamatan penyakit dan hama padi untuk kelompok tani.'},
      {'judul': 'Model', 'isi': 'EfficientNet-B0 disebut sebagai model yang digunakan dalam studi kasus. Proyek praktikum ini menggunakan simulasi pencatatan, bukan inferensi model nyata.'},
      {'judul': 'Kelas prediksi', 'isi': 'Normal / Sehat, Hawar daun bakteri, Penyakit blas (jamur), Bercak coklat, dan Penyakit tungro (virus).'},
      {'judul': 'Petak', 'isi': 'Data dapat dicatat untuk Petak 1 dan Petak 2.'},
      {'judul': 'Batasan praktikum', 'isi': 'Seluruh data disimpan sementara di memori aplikasi dan tidak menggunakan API atau koneksi internet.'},
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Tentang AgriVision CNN')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        const CircleAvatar(radius: 38, child: Icon(Icons.grass, size: 42)),
        const SizedBox(height: 12),
        Center(child: Text('AgriVision CNN', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold))),
        const Center(child: Text('Assesment • Kode A')),
        const SizedBox(height: 16),
        for (final item in informasi)
          Card(child: ListTile(title: Text(item['judul']!, style: const TextStyle(fontWeight: FontWeight.bold)), subtitle: Padding(padding: const EdgeInsets.only(top: 6), child: Text(item['isi']!)), leading: const Icon(Icons.eco_outlined))),
      ]),
    );
  }
}
