# 📖 Panduan Lengkap Kodingan: Modul Explore & Request (SAPA)

> **Dokumen Penjelasan Step-by-Step Kodingan Flutter**  
> **Penanggung Jawab Fitur:** Ray (Explore & Requests)  
> **Aplikasi:** SAPA — SAling PAkai (Platform Hibah Barang Kos Mahasiswa)

---

## 📌 Daftar Isi
1. [Arsitektur & Konsep Utama](#1-arsitektur--konsep-utama)
2. [Bedah Lengkap: `lib/explore/explore.dart`](#2-bedah-lengkap-libexploreexploredart)
   - [2.1 Import & Deklarasi Class](#21-import--deklarasi-class)
   - [2.2 Fungsi Pop-up Form Permintaan (Logika CREATE)](#22-fungsi-pop-up-form-permintaan-logika-create)
   - [2.3 Struktur Layar (Scaffold & AppBar)](#23-struktur-layar-scaffold--appbar)
   - [2.4 Kolom Pencarian & Tombol Filter](#24-kolom-pencarian--tombol-filter)
   - [2.5 Chip Kategori Horizontal](#25-chip-kategori-horizontal)
   - [2.6 Banner Solidaritas Kos](#26-banner-solidaritas-kos)
   - [2.7 Daftar 6 Kotak Barang Kos](#27-daftar-6-kotak-barang-kos)
3. [Bedah Lengkap: `lib/request/request.dart`](#3-bedah-lengkap-librequestrequestdart)
   - [3.1 Penyimpanan Data In-Memory (`daftarPermintaan`)](#31-penyimpanan-data-in-memory-daftarpermintaan)
   - [3.2 Deklarasi StatefulWidget](#32-deklarasi-statefulwidget)
   - [3.3 Logika UPDATE: Fungsi `_editPermintaan()`](#33-logika-update-fungsi-_editpermintaan)
   - [3.4 Logika DELETE: Fungsi `_hapusPermintaan()`](#34-logika-delete-fungsi-_hapuspermintaan)
   - [3.5 Logika READ: Tampilan Daftar Permintaan](#35-logika-read-tampilan-daftar-permintaan)
4. [Tabel Kamus Widget & Fungsinya](#4-tabel-kamus-widget--fungsinya)
5. [Simulasi Tanya Jawab dengan Dosen](#5-simulasi-tanya-jawab-dengan-dosen)

---

## 1. Arsitektur & Konsep Utama

Dalam aplikasi SAPA, Ray bertanggung jawab atas 2 halaman utama:
1. **`ExplorePage` (`lib/explore/explore.dart`)**: Menampilkan katalog barang-barang yang dihibahkan oleh sesama mahasiswa. Di sini terdapat tombol aksi **"Minta Barang"** yang membuka dialog formulir (*UI Mockup* interaktif).
2. **`RequestPage` (`lib/request/request.dart`)**: Menampilkan daftar riwayat permohonan yang telah terisi data awal (*dummy items*), lengkap dengan implementasi operasi data **READ**, **UPDATE** (Ubah), dan **DELETE** (Batalkan).

```text
[ Halaman Explore ]                                  [ Halaman Request ]
User klik "Minta Barang"                             Menampilkan Daftar Permintaan (READ)
        ↓                                            (Pre-filled: Rice Cooker & Kasur)
Buka Form Pop-up (UI Mockup)                                         |
        ↓                                                            ↓
Klik "Kirim Permintaan"                              Bisa Ubah Catatan Permintaan (UPDATE)
        ↓                                                            ↓
Dialog Tutup + SnackBar Sukses                       Bisa Batalkan Permintaan (DELETE)
```

> **💡 Alasan Desain Simpel Ini Diterapkan:**  
> Untuk presentasi di hadapan dosen, pendekatan ini sangat aman dan bersih (*separation of concerns*):
> - **Explore** fokus sebagai penyaji antarmuka (UI/UX) katalog yang interaktif tanpa terbebani state management lintas file.
> - **Request** berdiri sendiri mengelola data in-memory (`List<Map<String, String>>`) sehingga dosen bisa langsung melihat implementasi logika manipulasi data (CRUD) menggunakan `setState()` secara mulus tanpa risiko error sinkronisasi.

---

## 2. Bedah Lengkap: `lib/explore/explore.dart`

### 2.1 Import & Deklarasi Class

```dart
import 'package:flutter/material.dart';
import 'package:sapa/theme/app_colors.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});
```

**Penjelasan:**
- `import 'package:flutter/material.dart';`: Mengimpor semua komponen dasar desain Material Flutter (Scaffold, Container, Text, Icon, dll).
- `import 'package:sapa/theme/app_colors.dart';`: Mengimpor palet warna resmi projek SAPA (`AppColors.latar`, `AppColors.hijau`, `AppColors.latarInput`).
- `class ExplorePage extends StatelessWidget`: Halaman Explore dibuat sebagai **StatelessWidget** murni karena halamannya mandiri menyajikan katalog barang dan dialog form tanpa perlu menyimpan perubahan state internal yang rumit.

---

### 2.2 Fungsi Pop-up Form Permintaan (UI Mockup Interaktif)

Fungsi ini dipanggil saat pengguna menekan tombol **"Minta Barang"** di salah satu kartu:

```dart
void _tampilkanFormMinta(BuildContext context, String namaBarang) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: Text(
          'Minta $namaBarang',
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
              SizedBox(height: 12),
              Text(
                'Nomor WhatsApp:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              SizedBox(height: 6),
              TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Contoh: 08123456789',
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
                  content: Text('Permintaan berhasil diajukan! Cek tab Permintaan.'),
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
```

**Penjelasan Step-by-Step:**
1. **`showDialog`**: Perintah bawaan Flutter untuk menampilkan jendela pop-up di atas halaman aktif.
2. **`AlertDialog`**: Kotak dialog yang memiliki tiga bagian terstruktur:
   - `title`: Judul dialog dinamis menampilkan nama barang yang diklik (`Minta $namaBarang`).
   - `content`: Formulir isian alasan & nomor kontak yang dibungkus `SingleChildScrollView` agar tidak terjadi error overflow saat keyboard virtual HP muncul.
   - `actions`: Baris tombol aksi di kanan bawah pop-up (*Batal* dan *Kirim Permintaan*).
3. **Alur Interaksi Mockup**:
   - Pengguna dapat mengetikkan alasan dan nomor WhatsApp secara langsung.
   - Saat tombol **"Kirim Permintaan"** ditekan, `Navigator.pop(context)` menutup dialog, dan `ScaffoldMessenger...showSnackBar` langsung menampilkan notifikasi hijau sukses bahwa permohonan berhasil dikirim.
   - Pendekatan ini memberikan pengalaman pengguna (*user experience*) yang utuh dan realistis tanpa membuat arsitektur kode menjadi berbelit-belit.

---

### 2.3 Struktur Layar (Scaffold & AppBar)

```dart
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
        'Jelajah Barang',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
```

**Penjelasan:**
- `Scaffold`: Kerangka dasar halaman aplikasi (menyediakan AppBar dan Body).
- `backgroundColor: AppColors.latar`: Warna latar mint lembut khas SAPA (`#F6FAF5`).
- `elevation: 0`: Membuat AppBar rata (flat) tanpa bayangan hitam, sesuai tren UI modern.
- `leading: Image.asset('assets/icons/logo1.png')`: Menempatkan logo resmi SAPA di pojok kiri atas.
- `SingleChildScrollView`: Memungkinkan seluruh halaman di-scroll ke bawah saat daftar barang panjang.

---

### 2.4 Kolom Pencarian & Tombol Filter

```dart
Row(
  children: [
    Expanded(
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.latarInput,
          hintText: 'Cari rice cooker, buku, kursi, hanger...',
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.hijau, width: 1),
          ),
        ),
      ),
    ),
    const SizedBox(width: 8),
    Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        color: AppColors.latarInput,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(Icons.tune, color: AppColors.hijau),
    ),
  ],
),
```

**Penjelasan:**
- `Row`: Menyejajarkan search bar dan tombol filter secara horizontal.
- `Expanded`: Memaksa kolom TextField mengambil seluruh sisa lebar layar yang tersedia.
- `fillColor: AppColors.latarInput`: Warna abu kehijauan lembut (`#F0F5F1`) agar input field menyatu dengan tema.
- `focusedBorder`: Garis pinggir akan berubah menjadi warna hijau SAPA saat kolom pencarian diklik.
- `Icons.tune`: Tombol ikon saringan/filter di sebelah kanan kolom pencarian.

---

### 2.5 Chip Kategori Horizontal

```dart
SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: Row(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.latarInput,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          'Semua Kategori',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
      const SizedBox(width: 8),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.latarInput,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: const [
            Icon(Icons.near_me, size: 14, color: AppColors.hijau),
            SizedBox(width: 6),
            Text('Terdekat (< 2 km)', style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
      const SizedBox(width: 8),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.latarInput,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: const [
            Icon(Icons.school, size: 14, color: AppColors.hijau),
            SizedBox(width: 6),
            Text('UNSIKA', style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    ],
  ),
),
```

**Penjelasan:**
- `scrollDirection: Axis.horizontal`: Memungkinkan tombol chip kategori digeser menyamping (kiri-kanan).
- `BorderRadius.circular(20)`: Memberikan efek kapsul (*pill shape*) pada setiap chip.
- Menampilkan filter cepat: "Semua Kategori", "Terdekat (< 2 km)", dan "UNSIKA".

---

### 2.6 Banner Solidaritas Kos

```dart
Container(
  width: double.infinity,
  padding: const EdgeInsets.all(12),
  decoration: BoxDecoration(
    color: Colors.green.shade50,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: Colors.green.shade200),
  ),
  child: Row(
    children: const [
      Icon(Icons.handshake, color: AppColors.hijau, size: 24),
      SizedBox(width: 10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gerakan Solidaritas Kos',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.hijau),
            ),
            SizedBox(height: 2),
            Text(
              'Semua barang 100% hibah gratis antar mahasiswa.',
              style: TextStyle(fontSize: 11, color: Colors.black54),
            ),
          ],
        ),
      ),
    ],
  ),
),
```

**Penjelasan:**
- Kartu hijau muda bertema sosial yang mempertegas visi aplikasi SAPA: gerakan berbagi barang kos gratis antar mahasiswa.

---

### 2.7 Daftar 6 Kotak Barang Kos

Setiap barang dibuat sebagai `Container` mandiri dengan foto lokal, informasi pemilik di sekitar UNSIKA, serta tombol *"Minta Barang"*.

Contoh struktur pada barang **Rice Cooker Mini**:
```dart
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
                    Text('Adiarsa', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: const [
                    Icon(Icons.person, size: 14, color: Colors.grey),
                    SizedBox(width: 4),
                    Text('Syawal', style: TextStyle(fontSize: 12, color: Colors.grey)),
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
          onPressed: () => _tampilkanFormMinta(context, 'Rice Cooker Mini'),
          child: const Text('Minta Barang'),
        ),
      ),
    ],
  ),
),
```

**Daftar 6 Barang:**
1. **Rice Cooker Mini** (`magicom.jpeg`) — Donor: Syawal (Adiarsa)
2. **Rak Sepatu Besi Susun 4** (`rakSepatu.jpeg`) — Donor: Nugi (Mahkota)
3. **Kasur Busa Single** (`kasur.jpg`) — Donor: Nando (Mahkota)
4. **Lampu Belajar Meja LED** (`lampu.png`) — Donor: Arya (Adiarsa)
5. **Lemari Baju Lipat Portable** (`lemari.jpeg`) — Donor: PLi (Puri Telukjambe Dekat UNSIKA)
6. **Gelas & Cangkir** (`gelas.jpeg`) — Donor: Bagja (Ronggowaluyo Dalam, Karawang)

**Poin Penting:**
Setiap tombol memanggil `onPressed: () => _tampilkanFormMinta(context, '<Nama Barang>')` sehingga nama barang otomatis terbawa ke formulir dialog.

---

## 3. Bedah Lengkap: `lib/request/request.dart`

### 3.1 Penyimpanan Data In-Memory & Data Dummy (`daftarPermintaan`)

```dart
import 'package:flutter/material.dart';
import 'package:sapa/theme/app_colors.dart';

// Data dummy riwayat permintaan
List<Map<String, String>> daftarPermintaan = [
  {
    'nama': 'Rice Cooker Mini',
    'alasan': 'Butuh untuk masak nasi harian di kosan',
    'kontak': '081234567890',
    'status': 'Menunggu',
  },
  {
    'nama': 'Kasur Busa Single',
    'alasan': 'Kasur lama di kosan sudah kempes',
    'kontak': '089876543210',
    'status': 'Disetujui',
  },
];
```

**Penjelasan:**
- Variabel `daftarPermintaan` bertipe `List<Map<String, String>>` yang disimpan secara *in-memory*.
- Telah diisi langsung (*pre-filled*) dengan **2 data dummy barang kos**:
  1. **Rice Cooker Mini** dengan status *"Menunggu"* (berlabel oranye).
  2. **Kasur Busa Single** dengan status *"Disetujui"* (berlabel hijau).
- Keuntungan data dummy ini adalah saat dosen menguji aplikasi atau membuka tab "Permintaan Saya", kartu barang sudah langsung muncul siap untuk didemonstrasikan fitur **Read**, **Update** (edit data), dan **Delete** (batalkan) tanpa harus mengisi formulir terlebih dahulu.

---

### 3.2 Deklarasi StatefulWidget

```dart
class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alasanController = TextEditingController();
  final TextEditingController _kontakController = TextEditingController();
```

**Penjelasan:**
- Menggunakan **`StatefulWidget`** karena halaman ini memiliki data yang dinamis (bisa diedit, dihapus, atau bertambah sewaktu-waktu).
- `_namaController`, `_alasanController`, dan `_kontakController` disiapkan untuk menangani isian pada form dialog edit.

---

### 3.3 Logika UPDATE: Fungsi `_editPermintaan()`

```dart
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
              const Text('Nama Barang:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(height: 6),
              TextField(
                controller: _namaController,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(height: 12),
              const Text('Alasan Membutuhkan:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(height: 6),
              TextField(
                controller: _alasanController,
                maxLines: 2,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(height: 12),
              const Text('Nomor WhatsApp:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
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
```

**Penjelasan Step-by-Step:**
1. **Pre-fill Data**: Membaca data lama berdasarkan nomor urut `index` kartu (`daftarPermintaan[index]`) dan memasukkannya ke controller agar kolom form langsung terisi teks lama.
2. **`setState()`**: Saat tombol *"Simpan Perubahan"* ditekan, nilai di dalam list pada posisi `index` ditimpa dengan teks baru. `setState()` memberitahu Flutter untuk menggambar ulang kartu tersebut seketika.

---

### 3.4 Logika DELETE: Fungsi `_hapusPermintaan()`

```dart
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
```

**Penjelasan Step-by-Step:**
1. Menampilkan dialog konfirmasi dengan pertanyaan jelas menyebutkan nama barang yang ingin dibatalkan.
2. **`daftarPermintaan.removeAt(index)`**: Menghapus item pada posisi `index` dari list.
3. Karena berada di dalam **`setState()`**, kartu tersebut seketika hilang dari layar tanpa perlu me-reload aplikasi.

---

### 3.5 Logika READ: Tampilan Daftar Permintaan

```dart
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
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: disetujui ? Colors.green.shade50 : Colors.orange.shade50,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            item['status'] ?? 'Menunggu',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: disetujui ? AppColors.hijau : Colors.orange.shade800,
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
```

**Penjelasan Step-by-Step:**
1. **Kondisi `daftarPermintaan.isEmpty`**:
   - Jika belum ada permintaan (`true`): Menampilkan teks *"Belum ada permintaan barang"* dengan ikon kotak kosong di tengah layar.
   - Jika sudah ada data (`false`): Menjalankan `ListView.builder`.
2. **`ListView.builder`**: Merender setiap data sesuai `itemCount: daftarPermintaan.length`.
3. **Pewarnaan Badge Dinamis**:
   - `disetujui ? Colors.green.shade50 : Colors.orange.shade50`: Status *"Disetujui"* otomatis berwarna hijau, sedangkan status *"Menunggu"* berwarna oranye.
4. **Tombol Aksi**:
   - `TextButton.icon` **Ubah**: Memanggil `_editPermintaan(index)`.
   - `TextButton.icon` **Batalkan**: Memanggil `_hapusPermintaan(index)`.

---

## 4. Tabel Kamus Widget & Fungsinya

| Widget Flutter | Di Mana Dipakai | Fungsi Praktisnya |
| :--- | :--- | :--- |
| **`Scaffold`** | Explore & Request | Kerangka dasar struktur halaman (menyediakan area AppBar dan Body). |
| **`AppBar`** | Explore & Request | Bilah header atas yang memuat logo SAPA dan judul halaman. |
| **`SingleChildScrollView`** | Explore & Dialog Form | Memungkinkan konten digulir (*scroll*) dan mencegah layar overflow saat keyboard muncul. |
| **`ListView.builder`** | Request | Merender daftar kartu secara berulang dan efisien sesuai jumlah data yang ada di List. |
| **`Container`** | Explore & Request | Kotak serbaguna untuk mengatur padding, margin, warna latar, dan lengkungan sudut (*border radius*). |
| **`Row`** | Explore & Request | Menyusun elemen-elemen secara mendatar / bersisian (kiri ke kanan). |
| **`Column`** | Explore & Request | Menyusun elemen-elemen secara tegak / berbaris (atas ke bawah). |
| **`Expanded`** | Explore & Request | Memaksa suatu widget (seperti Text atau TextField) mengisi sisa ruang yang tersedia agar tidak meluap ke luar layar. |
| **`ClipRRect`** | Explore | Memotong sudut gambar barang agar menjadi membulat (*rounded corners*). |
| **`TextField`** | Explore & Request | Kolom isian teks interaktif tempat pengguna mengetikkan kata kunci pencarian, alasan, dan nomor kontak. |
| **`TextEditingController`** | Explore & Request | Objek jembatan untuk mengambil (*get*), menghapus (*clear*), atau mengisi (*set*) teks pada `TextField`. |
| **`showDialog`** | Explore & Request | Fungsi bawaan Flutter untuk membuka jendela dialog mengambang (*pop-up*). |
| **`AlertDialog`** | Explore & Request | Kotak pop-up terstruktur yang memiliki bagian `title`, `content`, dan tombol aksi `actions`. |
| **`ElevatedButton`** | Explore & Request | Tombol timbul berwarna hijau untuk aksi utama seperti *"Minta Barang"* dan *"Simpan"*. |
| **`TextButton` / `TextButton.icon`** | Request | Tombol teks ringan tanpa latar belakang untuk aksi sekunder seperti *"Batal"*, *"Ubah"*, dan *"Batalkan"*. |
| **`Divider`** | Request | Garis pemisah horizontal tipis antara data deskripsi barang dan tombol aksi. |
| **`SnackBar`** | Explore & Request | Pesan notifikasi kecil berwarna hijau/merah di bagian bawah layar yang muncul sesaat setelah aksi berhasil. |

---

## 5. Simulasi Tanya Jawab dengan Dosen

Berikut adalah pertanyaan yang sering diajukan dosen saat evaluasi kode Flutter beserta panduan jawaban terbaik:

### ❓ Q1: *"Mengapa halaman Explore menggunakan StatelessWidget, sedangkan Request menggunakan StatefulWidget?"*
> **Jawaban:**  
> *"Halaman Explore hanya bertugas menampilkan katalog barang yang statis dan memunculkan pop-up form, sehingga cukup menggunakan `StatelessWidget` yang lebih ringan. Sedangkan halaman Request perlu menambah, memperbarui, dan menghapus data kartu secara dinamis saat aplikasi berjalan, sehingga wajib menggunakan `StatefulWidget` agar tampilan bisa diperbarui dengan fungsi `setState()`."*

---

### ❓ Q2: *"Bagaimana alur pengelolaan data dan pemisahan fitur antara Explore dan Request?"*
> **Jawaban:**  
> *"Kami menerapkan prinsip pemisahan tanggung jawab (*separation of concerns*) agar kode tetap bersih dan mudah dipelihara:  
> - **Di Explore**: Tombol 'Minta Barang' menampilkan form dialog interaktif sebagai **UI Mockup** yang memberikan feedback langsung (tutup pop-up dan SnackBar konfirmasi sukses) tanpa membebani halaman dengan ketergantungan state lintas file yang rumit.  
> - **Di Request**: Kami menyiapkan data in-memory `daftarPermintaan` yang langsung terisi data dummy awal (*Rice Cooker Mini* dan *Kasur Busa Single*). Di halaman ini, dosen dapat menguji langsung kemampuan logika manipulasi data dinamis:  
>   - **Read**: Ditampilkan menggunakan `ListView.builder`.  
>   - **Update**: Tombol 'Ubah' membuka dialog untuk mengedit nama, alasan, atau kontak lalu memperbarui tampilan secara reaktif via `setState()`.  
>   - **Delete**: Tombol 'Batalkan' menampilkan konfirmasi dialog lalu menghapus item menggunakan `daftarPermintaan.removeAt(index)` via `setState()`."*

---

### ❓ Q3: *"Apa kegunaan SingleChildScrollView pada content AlertDialog?"*
> **Jawaban:**  
> *"Untuk mencegah error `RenderFlex overflowed` (garis kuning-hitam). Ketika pengguna mengklik kolom TextField, keyboard virtual HP akan muncul dan mempersempit tinggi layar. Dengan membungkusnya menggunakan `SingleChildScrollView`, isi pop-up tetap bisa di-scroll ke atas sehingga tidak terpotong oleh keyboard."*

---

### ❓ Q4: *"Bagaimana cara kerja pewarnaan status badge di kartu Permintaan?"*
> **Jawaban:**  
> *"Kami menggunakan kondisi logika ternary operator sederhana: `final bool disetujui = item['status'] == 'Disetujui'`. Jika nilainya true, warna latar belakang diset menjadi hijau muda (`Colors.green.shade50`) dan teks hijau SAPA. Jika statusnya 'Menunggu', warnanya otomatis berubah menjadi oranye muda (`Colors.orange.shade50`) dengan teks oranye gelap."*

---

*Dokumen ini dibuat lengkap agar dapat dijadikan modul belajar mandiri dan panduan presentasi yang terstruktur.*
