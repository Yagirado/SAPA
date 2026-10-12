import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sapa/item/item.dart';

const Barang _barang = Barang(
  gambar: ['assets/images/magicom.jpeg'],
  judul: 'Rice Cooker Cosmos 1,2L & Centong Nasi',
  jarak: '0,5 km dari Kampus UI',
  lokasi: 'Kukusan Teknik, Depok',
  kondisi: 'Baik',
  kategori: ['Elektronik', 'Peralatan Masak'],
  cerita: 'Cerita dummy untuk pengujian.',
  waktuPost: '2 jam lalu',
  statusPill: 'Tersedia',
  donaturNama: 'Andi Pratama',
  donaturInstitusi: 'Mahasiswa Teknik Komputer, Universitas Indonesia',
  donaturAvatar: 'assets/images/fahri.png',
);

void main() {
  final ukuranLayar = <String, Size>{
    'HP kecil 320x568': const Size(320, 568),
    'HP standar 360x640': const Size(360, 640),
    'HP besar 430x932': const Size(430, 932),
    'Tablet 1024x768': const Size(1024, 768),
  };

  for (final entri in ukuranLayar.entries) {
    testWidgets('DetailItem tampil penuh di ${entri.key}', (tester) async {
      await tester.binding.setSurfaceSize(entri.value);
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        const MaterialApp(home: DetailItem(barang: _barang)),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);

      final layar = entri.value;

      // Body harus punya tinggi nyata, bukan 0 px (penyebab layar blank).
      final judulFinder = find.text('Rice Cooker Cosmos 1,2L & Centong Nasi');
      final rectJudul = tester.getRect(judulFinder);
      expect(
        rectJudul.height,
        greaterThan(0),
        reason: 'Tinggi judul 0 px — body tidak ter-render',
      );
      expect(
        rectJudul.top,
        lessThan(layar.height),
        reason: 'Judul berada di luar layar',
      );

      // Tombol bawah harus tetap terlihat dan berada di bagian bawah layar.
      final rectTombol = tester.getRect(find.text('Saya Membutuhkan Ini'));
      expect(rectTombol.bottom, lessThanOrEqualTo(layar.height + 1));

      // Bottom bar tidak boleh menelan seluruh layar.
      expect(
        rectTombol.top,
        greaterThan(layar.height * 0.5),
        reason: 'Tombol utama tidak di bagian bawah — bottom bar mengisi layar',
      );
    });
  }
}
