import 'package:flutter/material.dart';
import 'package:sapa/theme/app_colors.dart';

class DetailPage extends StatelessWidget {
  final String gambar;
  final String judul;
  final String lokasi;
  final String jarak;
  final String kondisi;
  final String cerita;
  final String donatur;

  const DetailPage({
    super.key,
    required this.gambar,
    required this.judul,
    required this.lokasi,
    required this.jarak,
    required this.kondisi,
    required this.cerita,
    required this.donatur,
  });

  void _tampilkanFormMinta(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(
            'Minta $judul',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Alasan Membutuhkan:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                SizedBox(height: 6),
                TextField(
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: 'Contoh: Butuh untuk masak di kosan...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.hijau,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Permintaan berhasil diajukan!'),
                    backgroundColor: AppColors.hijau,
                  ),
                );
              },
              child: const Text('Kirim Permintaan'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.latar,
      appBar: AppBar(
        backgroundColor: AppColors.latar,
        elevation: 0,
        title: const Text(
          'Detail Barang',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                gambar,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            Text(
              judul,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                kondisi,
                style: const TextStyle(fontSize: 11, color: AppColors.hijau, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                const Icon(Icons.location_on, size: 18, color: AppColors.hijau),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    '$lokasi • $jarak',
                    style: const TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            const Text(
              'Cerita Barang',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              cerita,
              style: const TextStyle(fontSize: 13, height: 1.5),
            ),
            const SizedBox(height: 16),

            const Text(
              'Donatur',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.person, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Text(donatur, style: const TextStyle(fontSize: 13)),
              ],
            ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.hijau,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () => _tampilkanFormMinta(context),
            child: const Text('Saya Membutuhkan Ini'),
          ),
        ),
      ),
    );
  }
}