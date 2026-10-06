import 'package:flutter/material.dart';
import 'package:sapa/home/home.dart';
import 'package:sapa/explore/explore.dart';
import 'package:sapa/profile/profile.dart';
import 'package:sapa/request/request.dart';

class Bottom extends StatefulWidget {
  const Bottom({super.key});

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int _pindah = 0;

  void _pindahPage(int index) {
    setState(() {
      _pindah = index;
    });
  }

  final List<Widget> _page = [
    const HomePage(),
    const ExplorePage(),
    const RequestPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page[_pindah],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _pindah,
        onTap: _pindahPage,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey[500],
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Jelajah"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Permintaan"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }
}