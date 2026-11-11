import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter1/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('Alur login, local storage, dan sidemenu Home/About',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Halaman awal harus LoginPage
    expect(find.widgetWithText(AppBar, 'Login'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);

    // Uji login dengan kredensial salah
    await tester.enterText(find.byType(TextField).at(0), 'user');
    await tester.enterText(find.byType(TextField).at(1), 'salah');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();

    expect(find.text('Username dan Password Salah'), findsOneWidget);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    // Tetap di halaman LoginPage
    expect(find.widgetWithText(AppBar, 'Login'), findsOneWidget);

    // Uji login dengan kredensial benar (admin / admin)
    await tester.enterText(find.byType(TextField).at(0), 'admin');
    await tester.enterText(find.byType(TextField).at(1), 'admin');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();

    expect(find.text('Anda Berhasil Login'), findsOneWidget);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    // Masuk ke HomePage dan menampilkan username dari SharedPreferences
    expect(find.widgetWithText(AppBar, 'Home Page'), findsOneWidget);
    expect(find.text('Ini adalah halaman User admin'), findsOneWidget);

    // Pastikan username tersimpan di SharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('username'), 'admin');

    // Buka Sidemenu: hanya berisi Home dan About
    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
    expect(find.text('Sidemenu'), findsOneWidget);
    expect(find.descendant(of: find.byType(Drawer), matching: find.byType(ListTile)),
        findsNWidgets(2));
    expect(find.descendant(of: find.byType(Drawer), matching: find.text('Home')),
        findsOneWidget);
    expect(find.descendant(of: find.byType(Drawer), matching: find.text('About')),
        findsOneWidget);

    // Navigasi ke AboutPage lalu kembali ke HomePage
    await tester.tap(find.text('About'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(AppBar, 'About Page'), findsOneWidget);
    expect(find.text('Ini adalah halaman About'), findsOneWidget);

    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(AppBar, 'Home Page'), findsOneWidget);
  });
}
