import 'package:flutter/material.dart';
import 'package:sapa/item/item.dart';
import 'package:sapa/theme/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget _buatKategori(IconData ikon, String nama) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.latarInput,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(ikon, color: AppColors.hijau, size: 26),
          ),
          const SizedBox(height: 6),
          Text(nama, style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }

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
          'Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ClipOval(
              child: Image.asset(
                'assets/images/fahri.png',
                width: 36,
                height: 36,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hi, Albert🖐',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
            ),
            const Text(
              'Siap berbagi? Cek barang di sekitar kosanmu hari ini.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            const Text(
              'Kategori Perlengkapan',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buatKategori(Icons.chair_outlined, 'Perlengkapan'),
                  _buatKategori(Icons.soup_kitchen_outlined, 'Peralatan'),
                  _buatKategori(Icons.devices_other_outlined, 'Elektronik'),
                  _buatKategori(Icons.bed_outlined, 'Furniture'),
                  _buatKategori(Icons.edit_note_outlined, 'Alat Tulis'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Daftar barang
            const Text(
              'Barang Terbaru',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Rice Cooker
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/images/magicom.jpeg',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Rice Cooker Mini',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: const [
                                Icon(Icons.location_on, size: 14, color: Colors.grey),
                                SizedBox(width: 4),
                                Text('Adiarsa Barat', style: TextStyle(fontSize: 12, color: Colors.grey)),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: const [
                                Icon(Icons.person, size: 14, color: Colors.grey),
                                SizedBox(width: 4),
                                Text('Andi Pratama', style: TextStyle(fontSize: 12, color: Colors.grey)),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'Layak Pakai',
                                style: TextStyle(fontSize: 11, color: AppColors.hijau, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.hijau,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DetailPage(
                              gambar: 'assets/images/magicom.jpeg',
                              judul: 'Rice Cooker Mini',
                              lokasi: 'Adiarsa Barat',
                              jarak: '0,5 km dari Kampus UNSIKA',
                              kondisi: 'Layak Pakai',
                              cerita: 'Rice cooker masih berfungsi sangat baik untuk masak nasi dan mengukus. Dipakai sekitar 1 tahun. Mau dihibahkan ke adik tingkat yang membutuhkan.',
                              donatur: 'Andi Pratama',
                            ),
                          ),
                        );
                      },
                      child: const Text('Lihat Detail'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Kasur
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/images/kasur.jpg',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Kasur Busa Single',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: const [
                                Icon(Icons.location_on, size: 14, color: Colors.grey),
                                SizedBox(width: 4),
                                Text('Mahkota', style: TextStyle(fontSize: 12, color: Colors.grey)),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: const [
                                Icon(Icons.person, size: 14, color: Colors.grey),
                                SizedBox(width: 4),
                                Text('Nando', style: TextStyle(fontSize: 12, color: Colors.grey)),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'Bersih & Empuk',
                                style: TextStyle(fontSize: 11, color: AppColors.hijau, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.hijau,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DetailPage(
                              gambar: 'assets/images/kasur.jpg',
                              judul: 'Kasur Busa Single',
                              lokasi: 'Mahkota',
                              jarak: '2,0 km dari lokasimu',
                              kondisi: 'Bersih & Empuk',
                              cerita: 'Kasur busa ukuran single. Masih bersih dan tidak kempes. Sudah termasuk sprei jika mau.',
                              donatur: 'Nando',
                            ),
                          ),
                        );
                      },
                      child: const Text('Lihat Detail'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}