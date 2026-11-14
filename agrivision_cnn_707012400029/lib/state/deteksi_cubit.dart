import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/hasil_deteksi.dart';
import '../models/rekomendasi_kelas.dart';
import 'deteksi_state.dart';

class DeteksiCubit extends Cubit<DeteksiState> {
  DeteksiCubit() : super(const DeteksiState(hasil: []));

  int _idBerikutnya = 1;

  void tambah(HasilDeteksi hasil) {
    emit(state.copyWith(hasil: [hasil, ...state.hasil]));
  }

  void hapus(String id) {
    emit(state.copyWith(hasil: state.hasil.where((item) => item.id != id).toList()));
  }

  void hapusSemua() {
    emit(state.copyWith(hasil: []));
  }

  void pilihFilterPetak(String petak) {
    emit(state.copyWith(filterPetak: petak));
  }


  void buatDataSimulasi() {
    final random = Random();
    final daftarKelas = RekomendasiKelas.kelas;
    final dataBaru = List.generate(10, (index) {
      final kelas = daftarKelas[random.nextInt(daftarKelas.length)];
      final skor = 30 + random.nextInt(70);
      final hariLalu = random.nextInt(14);
      final nomor = _idBerikutnya++;
      return HasilDeteksi(
        id: 'SIM-$nomor',
        petak: random.nextBool() ? 'Petak 1' : 'Petak 2',
        kelas: kelas,
        skor: skor,
        namaPetugas: 'Petugas Simulasi',
        waktu: DateTime.now().subtract(Duration(days: hariLalu)),
      );
    });
    emit(state.copyWith(hasil: [...dataBaru, ...state.hasil]));
  }
}
