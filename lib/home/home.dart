import 'package:flutter/material.dart';
import 'package:sapa/theme/app_colors.dart';

class _Kategori {
  final IconData ikon;
  final String label;
  final String sub;

  const _Kategori(this.ikon, this.label, this.sub);
}

class _BarangDekat {
  final String gambar;
  final String judul;
  final String jarak;
  final String pemilik;
  final String kampus;
  final String avatar;
  final String kondisi;

  const _BarangDekat({
    required this.gambar,
    required this.judul,
    required this.jarak,
    required this.pemilik,
    required this.kampus,
    required this.avatar,
    required this.kondisi,
  });
}

class _BarangBaru {
  final String gambar;
  final String kategori;
  final String judul;
  final String lokasi;
  final String status;

  const _BarangBaru({
    required this.gambar,
    required this.kategori,
    required this.judul,
    required this.lokasi,
    required this.status,
  });
}

const List<_Kategori> _daftarKategori = [
  _Kategori(Icons.chair_outlined, 'Perlengkapan', 'Kos'),
  _Kategori(Icons.soup_kitchen_outlined, 'Peralatan', 'Masak'),
  _Kategori(Icons.devices_other_outlined, 'Elektronik', 'Gadget'),
  _Kategori(Icons.bed_outlined, 'Furniture', 'Kamar'),
  _Kategori(Icons.edit_note_outlined, 'Alat Tulis', 'Belajar'),
];

const _BarangDekat _barangDekat = _BarangDekat(
  gambar: 'assets/images/magicom.jpeg',
  judul: 'Rice Cooker Cosmos 1,2L',
  jarak: '0,5 km dari Kampus',
  pemilik: 'Dimas S.',
  kampus: 'Mahasiswa UNSIKA',
  avatar: 'assets/images/fahri.png',
  kondisi: 'Kondisi Baik',
);

const List<_BarangBaru> _daftarBarangBaru = [
  _BarangBaru(
    gambar: 'assets/images/rakSepatu.jpeg',
    kategori: 'Furniture Kos',
    judul: 'Rak Sepatu Besi Susun 4',
    lokasi: 'Adiarsa Barat',
    status: 'Tersedia',
  ),
  _BarangBaru(
    gambar: 'assets/images/lampu.png',
    kategori: 'Elektronik',
    judul: 'Lampu Belajar Meja LED',
    lokasi: 'Puri Telukjambe',
    status: 'Tersedia',
  ),
  _BarangBaru(
    gambar: 'assets/images/lemari.jpeg',
    kategori: 'Perlengkapan Kos',
    judul: 'Lemari Baju Lipat Portable',
    lokasi: 'Mahkota Regency',
    status: 'Tersedia',
  ),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _belumTersedia(String aksi) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$aksi belum tersedia'),
        backgroundColor: AppColors.hijau,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.latar,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 90),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Header(),
              const SizedBox(height: 20),
              const _Greeting(),
              const SizedBox(height: 20),
              _SectionHeader(
                judul: 'Kategori Perlengkapan',
                trailing: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.hijau,
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () => _belumTersedia('Semua kategori'),
                  child: const Text(
                    'Semua',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 96,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _daftarKategori.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final item = _daftarKategori[index];
                    return _KategoriTile(
                      item: item,
                      onTap: () => _belumTersedia(item.label),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              _SectionHeader(
                judul: 'Dekat Kampusmu',
                trailing: _Pill(
                  teks: '+1,5 km',
                  bg: AppColors.hijau,
                  fg: Colors.white,
                  ikon: Icons.near_me,
                ),
              ),
              const SizedBox(height: 12),
              _KartuDekat(
                barang: _barangDekat,
                onDetail: () => _belumTersedia('Detail barang'),
              ),
              const SizedBox(height: 24),
              _SectionHeader(
                judul: 'Baru Ditambahkan',
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.bolt, size: 14, color: AppColors.hijau),
                    SizedBox(width: 2),
                    Text(
                      'Real-time update',
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              ..._daftarBarangBaru.map(
                (barang) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _KartuBaru(
                    barang: barang,
                    onAjukan: () => _belumTersedia('Ajukan pinjam'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 44,
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.latarInput,
                hintText: 'Cari perlengkapan kos...',
                hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: 20,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppColors.hijau,
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        ClipOval(
          child: Image.asset(
            'assets/images/fahri.png',
            width: 44,
            height: 44,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}

class _Greeting extends StatelessWidget {
  const _Greeting();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Hi, Andi Pratama 👋',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Siap berbagi? Cek barang di sekitar kosanmu hari ini.',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String judul;
  final Widget? trailing;

  const _SectionHeader({required this.judul, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          judul,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        ?trailing,
      ],
    );
  }
}

class _KategoriTile extends StatelessWidget {
  final _Kategori item;
  final VoidCallback onTap;

  const _KategoriTile({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: 72,
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.latarInput,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(item.ikon, color: AppColors.hijau, size: 26),
            ),
            const SizedBox(height: 6),
            Text(
              item.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, height: 1.15),
            ),
            Text(
              item.sub,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 10, color: Colors.grey, height: 1.15),
            ),
          ],
        ),
      ),
    );
  }
}

class _KartuDekat extends StatelessWidget {
  final _BarangDekat barang;
  final VoidCallback onDetail;

  const _KartuDekat({required this.barang, required this.onDetail});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.asset(
                  barang.gambar,
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: _Pill(
                  teks: 'Gratis Dihibahkan',
                  bg: AppColors.hijau,
                  fg: Colors.white,
                  ikon: Icons.card_giftcard,
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: _Pill(
                  teks: barang.kondisi,
                  bg: Colors.white.withValues(alpha: 0.9),
                  fg: AppColors.hijau,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  barang.judul,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      barang.jarak,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                const Divider(height: 20),
                Row(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        barang.avatar,
                        width: 32,
                        height: 32,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            barang.pemilik,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            barang.kampus,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.hijau,
                        side: const BorderSide(color: AppColors.hijau),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 0,
                        ),
                        minimumSize: const Size(0, 34),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: onDetail,
                      icon: const Text(
                        'Lihat Detail',
                        style: TextStyle(fontSize: 12),
                      ),
                      label: const Icon(Icons.arrow_forward, size: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _KartuBaru extends StatelessWidget {
  final _BarangBaru barang;
  final VoidCallback onAjukan;

  const _KartuBaru({required this.barang, required this.onAjukan});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              barang.gambar,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  barang.kategori,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: AppColors.hijau,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  barang.judul,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 12,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        barang.lokasi,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _Pill(
                      teks: barang.status,
                      bg: Colors.green.shade50,
                      fg: AppColors.hijau,
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.hijau,
                        side: const BorderSide(color: AppColors.hijau),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        minimumSize: const Size(0, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: onAjukan,
                      child: const Text(
                        'Ajukan Pinjam',
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String teks;
  final Color bg;
  final Color fg;
  final IconData? ikon;

  const _Pill({
    required this.teks,
    required this.bg,
    required this.fg,
    this.ikon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (ikon != null) ...[
            Icon(ikon, size: 12, color: fg),
            const SizedBox(width: 4),
          ],
          Text(
            teks,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }
}
