import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/rekomendasi_kelas.dart';
import '../state/deteksi_cubit.dart';
import '../state/deteksi_state.dart';
import '../widgets/stat_card.dart';

class StatistikPage extends StatelessWidget {
  const StatistikPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeteksiCubit, DeteksiState>(
      builder: (context, state) {
        final Map<String, int> jumlahPerKelas = {
          for (final kelas in RekomendasiKelas.kelas) kelas: 0,
        };

        for (final hasil in state.hasil) {
          jumlahPerKelas[hasil.kelas] = (jumlahPerKelas[hasil.kelas] ?? 0) + 1;
        }

        final int nilaiTertinggi = jumlahPerKelas.values.fold<int>(
          0,
          (maks, nilai) => nilai > maks ? nilai : maks,
        );

        final double maxY = nilaiTertinggi == 0
            ? 1
            : (nilaiTertinggi + 1).toDouble();

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Statistik Deteksi',
              style: Theme.of(context).textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'Grafik dihitung dari data deteksi yang tersimpan di aplikasi.',
            ),
            const SizedBox(height: 12),

            
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    judul: 'Total',
                    nilai: state.total,
                    ikon: Icons.analytics_outlined,
                    warna: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Expanded(
                  child: StatCard(
                    judul: 'Sehat',
                    nilai: state.jumlahSehat,
                    ikon: Icons.check_circle_outline,
                    warna: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                Expanded(
                  child: StatCard(
                    judul: 'Perlu Tindakan',
                    nilai: state.jumlahPerluTindakan,
                    ikon: Icons.warning_amber,
                    warna: Theme.of(context).colorScheme.error,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jumlah Deteksi per Kelas',
                      style: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      height: 290,
                      child: BarChart(
                        BarChartData(
                          maxY: maxY,
                          minY: 0,
                          alignment: BarChartAlignment.spaceAround,
                          barGroups: List.generate(
                            RekomendasiKelas.kelas.length,
                            (index) {
                              final String kelas =
                                  RekomendasiKelas.kelas[index];

                              final double jumlah = (jumlahPerKelas[kelas] ?? 0)
                                  .toDouble();

                              final Color warna = index == 0
                                  ? Colors.green
                                  : Colors.orange;

                              return BarChartGroupData(
                                x: index,
                                barRods: [
                                  BarChartRodData(
                                    toY: jumlah,
                                    color: warna,
                                    width: 24,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ],
                              );
                            },
                          ),
                          gridData: const FlGridData(show: true),
                          borderData: FlBorderData(show: false),
                          barTouchData: BarTouchData(enabled: true),
                          titlesData: FlTitlesData(
                            topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            leftTitles: const AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 30,
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 72,
                                getTitlesWidget: (value, meta) {
                                  final int index = value.toInt();

                                  if (index < 0 ||
                                      index >= RekomendasiKelas.kelas.length) {
                                    return const SizedBox.shrink();
                                  }

                                  final String label = switch (index) {
                                    0 => 'Sehat',
                                    1 => 'Hawar\ndaun',
                                    2 => 'Blas',
                                    3 => 'Bercak\ncoklat',
                                    4 => 'Tungro',
                                    _ => 'Lainnya',
                                  };

                                  return SideTitleWidget(
                                    meta: meta,
                                    child: Text(
                                      label,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Jumlah data: ${state.total}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

          ],
        );
      },
    );
  }
}
