import 'package:flutter/material.dart';
import 'package:sapa/theme/app_colors.dart';

class Barang {
  final List<String> gambar;
  final String judul;
  final List<String> kategori;
  final String kondisi;
  final String lokasi;
  final String jarak;
  final String cerita;
  final String waktuPost;
  final String statusPill;
  final String donaturNama;
  final String donaturInstitusi;
  final String donaturAvatar;
  final int jumlahDonasi;
  final int jumlahBarang;

  const Barang({
    required this.gambar,
    required this.judul,
    required this.kategori,
    required this.kondisi,
    required this.lokasi,
    required this.jarak,
    required this.cerita,
    required this.waktuPost,
    required this.statusPill,
    required this.donaturNama,
    required this.donaturInstitusi,
    required this.donaturAvatar,
    this.jumlahDonasi = 0,
    this.jumlahBarang = 1,
  });
}

final Barang dummyBarangDefault = Barang(
  gambar: [
    'assets/images/magicom.jpeg',
  ],
  judul: 'Rice Cooker Cosmos 1.2L & Centong Nasi',
  kategori: ['Peralatan Masak'],
  kondisi: 'Baik',
  lokasi: 'Kuturan Teknik, Depok',
  jarak: '600m dari Kampus UI',
  cerita:
      'Rice cooker masih berfungsi sangat baik untuk masak nasi dan mengukus. Digunakan sekitar 1 tahun di kos lama. Berhubungan sudah lulus dan akan kembali ke kampung halaman, barang ini ingin saya hibahkan ke adik tingkat atau sesama anak kos yang membutuhkan. Sudah dibersihkan tuntas dan siap pakai.',
  waktuPost: '2 jam lalu',
  statusPill: 'Tersedia',
  donaturNama: 'Andi Pratama',
  donaturInstitusi: 'Mahasiswa Teknik Komputer, Universitas Indonesia',
  donaturAvatar: 'assets/images/fahri.png',
  jumlahDonasi: 1,
  jumlahBarang: 1,
);

class _Langkah {
  final int nomor;
  final String judul;
  final String deskripsi;

  const _Langkah({
    required this.nomor,
    required this.judul,
    required this.deskripsi,
  });
}

const List<_Langkah> _daftarLangkah = [
  _Langkah(
    nomor: 1,
    judul: 'Ajukan Permintaan',
    deskripsi:
        'Tulis pesan singkat alasan kenapa kamu membutuhkan barang ini.',
  ),
  _Langkah(
    nomor: 2,
    judul: 'Konfirmasi Donatur',
    deskripsi: 'Donatur akan menyetujui permohonan yang paling sesuai.',
  ),
  _Langkah(
    nomor: 3,
    judul: 'Janjian & Serah Terima',
    deskripsi:
        'Chat untuk janjian lokasi (bisa di depan kos Andi atau area kampus UI).',
  ),
];

class DetailItem extends StatefulWidget {
  final Barang? barang;

  const DetailItem({super.key, this.barang});

  @override
  State<DetailItem> createState() => _DetailItemState();
}

class _DetailItemState extends State<DetailItem> {
  final PageController _pageController = PageController();
  int _halamanAktif = 0;

  late final Barang _barangData;

