
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../navigation/app_route.dart';
import '../state/deteksi_cubit.dart';
import '../state/deteksi_state.dart';
import '../widgets/deteksi_card.dart';
import '../widgets/stat_card.dart';

class DeteksiPage extends StatelessWidget {
  const DeteksiPage({super.key});

  Future<void> _konfirmasiHapus(
    BuildContext context,
    String id,
  ) async {
    final setuju = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hapus data deteksi?'),
        content: const Text(
          'Data yang dihapus tidak dapat dikembalikan.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (setuju == true && context.mounted) {
      context.read<DeteksiCubit>().hapus(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DeteksiCubit, DeteksiState>(
        builder: (context, state) {
          final hasil = state.hasilTerfilter;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(child: StatCard(judul: 'Total', nilai: state.total, ikon: Icons.analytics_outlined, warna: Theme.of(context).colorScheme.primary)),
                    const SizedBox(width: 8),
                    Expanded(child: StatCard(judul: 'Sehat', nilai: state.jumlahSehat, ikon: Icons.check_circle_outline, warna: Theme.of(context).colorScheme.tertiary)),
                    const SizedBox(width: 8),
                    Expanded(child: StatCard(judul: 'Perlu Tindakan', nilai: state.jumlahPerluTindakan, ikon: Icons.warning_amber, warna: Theme.of(context).colorScheme.error)),
                  ],
                ),
              ),

              const Divider(height: 1),

              const Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  'Riwayat Deteksi',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                  spacing: 8,
                  children: [
                    for (final petak in [
                      'Semua',
                      'Petak 1',
                      'Petak 2',
                    ])
                      ChoiceChip(
                        label: Text(petak),
                        selected: state.filterPetak == petak,
                        onSelected: (_) {
                          context
                              .read<DeteksiCubit>()
                              .pilihFilterPetak(petak);
                        },
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

             
              Expanded(
                child: hasil.isEmpty
                    ? const Center(
                        child: Text('Belum ada data hasil deteksi'),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(
                          12,
                          0,
                          12,
                          80,
                        ),
                        itemCount: hasil.length,
                        itemBuilder: (context, index) {
                          final data = hasil[index];

                          return DeteksiCard(
                            hasil: data,
                            onHapus: () => _konfirmasiHapus(
                              context,
                              data.id,
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),

    
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(
            context,
            AppRoutes.inputDeteksi,
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Deteksi Baru'),
      ),
    );
  }
}

