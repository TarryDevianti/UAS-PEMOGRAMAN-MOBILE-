import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uas_tarrydevianti/main.dart';

void main() {
  testWidgets('Kalkulator UI Test', (WidgetTester tester) async {
    // Membangun aplikasi KalkulatorPinkApp
    await tester.pumpWidget(KalkulatorPinkApp());

    // Memastikan judul aplikasi muncul
    expect(find.text('Pinky Calculator ✨'), findsOneWidget);
    
    // Memastikan teks "HASIL" ada di layar
    expect(find.text('HASIL'), findsOneWidget);
  });
}