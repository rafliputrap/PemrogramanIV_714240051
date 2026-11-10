import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:praktikum/main.dart';

void main() {
  testWidgets('app navigates through practicum features', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Input Widget'), findsOneWidget);

    await tester.tap(find.text('Form Input'));
    await tester.pumpAndSettle();
    expect(find.text('List Data'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'rafli@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'Rafli');
    await tester.tap(find.text('Submit'));
    await tester.pumpAndSettle();
    expect(find.text('Rafli'), findsOneWidget);
    expect(find.text('rafli@example.com'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.edit));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(1), 'Rafli Baru');
    await tester.tap(find.text('Update'));
    await tester.pumpAndSettle();
    expect(find.text('Rafli Baru'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Hapus'));
    await tester.pumpAndSettle();
    expect(find.text('Rafli Baru'), findsNothing);

    await tester.tap(find.text('Advanced Form'));
    await tester.pumpAndSettle();
    expect(find.text('Interactive Widget'), findsOneWidget);
    expect(find.text('Pick File'), findsOneWidget);
  });
}
