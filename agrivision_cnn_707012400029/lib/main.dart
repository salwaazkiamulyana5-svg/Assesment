import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'navigation/app_route.dart';
import 'pages/app_shell.dart';
import 'pages/input_deteksi_page.dart';
import 'pages/tentang_page.dart';
import 'state/deteksi_cubit.dart';
import 'state/theme_cubit.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const AgriVisionApp());
}

class AgriVisionApp extends StatelessWidget {
  const AgriVisionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => DeteksiCubit()),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'AgriVision CNN',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
          initialRoute: AppRoutes.beranda,
          routes: {
            AppRoutes.beranda: (_) => const AppShell(),
            AppRoutes.tentang: (_) => const TentangPage(),
            AppRoutes.inputDeteksi: (_) => const InputDeteksiPage(),
          },
        ),
      ),
    );
  }
}
