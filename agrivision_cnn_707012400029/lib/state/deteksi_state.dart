import '../models/hasil_deteksi.dart';

class DeteksiState {
  const DeteksiState({required this.hasil, this.filterPetak = 'Semua'});

  final List<HasilDeteksi> hasil;
  final String filterPetak;

  List<HasilDeteksi> get hasilTerfilter {
    if (filterPetak == 'Semua') return hasil;
    return hasil.where((item) => item.petak == filterPetak).toList();
  }

  int get total => hasil.length;
  int get jumlahSehat => hasil.where((item) => item.isSehat).length;
  int get jumlahPerluTindakan => hasil.where((item) => item.perluTindakan).length;

  DeteksiState copyWith({List<HasilDeteksi>? hasil, String? filterPetak}) {
    return DeteksiState(
      hasil: hasil ?? this.hasil,
      filterPetak: filterPetak ?? this.filterPetak,
    );
  }
}
