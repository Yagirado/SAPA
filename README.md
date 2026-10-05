# SAPA — SAling PAkai

> Barang yang sudah tidak kamu pakai, bisa jadi sangat berguna untuk mahasiswa lain.

SAPA adalah aplikasi berbasis Flutter yang dirancang sebagai platform berbagi barang bekas layak pakai di kalangan mahasiswa. SAPA membantu mahasiswa memberikan barang yang sudah tidak digunakan kepada mahasiswa lain yang membutuhkannya.

SAPA **bukan marketplace atau platform jual-beli**. Fokusnya adalah berbagi dan memberikan barang yang masih bermanfaat.

> **Semua orang bisa berbagi, semua orang bisa menerima.**

Satu akun dapat membagikan barang sekaligus mencari dan meminta barang dari pengguna lain. Tidak ada role permanen seperti “Donor” atau “Penerima”; peran pengguna dapat berubah sesuai aktivitasnya.

Barang yang dapat dibagikan mencakup peralatan kos, buku, elektronik, perlengkapan kuliah, furnitur kecil, pakaian, perlengkapan rumah tangga, dan barang bekas layak pakai lainnya.

## Status Project

**🚧 Status: UI/UX Prototype — In Development**

Project ini masih berfokus pada pembuatan antarmuka dan pengalaman pengguna menggunakan Flutter dan Dart. Cakupan di bawah menjelaskan layar serta alur UI/UX yang sedang dirancang dan dikembangkan; daftar ini tidak berarti semua layar sudah selesai.

Pada tahap ini SAPA belum memiliki backend, database, Firebase, API, authentication backend, penyimpanan data permanen, upload gambar nyata, notifikasi real-time, atau sistem request yang benar-benar tersimpan. Sebagian data untuk tampilan dan demonstrasi dapat berupa data dummy atau mock.

## Teknologi

- **Flutter** — framework aplikasi.
- **Dart** — bahasa pemrograman.

## Cakupan UI/UX

### Authentication

- Splash screen dan onboarding.
- Login, register, dan forgot password.
- Form authentication dan navigasi antarhalaman authentication.

### Home

- Sapaan pengguna dan profile preview.
- Search bar dan kategori barang.
- Recommended donations dan recently added donations.
- Donation cards dan bottom navigation.

### Donation Detail

- Foto, nama, kondisi, kategori, deskripsi, lokasi, dan universitas barang.
- Informasi pemilik atau donor.
- Tombol **Saya Membutuhkan Ini** dan tombol report.

### Explore

- Pencarian dan daftar barang.
- Filter kategori, kondisi, lokasi, dan universitas.
- Donation cards.

### Requests

SAPA memiliki dua konteks permintaan:

- **My Requests** — permintaan barang yang diajukan pengguna terhadap barang milik pengguna lain.
- **Requests for My Donations** — permintaan dari pengguna lain terhadap barang yang dibagikan pengguna.

Cakupan UI request meliputi daftar dan detail request, form request, status request, informasi barang, serta informasi pengguna.

### Profile

- Foto profil, nama, universitas, dan lokasi.
- Statistik donasi dan barang yang diterima.
- My Donations dan My Requests.
- Edit Profile dan Settings.

### Additional UI

- Notification UI.
- Empty, loading, dan error state.
- Confirmation dialog, report UI, dan form validation UI.

## Alur Penggunaan

### Login Flow

```text
Splash
   ↓
Onboarding
   ↓
Login
   ↓
Home
```

### Memberikan Barang

```text
Home
   ↓
Post / Donate
   ↓
Create Donation
   ↓
Isi Informasi Barang
   ↓
Preview
   ↓
Publish
```

### Meminta Barang

```text
Home
   ↓
Jelajah / Explore
   ↓
Search / Browse
   ↓
Donation Detail
   ↓
Saya Membutuhkan Ini
   ↓
Request Form
   ↓
Submit Request
```

### Konsep Dua Arah

```text
User
 ├── Membagikan barang
 │      └── Rice Cooker
 │
 └── Meminta barang
        └── Meja Belajar
```

Satu pengguna dapat melakukan kedua aktivitas tersebut menggunakan satu akun.

## Pembagian Tugas Tim

