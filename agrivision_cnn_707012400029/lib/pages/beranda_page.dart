import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../navigation/app_route.dart';
import '../state/deteksi_cubit.dart';
import '../state/deteksi_state.dart';

class BerandaPage extends StatelessWidget {
  const BerandaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeteksiCubit, DeteksiState>(
      builder: (context, state) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Selamat Datang di AgriVision CNN',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            const Text(
              'Aplikasi pencatatan hasil deteksi penyakit '
              'dan hama padi untuk kelompok tani.',
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Informasi Model', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const ListTile(contentPadding: EdgeInsets.zero, leading: Icon(Icons.memory), title: Text('EfficientNet-B0'), subtitle: Text('Model pada studi kasus praktikum')),
                  const ListTile(contentPadding: EdgeInsets.zero, leading: Icon(Icons.category_outlined), title: Text('5 kelas deteksi'), subtitle: Text('Normal / Sehat dan empat kelas penyakit padi')),
                ]),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Ringkasan Pencatatan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                SizedBox(width: 90, child: _Ringkasan(judul: 'Total', jumlah: state.total)),
                SizedBox(width: 90, child: _Ringkasan(judul: 'Sehat', jumlah: state.jumlahSehat)),
                SizedBox(width: 110, child: _Ringkasan(judul: 'Perlu Tindakan', jumlah: state.jumlahPerluTindakan)),
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              'Mulai Pemeriksaan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            const Text(
              'Masukkan hasil pengamatan petak sawah melalui '
              'formulir deteksi. Data yang digunakan merupakan '
              'simulasi praktikum, bukan prediksi CNN sebenarnya.',
            ),
            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.inputDeteksi);
              },
              child: const Text('Input Hasil Deteksi'),
            ),

            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.tentang);
              },
              child: const Text('Tentang Aplikasi'),
            ),
          ],
        );
      },
    );
  }
}

class _Ringkasan extends StatelessWidget {
  const _Ringkasan({required this.judul, required this.jumlah});

  final String judul;
  final int jumlah;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$jumlah',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(judul, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
