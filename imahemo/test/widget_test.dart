import 'package:flutter_test/flutter_test.dart';

import 'package:imahemo/main.dart';

void main() {
  testWidgets('Home page renders smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('IMAHEMO'), findsOneWidget);
    expect(find.text('Local Engine Status'), findsOneWidget);
    expect(find.text('Recent Creation Sessions'), findsOneWidget);
  });

  testWidgets('Library nav opens the library page', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Library'));
    await tester.pumpAndSettle();

    expect(find.text('Offline Book Catalog'), findsOneWidget);
  });
}
