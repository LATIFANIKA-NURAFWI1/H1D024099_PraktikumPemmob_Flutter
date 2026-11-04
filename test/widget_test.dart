import 'package:flutter_test/flutter_test.dart';

import 'package:flutter1/main.dart';

void main() {
  testWidgets('ProdukForm smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our app displays Form Produk.
    expect(find.text('Form Produk'), findsOneWidget);
    expect(find.text('Simpan'), findsOneWidget);
  });
}
