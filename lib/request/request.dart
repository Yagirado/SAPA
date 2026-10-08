import 'package:flutter/material.dart';
import 'package:sapa/theme/app_colors.dart';

// Data riwayat permintaan 
List<Map<String, String>> daftarPermintaan = [];

class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alasanController = TextEditingController();
  final TextEditingController _kontakController = TextEditingController();


  // update
  void _editPermintaan(int index) {
    _namaController.text = daftarPermintaan[index]['nama'] ?? '';
    _alasanController.text = daftarPermintaan[index]['alasan'] ?? '';
    _kontakController.text = daftarPermintaan[index]['kontak'] ?? '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text(
            'Ubah Permintaan',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nama Barang:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: _namaController,
                  decoration: const InputDecoration(border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Alasan Membutuhkan:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: _alasanController,
                  maxLines: 2,
                  decoration: const InputDecoration(border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Nomor WhatsApp:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: _kontakController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(border: OutlineInputBorder()),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.hijau,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  daftarPermintaan[index]['nama'] = _namaController.text;
                  daftarPermintaan[index]['alasan'] = _alasanController.text;
                  daftarPermintaan[index]['kontak'] = _kontakController.text;
                });

                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Permintaan berhasil diperbarui!'),
                    backgroundColor: AppColors.hijau,
                  ),
                );
              },
              child: const Text('Simpan Perubahan'),
            ),
          ],
        );
      },
    );
  }

  // delete
  void _hapusPermintaan(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text('Batalkan Permintaan?'),
          content: Text(
            'Apakah kamu yakin ingin membatalkan permintaan "${daftarPermintaan[index]['nama']}"?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tidak', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  daftarPermintaan.removeAt(index);
                });

                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Permintaan berhasil dibatalkan!'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              child: const Text('Ya, Batalkan'),
            ),
          ],
        );
      },
    );
  }

  // read
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.latar,
      appBar: AppBar(
        backgroundColor: AppColors.latar,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(
            'assets/icons/logo1.png',
            fit: BoxFit.contain,
          ),
        ),
        title: const Text(
          'Permintaan Saya',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: daftarPermintaan.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.inbox_outlined, size: 64, color: Colors.grey),
                  SizedBox(height: 12),
                  Text(
                    'Belum ada permintaan barang',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: daftarPermintaan.length,
              itemBuilder: (context, index) {
                final item = daftarPermintaan[index];
                final bool disetujui = item['status'] == 'Disetujui';

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item['nama'] ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: disetujui
                                  ? Colors.green.shade50
                                  : Colors.orange.shade50,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              item['status'] ?? 'Menunggu',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: disetujui
                                    ? AppColors.hijau
                                    : Colors.orange.shade800,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.help_outline, size: 15, color: Colors.grey),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              item['alasan'] ?? '',
                              style: const TextStyle(fontSize: 13, color: Colors.black87),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.phone, size: 15, color: Colors.grey),
                          const SizedBox(width: 6),
                          Text(
                            'WA: ${item['kontak'] ?? '-'}',
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                      const Divider(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            onPressed: () => _editPermintaan(index),
                            icon: const Icon(Icons.edit, size: 16, color: AppColors.hijau),
                            label: const Text(
                              'Ubah',
                              style: TextStyle(fontSize: 12, color: AppColors.hijau),
                            ),
                          ),
                          const SizedBox(width: 8),
                          TextButton.icon(
                            onPressed: () => _hapusPermintaan(index),
                            icon: const Icon(Icons.delete_outline, size: 16, color: Colors.red),
                            label: const Text(
                              'Batalkan',
                              style: TextStyle(fontSize: 12, color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}