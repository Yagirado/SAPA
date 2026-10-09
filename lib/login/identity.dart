import 'package:flutter/material.dart';
import 'package:sapa/home/home.dart';
import 'package:sapa/theme/app_colors.dart';

class Identity extends StatefulWidget {
  const Identity({super.key});

  @override
  State<Identity> createState() => _IdentityState();
}

class _IdentityState extends State<Identity> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _fakultasController = TextEditingController();
  final _programStudiController = TextEditingController();
  final _nimController = TextEditingController();
  final _areaKosController = TextEditingController();
  String? _tahunMasuk;

  static const _kampus = [
    'Universitas Indonesia (UI) - Depok',
    'Universitas Singaperbangsa Karawang (UNSIKA)',
    'Institut Teknologi Bandung (ITB)',
    'Universitas Gadjah Mada (UGM)',
    'Universitas Padjadjaran (UNPAD)',
    'Universitas Brawijaya (UB)',
  ];

  static const _tahunMasukOptions = [
    '2018',
    '2019',
    '2020',
    '2021',
    '2022',
    '2023',
    '2024',
    '2025',
    '2026',
  ];

  @override
  void dispose() {
    _namaController.dispose();
    _fakultasController.dispose();
    _programStudiController.dispose();
    _nimController.dispose();
    _areaKosController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.latar,
      body: SafeArea(
        child: Container(
          width: double.infinity,
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
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, size: 24),
                        color: const Color(0xFF1D2522),
                        tooltip: 'Kembali',
                        onPressed: () => Navigator.of(context).maybePop(),
                      ),
                      const SizedBox(width: 4),
                      const Expanded(
                        child: Text(
                          'Lengkapi Identitas Mahasiswa ',
                          style: TextStyle(
                            fontSize: 18,
                            height: 1.25,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF15221D),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(14, 16, 14, 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x10000000),
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  CircleAvatar(
                                    radius: 39,
                                    backgroundColor: const Color(0xFFEAF1EC),
                                    backgroundImage:
                                        const AssetImage('assets/images/fahri.png'),
                                  ),
                                  Positioned(
                                    right: -2,
                                    bottom: -1,
                                    child: Container(
                                      width: 29,
                                      height: 29,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF08734F),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.camera_alt_outlined,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Foto Profil Mahasiswa',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        _label('Nama Lengkap (Sesuai KTM)'),
                        const SizedBox(height: 6),
                        _textField(
                          controller: _namaController,
                          hint: 'cth: Andi Pratama',
                          icon: Icons.badge_outlined,
                          validator: (value) => _required(value, 'Nama lengkap'),
                        ),
                        const SizedBox(height: 12),
                        _label('Perguruan Tinggi / Kampus'),
                        const SizedBox(height: 6),
                        _campusField(),
                        const SizedBox(height: 12),
                        _label('Fakultas'),
                        const SizedBox(height: 6),
                        _textField(
                          controller: _fakultasController,
                          hint: 'cth: Fakultas Ilmu Komputer',
                          icon: Icons.account_balance_outlined,
                          validator: (value) => _required(value, 'Fakultas'),
                        ),
                        const SizedBox(height: 12),
                        _label('Program Studi'),
                        const SizedBox(height: 6),
                        _textField(
                          controller: _programStudiController,
                          hint: 'cth: Teknik Komputer',
                          icon: Icons.menu_book_outlined,
                          validator: (value) => _required(value, 'Program studi'),
                        ),
                        const SizedBox(height: 12),
                        _label('Nomor Induk Mahasiswa (NIM)'),
                        const SizedBox(height: 6),
                        _textField(
                          controller: _nimController,
                          hint: 'Masukkan NIM',
                          icon: Icons.pin_outlined,
                          keyboardType: TextInputType.number,
                          validator: (value) => _required(value, 'NIM'),
                        ),
                        const SizedBox(height: 12),
                        _label('Tahun Masuk / Angkatan'),
                        const SizedBox(height: 6),
                        _dropdownField(
                          value: _tahunMasuk,
                          options: _tahunMasukOptions,
                          hint: 'Pilih tahun masuk',
                          icon: Icons.calendar_today_outlined,
                          validator: (value) => _required(value, 'Tahun masuk'),
                          onChanged: (value) => setState(() => _tahunMasuk = value),
                        ),
                        const SizedBox(height: 12),
                        _label('Area Kos Mahasiswa'),
                        const SizedBox(height: 6),
                        _textField(
                          controller: _areaKosController,
                          hint: 'Contoh: Perum Mahkota',
                          icon: Icons.location_on_outlined,
                          validator: (value) => _required(value, 'Area kos'),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Alamat ringkas dipakai sebagai perkiraan rute jarak bagi teman kos yang ingin mengambil barang.',
                          style: TextStyle(
                            fontSize: 10,
                            height: 1.4,
                            color: Color(0xFF617067),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F6F2),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.verified_user_outlined,
                                color: Color(0xFF08734F),
                                size: 19,
                              ),
                              SizedBox(width: 9),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '100% Data Mahasiswa Terlindungi',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Alamat detail kosmu tidak akan pernah dibagikan ke publik sebelum kamu menyetujui jadwal serah terima barang secara mutual.',
                                      style: TextStyle(
                                        fontSize: 10,
                                        height: 1.4,
                                        color: Color(0xFF617067),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        SizedBox(
                          width: double.infinity,
                          height: 46,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.hijau,
                              foregroundColor: Colors.white,
                              shape: const StadiumBorder(),
                            ),
                            onPressed: _submit,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Simpan & Lanjutkan ke SAPA',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_forward, size: 18),
                              ],
                            ),
                          ),
                        ),
                      ],
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

  Widget _campusField() {
    return Autocomplete<String>(
      optionsBuilder: (textEditingValue) {
        final query = textEditingValue.text.trim().toLowerCase();
        if (query.isEmpty) return _kampus;
        return _kampus.where((campus) => campus.toLowerCase().contains(query));
      },
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
        return TextFormField(
          controller: controller,
          focusNode: focusNode,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) => onFieldSubmitted(),
          validator: (value) => _required(value, 'Perguruan tinggi / kampus'),
          style: const TextStyle(fontSize: 12),
          decoration: _inputDecoration(
            hint: 'Ketik atau pilih kampus',
            icon: Icons.school_outlined,
            suffix: const Icon(Icons.unfold_more, size: 19),
          ),
        );
      },
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required String? Function(String?) validator,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      validator: validator,
      style: const TextStyle(fontSize: 12),
      decoration: _inputDecoration(hint: hint, icon: icon),
    );
  }

  Widget _dropdownField({
    required String? value,
    required List<String> options,
    required String hint,
    required IconData icon,
    required String? Function(String?) validator,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      isExpanded: true,
      icon: const Icon(Icons.keyboard_arrow_down, size: 20),
      validator: validator,
      onChanged: onChanged,
      style: const TextStyle(fontSize: 12, color: Color(0xFF26352D)),
      decoration: _inputDecoration(hint: hint, icon: icon),
      items: options
          .map(
            (option) => DropdownMenuItem<String>(
              value: option,
              child: Text(option, maxLines: 2, overflow: TextOverflow.ellipsis),
            ),
          )
          .toList(),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      isDense: true,
      filled: true,
      fillColor: const Color(0xFFF0F5F1),
      hintText: hint,
      hintStyle: TextStyle(fontSize: 11, color: Colors.grey.shade600),
      prefixIcon: Icon(icon, size: 17, color: const Color(0xFF28644F)),
      suffixIcon: suffix,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
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
        borderSide: const BorderSide(color: Color(0xFF08734F), width: 1),
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
    );
  }

  Widget _label(String label) {
    return Text.rich(
      TextSpan(
        text: '$label ',
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
        children: const [
          TextSpan(text: '*', style: TextStyle(color: Colors.red)),
        ],
      ),
    );
  }

  String? _required(String? value, String label) {
    if (value == null || value.trim().isEmpty) return '$label wajib diisi';
    return null;
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => const HomePage(),
      ),
    );
  }
}
