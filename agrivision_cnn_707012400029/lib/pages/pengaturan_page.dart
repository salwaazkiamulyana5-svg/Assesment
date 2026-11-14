import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../state/theme_cubit.dart';
import '../state/deteksi_cubit.dart';
import '../state/deteksi_state.dart';

class PengaturanPage extends StatelessWidget {
  const PengaturanPage({super.key});

  Future<void> _konfirmasiHapusSemua(BuildContext context) async {
    final setuju = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hapus semua data?'),
        content: const Text('Seluruh riwayat deteksi akan dihapus dan tidak dapat dikembalikan.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: const Text('Batal')),
          FilledButton(onPressed: () => Navigator.pop(dialogContext, true), child: const Text('Ya, hapus semua')),
        ],
      ),
    );
    if (setuju == true && context.mounted) {
      context.read<DeteksiCubit>().hapusSemua();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Semua data berhasil dihapus')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, mode) {
        final gelap = mode == ThemeMode.dark;
        return BlocBuilder<DeteksiCubit, DeteksiState>(
          builder: (context, state) => ListView(padding: const EdgeInsets.all(16), children: [
            Text('Pengaturan', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Card(child: SwitchListTile(
              secondary: Icon(gelap ? Icons.dark_mode : Icons.light_mode, color: Theme.of(context).colorScheme.primary),
              title: const Text('Mode Gelap'),
              subtitle: Text(gelap ? 'Tema gelap sedang aktif' : 'Tema terang sedang aktif'),
              value: gelap,
              onChanged: (value) => context.read<ThemeCubit>().ubahTema(value),
            )),
            const SizedBox(height: 10),
            Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Data Simulasi', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              const Text('Muat 10 catatan contoh untuk menguji riwayat dan grafik. Data ini bukan hasil prediksi CNN nyata.'),
              const SizedBox(height: 12),
              SizedBox(width: double.infinity, child: FilledButton.icon(
                onPressed: () { context.read<DeteksiCubit>().buatDataSimulasi(); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('10 data simulasi dimuat'))); },
                icon: const Icon(Icons.auto_awesome), label: const Text('Muat Data Simulasi'),
              )),
              const SizedBox(height: 8),
              SizedBox(width: double.infinity, child: OutlinedButton.icon(
                onPressed: state.hasil.isEmpty ? null : () => _konfirmasiHapusSemua(context),
                icon: const Icon(Icons.delete_sweep_outlined), label: const Text('Hapus Semua Data'),
              )),
              const SizedBox(height: 4),
              Text('Jumlah data tersimpan: ${state.total}', style: Theme.of(context).textTheme.bodySmall),
            ]))),
            const SizedBox(height: 10),
            Card(child: ListTile(leading: const Icon(Icons.science_outlined), title: const Text('Model klasifikasi'), subtitle: const Text('EfficientNet-B0 (simulasi praktikum; belum terhubung ke file model)'))),
            Card(child: ListTile(leading: const Icon(Icons.storage_outlined), title: const Text('Penyimpanan data'), subtitle: const Text('Data disimpan sementara di memori aplikasi. Data hilang ketika aplikasi dimulai ulang.'))),
            Card(child: ListTile(leading: const Icon(Icons.code), title: const Text('Materi praktikum'), subtitle: const Text('Named routes, NavigationBar, IndexedStack, form, Cubit, Random, Map, fl_chart, dan ThemeData.'))),
          ]),
        );
      },
    );
  }
}
