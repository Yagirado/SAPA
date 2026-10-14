import 'package:flutter/material.dart';
import 'package:sapa/donasi/donasi.dart';
import 'package:sapa/home/home.dart';
import 'package:sapa/explore/explore.dart';
import 'package:sapa/profile/profilesaya.dart';
import 'package:sapa/request/request.dart';
import 'package:sapa/theme/app_colors.dart';

class Bottom extends StatefulWidget {
  const Bottom({super.key});

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int _pindah = 0;

  late final List<Widget> _page = [
    const HomePage(),
    const ExplorePage(),
    const RequestPage(),
    const ProfileSaya(),
    DonasiPage(
      onBack: () {
        _pindahPage(0);
      },
    ),
  ];

  void _pindahPage(int index) {
    setState(() {
      _pindah = index;
    });
  }

  Widget _menu(IconData icon, String label, int index) {
    return Expanded(
      child: InkWell(
        onTap: () {
          _pindahPage(index);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: _pindah == index
                  ? AppColors.hijau
                  : AppColors.hijau.withValues(alpha: 0.6),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: _pindah == index
                    ? FontWeight.bold
                    : FontWeight.normal,
                color: _pindah == index
                    ? AppColors.hijau
                    : AppColors.hijau.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tombolDonasi() {
    return Expanded(
      child: Center(
        child: Transform.translate(
          offset: const Offset(0, -25),
          child: SizedBox(
            width: 50,
            height: 50,
            child: FloatingActionButton(
              heroTag: 'tombolDonasi',
              onPressed: () {
                _pindahPage(4);
              },
              backgroundColor: AppColors.hijau,
              foregroundColor: Colors.white,
              elevation: 4,
              shape: const CircleBorder(),
              child: const Icon(
                Icons.redeem,
                size: 28,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _page[_pindah],
      bottomNavigationBar: _pindah == 4
          ? null
          : BottomAppBar(
              color: Colors.white,
              elevation: 8,
              padding: EdgeInsets.zero,
              child: SizedBox(
                height: 70,
                child: Row(
                  children: [
                    _menu(Icons.home, 'Beranda', 0),
                    _menu(Icons.explore, 'Jelajah', 1),
                    _tombolDonasi(),
                    _menu(Icons.message, 'Permintaan', 2),
                    _menu(Icons.person, 'Profil', 3),
                  ],
                ),
              ),
            ),
    );
  }
}