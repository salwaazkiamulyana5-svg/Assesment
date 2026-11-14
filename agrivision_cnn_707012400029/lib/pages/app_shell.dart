import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../state/deteksi_cubit.dart';
import '../state/deteksi_state.dart';
import '../navigation/app_route.dart';
import '../pages/beranda_page.dart';
import '../pages/deteksi_page.dart';
import '../pages/statistik_page.dart';
import '../pages/pengaturan_page.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _indeksTab = 0;

  final List<Widget> _halaman = const [
    BerandaPage(),
    DeteksiPage(),
    StatistikPage(),
    PengaturanPage(),
  ];

  final List<String> _judul = const ['Beranda', 'Deteksi', 'Statistik', 'Pengaturan'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
          const Text('AgriVision', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(_judul[_indeksTab], style: Theme.of(context).textTheme.labelSmall),
        ]),
        actions: [
          IconButton(
            tooltip: 'Tentang aplikasi',
            onPressed: () => Navigator.pushNamed(context, AppRoutes.tentang),
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
      body: IndexedStack(index: _indeksTab, children: _halaman),
      bottomNavigationBar: BlocBuilder<DeteksiCubit, DeteksiState>(
        builder: (context, state) => NavigationBar(
          selectedIndex: _indeksTab,
          onDestinationSelected: (index) => setState(() => _indeksTab = index),
          destinations: [
            const NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Beranda'),
            NavigationDestination(
              icon: Badge(label: Text('${state.jumlahPerluTindakan}'), child: const Icon(Icons.fact_check_outlined)),
              selectedIcon: Badge(label: Text('${state.jumlahPerluTindakan}'), child: const Icon(Icons.fact_check)),
              label: 'Deteksi',
            ),
            const NavigationDestination(icon: Icon(Icons.bar_chart_outlined), selectedIcon: Icon(Icons.bar_chart), label: 'Statistik'),
            const NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: 'Pengaturan'),
          ],
        ),
      ),
    );
  }
}
