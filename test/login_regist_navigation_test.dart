import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sapa/login/login.dart';

void main() {
  testWidgets('Daftar Sekarang opens the registration page', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: Login()));

    final signupButton = find.text('Daftar Sekarang');
    await tester.ensureVisible(signupButton);
    await tester.tap(signupButton);
    await tester.pumpAndSettle();

    expect(find.byTooltip('Kembali ke login'), findsOneWidget);
    expect(find.text('Daftar Akun KosBerbagi 🌱'), findsOneWidget);
    expect(find.text('Belum punya akun?'), findsNothing);
  });
}
