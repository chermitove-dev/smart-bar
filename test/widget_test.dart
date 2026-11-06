import 'package:flutter_test/flutter_test.dart';
import 'package:smart_bar/main.dart';

void main() {
  testWidgets('SMART BAR home screen renders', (tester) async {
    await tester.pumpWidget(const SmartBarApp());
    expect(find.text('SMART BAR'), findsWidgets);
    expect(find.text('اختر نوع العرض'), findsOneWidget);
  });
}
