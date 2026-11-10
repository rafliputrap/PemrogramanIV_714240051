import 'package:flutter_test/flutter_test.dart';
import 'package:praktikum/material_app.dart';

void main() {
  testWidgets('Menampilkan Hello ULBI',
      (WidgetTester tester) async {
    await tester.pumpWidget(const AppMaterial());

    expect(find.text('Hello ULBI'), findsOneWidget);
    expect(find.text('Perbesar'), findsOneWidget);
  });
}
