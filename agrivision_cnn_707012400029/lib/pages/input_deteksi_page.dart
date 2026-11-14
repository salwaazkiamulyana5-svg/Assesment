import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/hasil_deteksi.dart';
import '../models/rekomendasi_kelas.dart';
import '../state/deteksi_cubit.dart';
import '../widgets/status_badge.dart';


class InputDeteksiPage extends StatefulWidget {
  const InputDeteksiPage({super.key});

  @override
  State<InputDeteksiPage> createState() => _InputDeteksiPageState();
}

class _InputDeteksiPageState extends State<InputDeteksiPage> {
  final _formKey = GlobalKey<FormState>();
  final _skorController = TextEditingController();
  final _petugasController = TextEditingController();
  String _petak = 'Petak 1';
  String? _kelas;
  bool _dataBenar = false;
  bool _sedangSimpan = false;

  @override
  void dispose() {
    _skorController.dispose();
    _petugasController.dispose();
    super.dispose();
  }

  String? _validasiSkor(String? nilai) {
    if (nilai == null || nilai.trim().isEmpty) return 'Skor deteksi wajib diisi.';
    final angka = int.tryParse(nilai.trim());
    if (angka == null) return 'Skor harus berupa angka bulat.';
    if (angka < 0 || angka > 100) return 'Skor harus berada pada rentang 0–100.';
    return null;
  }

  Future<void> _simpan() async {
    if (!_formKey.currentState!.validate()) return;
    if (_kelas == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pilih kelas deteksi terlebih dahulu.')));
      return;
    }
    if (!_dataBenar) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Centang konfirmasi bahwa data sudah benar.')));
      return;
    }
    final konfirmasi = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Konfirmasi penyimpanan'),
        content: Text('Simpan hasil deteksi untuk $_petak dengan kelas $_kelas dan skor ${_skorController.text}%?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: const Text('Periksa lagi')),
          FilledButton(onPressed: () => Navigator.pop(dialogContext, true), child: const Text('Ya, simpan')),
        ],
      ),
    );
    if (konfirmasi != true || !mounted) return;

    setState(() => _sedangSimpan = true);
    final skor = int.parse(_skorController.text.trim());
    final hasil = HasilDeteksi(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      petak: _petak,
      kelas: _kelas!,
      skor: skor,
      namaPetugas: _petugasController.text.trim(),
      waktu: DateTime.now(),
    );
    context.read<DeteksiCubit>().tambah(hasil);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Data tersimpan')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final previewSkor = int.tryParse(_skorController.text) ?? 0;
    final HasilDeteksi? preview = _kelas == null ? null : HasilDeteksi(
      id: 'preview', petak: _petak, kelas: _kelas!, skor: previewSkor,
      namaPetugas: _petugasController.text, waktu: DateTime.now(),
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Input Hasil Deteksi')),
      body: Form(
        key: _formKey,
        child: ListView(padding: const EdgeInsets.all(16), children: [
          Text('Form pemeriksaan padi', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text('Isi hasil pengamatan. Ini merupakan pencatatan simulasi, bukan hasil inferensi EfficientNet-B0.'),
          const SizedBox(height: 18),
          Card(child: Padding(padding: const EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Petak sawah', style: Theme.of(context).textTheme.titleMedium),
            RadioListTile<String>(title: const Text('Petak 1'), value: 'Petak 1', groupValue: _petak, onChanged: (value) => setState(() => _petak = value!)),
            RadioListTile<String>(title: const Text('Petak 2'), value: 'Petak 2', groupValue: _petak, onChanged: (value) => setState(() => _petak = value!)),
          ]))),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _kelas,
            decoration: const InputDecoration(labelText: 'Kelas prediksi', border: OutlineInputBorder(), prefixIcon: Icon(Icons.category_outlined)),
            items: RekomendasiKelas.kelas.map((kelas) => DropdownMenuItem(value: kelas, child: Text(kelas, overflow: TextOverflow.ellipsis))).toList(),
            onChanged: (value) => setState(() => _kelas = value),
            validator: (value) => value == null ? 'Pilih salah satu kelas deteksi.' : null,
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: _skorController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Skor deteksi (%)', hintText: 'Masukkan angka 0–100', border: OutlineInputBorder(), prefixIcon: Icon(Icons.percent)),
            validator: _validasiSkor,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: _petugasController,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(labelText: 'Nama petugas', border: OutlineInputBorder(), prefixIcon: Icon(Icons.person_outline)),
            validator: (value) => value == null || value.trim().isEmpty ? 'Nama petugas tidak boleh kosong.' : null,
          ),
          const SizedBox(height: 8),
          CheckboxListTile(
            value: _dataBenar,
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            title: const Text('Data sudah benar'),
            subtitle: const Text('Centang untuk mengaktifkan tombol Simpan.'),
            onChanged: (value) => setState(() => _dataBenar = value ?? false),
          ),
          if (_kelas != null) ...[
            Card(child: Padding(padding: const EdgeInsets.all(14), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Pratinjau status', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              if (preview != null) StatusBadge(status: preview.status),
              const SizedBox(height: 8),
              Text('Rekomendasi: ${preview!.rekomendasi}'),
              const SizedBox(height: 8),
              LinearProgressIndicator(value: previewSkor.clamp(0, 100) / 100, minHeight: 8, borderRadius: BorderRadius.circular(8)),
              Align(alignment: Alignment.centerRight, child: Text('$previewSkor%')),
            ]))),
          ],
          const SizedBox(height: 14),
          FilledButton.icon(
            onPressed: _dataBenar && !_sedangSimpan ? _simpan : null,
            icon: const Icon(Icons.save_outlined),
            label: const Text('Simpan Hasil Deteksi'),
          ),
          const SizedBox(height: 8),
          Text('Status: Normal/Sehat = Sehat; kelas penyakit dengan skor di bawah 50% = Tidak Pasti; skor 50% atau lebih = Perlu Tindakan.', style: Theme.of(context).textTheme.bodySmall),
        ]),
      ),
    );
  }
}
