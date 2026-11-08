import 'package:flutter_fonts_kit/flutter_fonts_kit.dart';
import 'package:flutter_fonts_kit_example/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('التطبيق التجريبي يعرض العنوان وقائمة الخطوط', (tester) async {
    await tester.pumpWidget(const ExampleApp());
    await tester.pumpAndSettle();

    expect(find.text('Flutter Fonts Kit'), findsOneWidget);
    expect(find.text('13 عائلة · 56 وزن', skipOffstage: false), findsOneWidget);
  });

  testWidgets('زر "اختر الخط" يفتح لوحة اختيار الخطوط', (tester) async {
    await tester.pumpWidget(const ExampleApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('اختر الخط'));
    await tester.pumpAndSettle();

    expect(find.byType(FontPickerPage), findsOneWidget);
  });
}
