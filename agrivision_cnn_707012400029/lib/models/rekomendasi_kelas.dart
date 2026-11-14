
class RekomendasiKelas {
  static const Map<String, String> daftar = {
    'Normal / Sehat': 'Tanaman sehat. Lanjutkan pemantauan rutin.',
    'Hawar daun bakteri':
        'Kurangi pupuk urea, buang air berlebih, dan bersihkan jerami yang sakit.',
    'Penyakit blas (jamur)':
        'Jaga sawah tetap tergenang, semprot obat jamur saat padi keluar malai.',
    'Bercak coklat':
        'Tambah pupuk kalium, jaga sawah tetap tergenang.',
    'Penyakit tungro (virus)':
        'Cabut rumpun yang sakit, musim depan pakai varietas tahan.',
  };

  static const List<String> kelas = [
    'Normal / Sehat',
    'Hawar daun bakteri',
    'Penyakit blas (jamur)',
    'Bercak coklat',
    'Penyakit tungro (virus)',
  ];

  static String untukKelas(String kelas) => daftar[kelas] ?? 'Periksa kembali tanaman bersama petugas.';
}
