import 'package:flutter/material.dart';
import 'package:sapa/theme/app_colors.dart';

class Regist extends StatefulWidget {
  const Regist({super.key});

  @override
  State<Regist> createState() => _RegistState();
}

class _RegistState extends State<Regist> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _nomorController = TextEditingController();
  final _passwordController = TextEditingController();
  final _konfirmasiController = TextEditingController();

  bool _passwordTersembunyi = true;
  bool _konfirmasiTersembunyi = true;
  bool _menyetujuiSyarat = false;

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _nomorController.dispose();
    _passwordController.dispose();
    _konfirmasiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.latar,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(14, 4, 14, 0),
          decoration: const BoxDecoration(
            color: Color(0xFFF8FBF7),
            borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, size: 24),
                      color: const Color(0xFF1D2522),
                      tooltip: 'Kembali ke login',
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Container(
                      width: 64,
                      height: 64,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x18000000),
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/icons/logo2.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Center(
                    child: Text(
                      'Daftar Akun KosBerbagi 🌱',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Bergabung dalam gerakan saling berbagi dan '
                    'temukan perlengkapan kos gratis dari sesama '
                    'mahasiswa di sekitarmu.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, height: 1.55),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        elevation: 1,
                        overlayColor: Colors.black.withValues(alpha: 0.08),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Pendaftaran dengan Google belum tersedia',
                            ),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/google.png',
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Daftar dengan Akun Google',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Expanded(child: Divider(color: Color(0xFFD9E1DB))),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'atau daftar manual',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      const Expanded(child: Divider(color: Color(0xFFD9E1DB))),
                    ],
                  ),
                  const SizedBox(height: 18),
                  _label('Nama Lengkap Mahasiswa', 'Sesuai KTM'),
                  const SizedBox(height: 6),
                  _field(
                    controller: _namaController,
                    hint: 'cth: Andi Pratama',
                    icon: Icons.badge_outlined,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Nama lengkap wajib diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  _label('Email Kampus / Aktif'),
                  const SizedBox(height: 6),
                  _field(
                    controller: _emailController,
                    hint: 'nama@ui.ac.id atau email aktif',
                    icon: Icons.alternate_email,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      final email = value?.trim() ?? '';
                      if (email.isEmpty) return 'Email wajib diisi';
                      if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                          .hasMatch(email)) {
                        return 'Masukkan alamat email yang valid';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  _label('Nomor WhatsApp Aktif', 'Untuk Serah Terima'),
                  const SizedBox(height: 6),
                  _field(
                    controller: _nomorController,
                    hint: '812-3456-7890',
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    prefix: const Padding(
                      padding: EdgeInsets.only(left: 12, right: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('+62', style: TextStyle(fontSize: 12)),
                          SizedBox(width: 10),
                          SizedBox(
                            height: 20,
                            child: VerticalDivider(
                              width: 1,
                              thickness: 1,
                              color: Color(0xFFD9E1DB),
                            ),
                          ),
                          SizedBox(width: 4),
                        ],
                      ),
                    ),
                    validator: (value) {
                      final digits = (value ?? '').replaceAll(
                        RegExp(r'\D'),
                        '',
                      );
                      if (digits.length < 9) {
                        return 'Masukkan nomor WhatsApp yang valid';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Nomornya dibagikan saat ada kesepakatan serah terima barang.',
                    style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 12),
                  _label('Kata Sandi'),
                  const SizedBox(height: 6),
                  _field(
                    controller: _passwordController,
                    hint: 'Minimal 8 karakter',
                    icon: Icons.lock_outline,
                    obscureText: _passwordTersembunyi,
                    textInputAction: TextInputAction.next,
                    suffix: IconButton(
                      visualDensity: VisualDensity.compact,
                      icon: Icon(
                        _passwordTersembunyi
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 19,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordTersembunyi = !_passwordTersembunyi;
                        });
                      },
                    ),
                    onChanged: (_) => setState(() {}),
                    validator: (value) {
                      if ((value ?? '').length < 8) {
                        return 'Kata sandi minimal 8 karakter';
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 12),
                  _label('Konfirmasi Kata Sandi'),
                  const SizedBox(height: 6),
                  _field(
                    controller: _konfirmasiController,
                    hint: 'Ulangi kata sandi',
                    icon: Icons.lock_reset,
                    obscureText: _konfirmasiTersembunyi,
                    textInputAction: TextInputAction.done,
                    suffix: IconButton(
                      visualDensity: VisualDensity.compact,
                      icon: Icon(
                        _konfirmasiTersembunyi
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 19,
                      ),
                      onPressed: () {
                        setState(() {
                          _konfirmasiTersembunyi = !_konfirmasiTersembunyi;
                        });
                      },
                    ),
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return 'Konfirmasi kata sandi belum sama';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: _menyetujuiSyarat,
                          activeColor: AppColors.hijau,
                          visualDensity: VisualDensity.compact,
                          onChanged: (value) {
                            setState(() {
                              _menyetujuiSyarat = value ?? false;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text.rich(
                            TextSpan(
                              style: const TextStyle(
                                fontSize: 10,
                                height: 1.35,
                              ),
                              children: [
                                const TextSpan(text: 'Saya setuju dengan '),
                                TextSpan(
                                  text: 'Syarat & Ketentuan',
                                  style: TextStyle(
                                    color: AppColors.hijau,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const TextSpan(text: ' serta '),
                                TextSpan(
                                  text:
                                      'Panduan Etika Saling Menjaga KosBerbagi',
                                  style: TextStyle(
                                    color: AppColors.hijau,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const TextSpan(
                                  text: ' (barang 100% bebas komersialisasi, tepat sasaran, dan dijaga dengan baik).',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.hijau,
                        foregroundColor: Colors.white,
                        elevation: 1,
                        overlayColor: Colors.white.withValues(alpha: 0.16),
                        shape: const StadiumBorder(),
                      ),
                      onPressed: _menyetujuiSyarat ? _submit : null,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Buat Akun & Lanjut Verifikasi',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward, size: 18),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Text(
                          'Sudah punya akun sebelumnya? ',
                          style: TextStyle(fontSize: 10),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.hijau,
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            minimumSize: const Size(0, 36),
                            textStyle: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Masuk Sekarang'),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF4EF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.shield, color: AppColors.hijau, size: 12),
                          SizedBox(width: 5),
                          Text(
                            'Enkripsi Data Pribadi Terproteksi 256-bit',
                            style: TextStyle(fontSize: 9),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _label(String text, [String? note]) {
    return Row(
      children: [
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ),
        if (note != null)
          Text(
            note,
            style: TextStyle(
              fontSize: 9,
              color: AppColors.hijau,
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String hint,
    IconData? icon,
    Widget? prefix,
    Widget? suffix,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    bool obscureText = false,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      style: const TextStyle(fontSize: 12),
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        hintStyle: TextStyle(fontSize: 11, color: Colors.grey.shade500),
        prefixIcon:
            prefix ??
            (icon == null
                ? null
                : Icon(icon, size: 17, color: AppColors.hijau)),
        prefixIconConstraints: const BoxConstraints(minWidth: 42),
        suffixIcon: suffix,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 13,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.hijau, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1),
        ),
        errorStyle: const TextStyle(fontSize: 9),
      ),
    );
  }

  void _submit() {
    final valid = _formKey.currentState?.validate() ?? false;
    if (!valid) return;

    if (!_menyetujuiSyarat) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Setujui syarat dan ketentuan terlebih dahulu'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data valid. Proses verifikasi belum tersedia.'),
      ),
    );
  }
}
