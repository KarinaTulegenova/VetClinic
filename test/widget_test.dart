import 'package:flutter_test/flutter_test.dart';

import 'package:release_ready_flutter_app/main.dart';

void main() {
  testWidgets('PetGuardian opens on the splash screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const PetGuardianApp());

    expect(find.text('PetGuardian'), findsOneWidget);
  });
}
