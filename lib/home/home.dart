import 'package:flutter/material.dart';
import 'package:sapa/theme/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.latar,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Image.asset('asset/icons/logo2', height: 32),
      ),
    );
  }
}