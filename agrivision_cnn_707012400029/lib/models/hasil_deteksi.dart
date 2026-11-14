import 'rekomendasi_kelas.dart';
class HasilDeteksi {
  const HasilDeteksi({
    required this.id,
    required this.petak,
    required this.kelas,
    required this.skor,
    required this.namaPetugas,
    required this.waktu,
  });

  final String id;
  final String petak;
  final String kelas;
  final int skor;
  final String namaPetugas;
  final DateTime waktu;

  bool get isSehat => kelas == 'Normal / Sehat';
  bool get perluTindakan => !isSehat && skor >= 50;
  bool get tidakPasti => !isSehat && skor < 50;

  String get status {
    if (isSehat) return 'Sehat';
    if (skor < 50) return 'Tidak Pasti';
    return 'Perlu Tindakan';
  }

  String get rekomendasi {
    if (isSehat) return 'Lanjutkan pemantauan rutin.';
    if (tidakPasti) return 'Cek ulang oleh petugas.';
    return RekomendasiKelas.untukKelas(kelas);
  }
}
