import 'package:flutter/material.dart';
import 'package:sapa/login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SAPA',
      theme: ThemeData(
        fontFamily: 'PlusJakartaSans',
      ),
      home: Login(),
    );
  }
}