  @override
  void initState() {
    super.initState();
    _barangData = widget.barang ?? dummyBarangDefault;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _pesan(String aksi) {
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
      appBar: _buildAppBar(context),
      body: SafeArea(
        top: false,
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildGaleri(300),
                  const SizedBox(height: 16),
                  _buildJudul(),
                  const SizedBox(height: 16),
                  _buildKartuLokasi(),
                  const SizedBox(height: 24),
                  _buildCerita(),
                  const SizedBox(height: 24),
                  _buildDonatur(),
                  const SizedBox(height: 24),
                  _buildCaraMengambil(),
                  const SizedBox(height: 20),
                  _buildKartuInfo(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBilahBawah(),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final totalGambar =
        _barangData.gambar.isEmpty ? 1 : _barangData.gambar.length;

    return AppBar(
      backgroundColor: AppColors.latar,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black87),
        onPressed: () => Navigator.maybePop(context),
      ),
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          '${_halamanAktif + 1}/$totalGambar',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: ClipOval(
            child: Image.asset(
              _barangData.donaturAvatar,
              width: 34,
              height: 34,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.account_circle,
                size: 34,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGaleri(double tinggi) {
    final listGambar = _barangData.gambar;

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: SizedBox(
        height: tinggi,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: listGambar.isEmpty ? 1 : listGambar.length,
              onPageChanged: (index) => setState(() => _halamanAktif = index),
              itemBuilder: (context, index) {
                if (listGambar.isEmpty) {
                  return Container(
                    color: AppColors.latarInput,
                    child: const Icon(
                      Icons.image_outlined,
                      size: 48,
                      color: Colors.grey,
                    ),
                  );
                }
                return Image.asset(
                  listGambar[index],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: AppColors.latarInput,
                    child: const Icon(
                      Icons.image_outlined,
                      size: 48,
                      color: Colors.grey,
                    ),
                  ),
                );
              },
            ),
            Positioned(
              top: 12,
              left: 12,
              child: _Pill(
                teks: 'Gratis / Donasi',
                bg: AppColors.hijau,
                fg: Colors.white,
                ikon: Icons.card_giftcard,
              ),
            ),
            if (listGambar.length > 1)
              Positioned(
                bottom: 12,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    listGambar.length,
                    (index) => Container(
                      width: 12,
                      height: 4,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: _halamanAktif == index
                            ? AppColors.hijau
                            : Colors.white.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildJudul() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '${_barangData.jumlahBarang} Barang',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                height: 1,
                color: Colors.black.withValues(alpha: 0.08),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _Pill(
              teks: _barangData.statusPill.toUpperCase(),
              bg: AppColors.hijauTerang.withValues(alpha: 0.5),
              fg: AppColors.hijau,
            ),
            _Pill(
              teks: 'Kondisi: ${_barangData.kondisi}',
              bg: AppColors.latarInput,
              fg: Colors.black54,
            ),
            ..._barangData.kategori.map(
              (kat) => _Pill(
                teks: kat,
                bg: AppColors.latarInput,
                fg: Colors.black54,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          _barangData.judul,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            height: 1.25,
          ),
        ),
      ],
    );
  }

  Widget _buildKartuLokasi() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.latarInput,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.hijau.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.near_me, color: AppColors.hijau, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _barangData.lokasi,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Text(
                  'Sekitar ${_barangData.jarak}',
                  style: const TextStyle(fontSize: 11, color: Colors.black54),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right, color: Colors.black38, size: 20),
        ],
      ),
    );
  }

  Widget _buildCerita() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _JudulBagian(teks: 'Cerita & Kondisi Barang'),
        const SizedBox(height: 10),
        Text(
          _barangData.cerita,
          style: TextStyle(
            fontSize: 13,
            height: 1.55,
            color: Colors.black.withValues(alpha: 0.72),
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            const Icon(Icons.schedule, size: 14, color: Colors.grey),
            const SizedBox(width: 6),
            Text(
              'Diunggah ${_barangData.waktuPost}',
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDonatur() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _JudulBagian(teks: 'DONATUR TERVERIFIKASI'),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset(
                _barangData.donaturAvatar,
                width: 54,
                height: 54,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.account_circle,
                  size: 54,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _barangData.donaturNama,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    _barangData.donaturInstitusi,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      height: 1.35,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCaraMengambil() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.latarInput.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _JudulBagian(teks: 'Bagaimana Cara Mengambil Barang?'),
          const SizedBox(height: 4),
          ..._daftarLangkah.map(
            (langkah) => Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColors.hijau,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${langkah.nomor}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          langkah.judul,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          langkah.deskripsi,
                          style: const TextStyle(
                            fontSize: 12,
                            height: 1.5,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKartuInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF9E7),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFF3E8BC)),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.favorite_border, color: Color(0xFF856404), size: 22),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Kolektif berbagi adalah gerakan gotong royong mahasiswa. Jaga sopan santun dan tepati janji waktu temu saat mengambil barang.',
              style: TextStyle(
                fontSize: 12,
                height: 1.5,
                color: Color(0xFF856404),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPanduan() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.assignment_outlined, size: 14, color: Colors.grey),
        SizedBox(width: 6),
        Flexible(
          child: Text(
            'Tidak dipungut biaya apapun • 100% Donasi Mahasiswa',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget _buildBilahBawah() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.black.withValues(alpha: 0.06)),
        ),
      ),
      child: SafeArea(
        top: false,
        // heightFactor: 1 wajib — tanpa ini Center ikut mengisi seluruh tinggi
        // layar (constraint dari Scaffold), sehingga body jadi 0 px / blank.
        child: Center(
          heightFactor: 1,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildPanduan(),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.latarInput,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.bookmark_border,
                              color: AppColors.hijau),
                          onPressed: () => _pesan('Simpan'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.hijau,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () => _pesan('Ajukan kebutuhan'),
                          icon: const Icon(Icons.pan_tool_outlined, size: 20),
                          label: const Text(
                            'Saya Membutuhkan Ini',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _JudulBagian extends StatelessWidget {
  final String teks;

  const _JudulBagian({required this.teks});

  @override
  Widget build(BuildContext context) {
    return Text(
      teks,
      style: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 0.5),
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }
}