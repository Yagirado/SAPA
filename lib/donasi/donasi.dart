import 'package:flutter/material.dart';
import 'package:sapa/theme/app_colors.dart';

class DonasiPage extends StatefulWidget {
  final VoidCallback onBack;
  const DonasiPage({super.key, required this.onBack});

  @override
  State<DonasiPage> createState() => _DonasiPageState();
}

class _DonasiPageState extends State<DonasiPage> {
  TextEditingController namaController = TextEditingController(
    text: 'Rice Cooker Mini 0.8L Maspion',
  );
  TextEditingController catatanController = TextEditingController(
    text: 'Barang dibungkus dengan kardus',
  );

  int kategoriDipilih = 0;
  int kondisiDipilih = 1;

  bool sore = true;
  bool akhirPekan = true;
  bool hariIni = false;
  bool titipPos = false;
  bool setuju = true;
  bool gambarBarang = true;

  List<String> kategori = ['Perlengkapan', 'Peralatan', 'Elektronik', 'Furniture', 'Alat Tulis'];

  void tampilNotif(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(pesan)));
  }

  void konfirmasiHapus() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus foto?'),
          content: const Text('Foto ini akan dihapus dari donasi kamu.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  gambarBarang = false;
                });
                Navigator.pop(context);
              },
              child: const Text('Hapus', style: TextStyle(color: Colors.red)),
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: widget.onBack,
        ),
        title: const Text(
          'Hibahkan Barang',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== FOTO =====
            Row(
              children: [
                const Icon(Icons.camera_alt_outlined),
                const SizedBox(width: 8),
                const Text(
                  'Foto Barang Donasi',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.hijauTerang,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Min. 1 Foto Jelas',
                    style: TextStyle(color: AppColors.hijau, fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            OutlinedButton.icon(
              onPressed: () {
                tampilNotif('Tambah foto detail');
              },
              icon: const Icon(Icons.add, color: AppColors.hijau),
              label: const Text(
                'Tambah Foto',
                style: TextStyle(color: AppColors.hijau),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.hijau),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 10),

            SizedBox(
              height: 150,
              child: Row(
                children: [
                  Expanded(
                    child: gambarBarang
                        ? Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  'assets/images/magicom.jpeg',
                                  width: double.infinity,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    konfirmasiHapus();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    color: Colors.transparent,
                                    child: const CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.close,
                                        size: 16,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // ===== TIPS =====
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.light,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.lightbulb_outline, color: Colors.orange),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Tips Serah-Terima: Sertakan foto sudut menyeluruh, colokan kabel, serta bagian lecet jika ada agar teman yang mengambil merasa yakin & transparan.',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ===== NAMA =====
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Nama Barang',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text('Wajib', style: TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              controller: namaController,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.latarInput,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ===== KATEGORI =====
            const Text(
              'Kategori Kebutuhan',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (int i = 0; i < kategori.length; i++)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          kategoriDipilih = i;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: kategoriDipilih == i
                              ? AppColors.hijau
                              : AppColors.latarInput,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          kategori[i],
                          style: TextStyle(
                            color: kategoriDipilih == i
                                ? Colors.white
                                : Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ===== KONDISI =====
            const Text(
              'Kondisi Fisik & Fungsi',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            kondisiItem(
              0,
              'Sangat Baik / Seperti Baru',
              'Fungsi 100%, sangat mulus tanpa cacat visual maupun mekanik.',
            ),
            kondisiItem(
              1,
              'Baik / Pemakaian Normal',
              'Kosmetik wajar pemakaian sehari-hari, mesin & fungsi kelistrikan 100% aman.',
            ),
            kondisiItem(
              2,
              'Cukup / Ada Sedikit Minus',
              'Fungsi pokok bekerja normal, kekurangan dirincikan di deskripsi.',
            ),
            const SizedBox(height: 20),

            // ===== COD =====
            const Row(
              children: [
                Icon(Icons.location_on_outlined, color: AppColors.hijau),
                SizedBox(width: 8),
                Text(
                  'Preferensi Serah-Terima (COD)',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Lokasi Kos / Area Kampus Terdekat',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.latarInput,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.location_on_outlined),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kukusan Teknik (Kutek), Dekat Lapangan',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Area Kampus UI Depok (~450m)',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      tampilNotif('Ubah lokasi diklik');
                    },
                    child: const Text('Ubah'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            const Text(
              'Waktu Luang untuk Janji Temu',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: AppColors.hijau,
                    title: const Text(
                      'Sore Hari (16:30 - 19:00)',
                      style: TextStyle(fontSize: 12),
                    ),
                    value: sore,
                    onChanged: (v) {
                      setState(() {
                        sore = v!;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: AppColors.hijau,
                    title: const Text(
                      'Akhir Pekan (Fleksibel)',
                      style: TextStyle(fontSize: 12),
                    ),
                    value: akhirPekan,
                    onChanged: (v) {
                      setState(() {
                        akhirPekan = v!;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: AppColors.hijau,
                    title: const Text(
                      'Bisa Ambil Hari Ini',
                      style: TextStyle(fontSize: 12),
                    ),
                    value: hariIni,
                    onChanged: (v) {
                      setState(() {
                        hariIni = v!;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: AppColors.hijau,
                    title: const Text(
                      'Titip di Pos Satpam Kos',
                      style: TextStyle(fontSize: 12),
                    ),
                    value: titipPos,
                    onChanged: (v) {
                      setState(() {
                        titipPos = v!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            const Text(
              'Catatan Pengambilan (Opsional)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: catatanController,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.latarInput,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.hijau,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  tampilNotif('Donasi berhasil dibagikan');
                },
                icon: const Icon(Icons.rocket_launch, color: Colors.white),
                label: const Text(
                  'Bagikan Donasi Barang',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget kondisiItem(int index, String judul, String isi) {
    bool dipilih = kondisiDipilih == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          kondisiDipilih = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: dipilih ? AppColors.hijauTerang : AppColors.latarInput,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              dipilih ? Icons.radio_button_checked : Icons.radio_button_off,
              color: dipilih ? AppColors.hijau : Colors.grey,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    judul,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: dipilih ? AppColors.hijau : Colors.black87,
                    ),
                  ),
                  Text(isi, style: const TextStyle(fontSize: 13)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
