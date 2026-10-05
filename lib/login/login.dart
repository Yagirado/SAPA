import 'package:flutter/material.dart';
import 'package:sapa/theme/app_colors.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _passwordTersembunyi = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          color: AppColors.latar,
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              child: Column(
                children: [
                  Image.asset(
                    'assets/icons/logo2.png',
                    width: 140,
                    height: 140,
                    fit: BoxFit.contain,
                  ),

                  const Text(
                    'Selamat Datang di\nSAPA ✨',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Masuk dengan akunmu dan mulai temukan atau hibahkan '
                      'perlengkapan kos pertamamu.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x26000000),
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        )
                      ]
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Email / Akun Kampus", 
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 6,),
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.latarInput,
                            hintText: 'nando@unsika.ac.id',
                            prefixIcon: Icon(Icons.alternate_email),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: AppColors.hijau,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        const Text(
                          "Kata Sandi",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 6,),
                        TextField(
                          obscureText: _passwordTersembunyi,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.latarInput,
                            hintText: 'Masukan kata sandi akunmu',
                            prefixIcon: const Icon(Icons.lock_outline),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: AppColors.hijau,
                                width: 1,
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordTersembunyi
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined
                              ),
                                onPressed:  () {
                                  setState(() {
                                    _passwordTersembunyi = !_passwordTersembunyi;
                                  });
                                },
                            ), 
                          ),
                        ),

                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            style: ButtonStyle(
                              overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                              foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                                if (states.contains(WidgetState.pressed)) {
                                  return AppColors.hijau.withValues(alpha: 0.6);
                                }
                                return AppColors.hijau;
                              }),
                            ),
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const LupaPasswordPage(),
                              //   ),
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Fitur lupa password belum tersedia')),
                              );
                            },
                            child: const Text('Lupa Password?'),
                          ),
                        ),

                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.hijau,
                              foregroundColor: Colors.white,
                              overlayColor: Colors.black.withValues(alpha: 0.15),
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                            ),
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const LupaPasswordPage(),
                              //   ),
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Fitur Dashboard belum tersedia')),
                              );
                            },
                            child:
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 6,
                                children: [
                                  Text('Masuk ke SAPA'),
                                  Icon(Icons.arrow_forward)
                                ]
                              ),
                            ),
                        ),

                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Expanded(child: Divider()),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text('atau masuk lebih cepat'),
                            ),
                            const Expanded(child: Divider()),
                          ],
                        ),
                        const SizedBox(height: 16),

                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF0F5F1),
                              foregroundColor: Colors.black,
                              overlayColor: Colors.black.withValues(alpha: 0.15),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const LupaPasswordPage(),
                              //   ),
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Fitur Dashboard belum tersedia')),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/icons/google.png',
                                  width: 22,
                                  height: 22,
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'Masuk dengan Google',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'Belum punya akun? '),
                        TextSpan(
                          text: 'Daftar Sekarang',
                          style: TextStyle(
                            color: AppColors.hijau,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.latarInput,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.verified_user,
                          color: AppColors.hijau,
                          size: 24,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Data mahasiswa & privasi lokasi kosan aman '
                            'terlindungi dengan enkripsi komunitas.',
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
}
