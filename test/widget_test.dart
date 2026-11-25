import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter1/model/login.dart';
import 'package:flutter1/model/produk.dart';
import 'package:flutter1/model/registrasi.dart';
import 'package:flutter1/ui/login_page.dart';
import 'package:flutter1/ui/produk_detail.dart';
import 'package:flutter1/ui/produk_form.dart';
import 'package:flutter1/ui/registrasi_page.dart';
import 'package:flutter1/widget/success_dialog.dart';
import 'package:flutter1/widget/warning_dialog.dart';

void main() {
  group('Model JSON Parsing (Type-Casting Resilience)', () {
    test('Login.fromJson menangani integer maupun string ID dan error response',
        () {
      final Login success = Login.fromJson({
        'code': 200,
        'status': true,
        'data': {
          'token': 'abc123token',
          'user': {'id': '1', 'email': 'admin@admin.com'},
        },
      });
      expect(success.code, 200);
      expect(success.status, true);
      expect(success.token, 'abc123token');
      expect(success.userID, 1);
      expect(success.userEmail, 'admin@admin.com');

      final Login failed = Login.fromJson({
        'code': 400,
        'status': false,
        'data': 'Email tidak ditemukan',
      });
      expect(failed.code, 400);
      expect(failed.status, false);
      expect(failed.token, isNull);
    });

    test('Registrasi.fromJson mem-parse response dengan benar', () {
      final Registrasi reg = Registrasi.fromJson({
        'code': 200,
        'status': true,
        'data': 'Registrasi Berhasil',
      });
      expect(reg.code, 200);
      expect(reg.status, true);
      expect(reg.data, 'Registrasi Berhasil');
    });

    test('Produk.fromJson menangani id dan harga bertipe string maupun int', () {
      final Produk dariString = Produk.fromJson({
        'id': '1',
        'kode_produk': 'A001',
        'nama_produk': 'Realme Smart TV',
        'harga': '5700000',
      });
      expect(dariString.id, 1);
      expect(dariString.kodeProduk, 'A001');
      expect(dariString.namaProduk, 'Realme Smart TV');
      expect(dariString.hargaProduk, 5700000);

      final Produk dariInt = Produk.fromJson({
        'id': 2,
        'kode_produk': 'A002',
        'nama_produk': 'Kulkas',
        'harga': 2500000,
      });
      expect(dariInt.id, 2);
      expect(dariInt.hargaProduk, 2500000);
    });
  });

  group('UI & Dialog Widgets', () {
    testWidgets('LoginPage merender form dan validasi input kosong',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LoginPage()),
      );

      expect(find.widgetWithText(AppBar, 'Login'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);

      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pumpAndSettle();

      expect(find.text('Email harus diisi'), findsOneWidget);
      expect(find.text('Password harus diisi'), findsOneWidget);
    });

    testWidgets('RegistrasiPage merender form dan validasi input tidak valid',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: RegistrasiPage()),
      );

      expect(find.widgetWithText(AppBar, 'Registrasi'), findsOneWidget);

      await tester.enterText(find.byType(TextFormField).at(0), 'ab');
      await tester.enterText(find.byType(TextFormField).at(1), 'bukan-email');
      await tester.enterText(find.byType(TextFormField).at(2), '123');
      await tester.enterText(find.byType(TextFormField).at(3), '456');

      await tester.tap(find.widgetWithText(ElevatedButton, 'Registrasi'));
      await tester.pumpAndSettle();

      expect(find.text('Nama harus diisi minimal 3 karakter'), findsOneWidget);
      expect(find.text('Email tidak valid'), findsOneWidget);
      expect(find.text('Password harus diisi minimal 6 karakter'), findsOneWidget);
      expect(find.text('Konfirmasi Password tidak sama'), findsOneWidget);
    });

    testWidgets('ProdukForm merender mode Tambah dan Ubah dengan benar',
        (WidgetTester tester) async {
      // Mode Tambah
      await tester.pumpWidget(
        const MaterialApp(home: ProdukForm()),
      );
      expect(find.text('TAMBAH PRODUK'), findsOneWidget);
      expect(find.text('SIMPAN'), findsOneWidget);

      // Mode Ubah
      final Produk dummy = Produk(
        id: 10,
        kodeProduk: 'P999',
        namaProduk: 'Test Item',
        hargaProduk: 99000,
      );
      await tester.pumpWidget(
        MaterialApp(home: ProdukForm(produk: dummy)),
      );
      expect(find.text('UBAH PRODUK'), findsOneWidget);
      expect(find.text('UBAH'), findsOneWidget);
      expect(find.text('P999'), findsOneWidget);
      expect(find.text('Test Item'), findsOneWidget);
      expect(find.text('99000'), findsOneWidget);
    });

    testWidgets('ProdukDetail merender informasi dan tombol aksi',
        (WidgetTester tester) async {
      final Produk dummy = Produk(
        id: 1,
        kodeProduk: 'K001',
        namaProduk: 'Kamera Digital',
        hargaProduk: 4500000,
      );

      await tester.pumpWidget(
        MaterialApp(home: ProdukDetail(produk: dummy)),
      );

      expect(find.text('Detail Produk'), findsOneWidget);
      expect(find.text('Kode : K001'), findsOneWidget);
      expect(find.text('Nama : Kamera Digital'), findsOneWidget);
      expect(find.text('Harga : Rp. 4500000'), findsOneWidget);
      expect(find.text('EDIT'), findsOneWidget);
      expect(find.text('DELETE'), findsOneWidget);
    });

    testWidgets('SuccessDialog dan WarningDialog merender konten dan aksi OK',
        (WidgetTester tester) async {
      bool okClicked = false;
      await tester.pumpWidget(
        MaterialApp(
          home: SuccessDialog(
            description: 'Operasi sukses',
            okClick: () => okClicked = true,
          ),
        ),
      );

      expect(find.text('SUKSES'), findsOneWidget);
      expect(find.text('Operasi sukses'), findsOneWidget);
      await tester.tap(find.text('OK'));
      expect(okClicked, isTrue);

      await tester.pumpWidget(
        const MaterialApp(
          home: WarningDialog(
            description: 'Operasi gagal',
          ),
        ),
      );

      expect(find.text('GAGAL'), findsOneWidget);
      expect(find.text('Operasi gagal'), findsOneWidget);
    });
  });
}