| Nama | Main Module | Main Screens |
| --- | --- | --- |
| Nugi | Authentication | Splash, Onboarding, Login, Register |
| Arya | Profile | Profile, Edit Profile, Settings |
| Nando | Home & Donation Detail | Home, Donation Card, Donation Detail |
| Ray | Explore & Requests | Explore, Search, Filter, Requests |

### Nugi — Authentication UI

- Splash dan onboarding.
- Login, register, dan forgot password UI.
- Authentication navigation dan forms.

### Arya — Profile UI

- Profile dan edit profile.
- User information dan profile statistics.
- My Donations, My Requests, dan settings.

### Nando — Home & Donation Detail UI

- Home/Beranda dan donation cards.
- Recommended donations dan recently added donations.
- Donation detail, donor information, dan donation action buttons.

### Ray — Explore & Requests UI

- Explore/Jelajah, search, dan filter.
- Category filtering dan donation listing.
- Requests, My Requests, dan Requests for My Donations.
- Request detail dan request form.

## Konsep Desain

Desain SAPA diarahkan agar terasa modern, clean, friendly, youthful, minimalist, community-oriented, dan sustainability-oriented. Hijau/teal menjadi referensi tema warna untuk menggambarkan kepedulian dan keberlanjutan.

Palet berikut adalah **referensi desain**, bukan klaim bahwa semua warna sudah diterapkan pada UI:

| Peran | Warna referensi |
| --- | --- |
| Primary | `#2E7D5B` |
| Secondary | `#66A88A` |
| Accent | `#F4B942` |
| Background | `#F7F8F7` |
| Surface | `#FFFFFF` |
| Text | `#202522` |
| Secondary Text | `#6B746E` |
| Error | `#D9534F` |

### Komponen UI yang Direncanakan

Komponen berikut dapat digunakan untuk menjaga konsistensi tampilan. Daftar ini merupakan cakupan desain dan tidak menyatakan bahwa setiap komponen sudah diimplementasikan.

- Donation Card dan Request Card.
- Category Card dan Search Bar.
- Primary Button dan Secondary Button.
- Status Badge, Location Badge, dan University Badge.
- Profile Avatar, Bottom Navigation, dan Custom App Bar.
- Filter Bottom Sheet, Form Field, dan Image Picker UI.
- Empty State, Loading State, dan Confirmation Dialog.

## Instalasi

### Kebutuhan Dasar

- Flutter SDK.
- Dart SDK.
- Android Studio atau Visual Studio Code.
- Emulator Android atau perangkat Android.

### Menjalankan Project



```bash
git clone https://github.com/Yagirado/SAPA.git
cd sapa
flutter pub get
flutter run
```

## Keterbatasan Saat Ini

- Project masih dalam tahap UI/UX Prototype.
- Belum memiliki backend, database, Firebase, atau authentication backend.
- Data belum tersimpan secara permanen.
- Upload gambar belum terhubung ke cloud storage.
- Request belum diproses atau disimpan secara nyata.
- Notifikasi belum real-time.
- Sebagian data UI masih dapat menggunakan mock atau static data.
- Fokus pengembangan saat ini adalah tampilan, navigasi, dan pengalaman pengguna.

## Kontribusi

Setiap anggota tim mengembangkan modul sesuai pembagian tugas. Kerjakan perubahan pada branch masing-masing, lalu gabungkan perubahan ke `develop` sebelum masuk ke `main`.

Rekomendasi branch:

```text
main
develop
feature/nugi-auth
feature/arya-profile
feature/nando-home
feature/ray-explore-request
```

Contoh pesan commit:

```text
feat: add authentication screens
feat: add profile screen
feat: add home screen
feat: add donation detail
feat: add explore screen
feat: add request screen
style: improve home UI
style: improve profile UI
fix: fix navigation issue
refactor: improve reusable widgets
docs: update README
```

## Tujuan SAPA

SAPA diharapkan membantu mahasiswa memberikan barang yang sudah tidak digunakan kepada mahasiswa lain yang lebih membutuhkan, sekaligus mengurangi barang terbuang dan membangun budaya berbagi di lingkungan mahasiswa.

> **Barang yang tidak lagi kamu pakai, mungkin adalah barang yang sedang dicari orang lain.**
