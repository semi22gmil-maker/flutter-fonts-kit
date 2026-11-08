import 'package:flutter/material.dart';
import 'package:flutter_fonts_kit/flutter_fonts_kit.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _wrap(Widget child, {FontKit? kit}) {
  final controller = kit ?? FontKit();
  return FontKitScope(
    kit: controller,
    child: MaterialApp(
      theme: controller.applyTo(ThemeData.light(useMaterial3: true)),
      home: Scaffold(body: child),
    ),
  );
}

void main() {
  testWidgets('KitText يستخدم الخط الحالي من FontKitScope', (tester) async {
    await tester.pumpWidget(_wrap(
      const KitText('مرحباً', size: 30),
      kit: FontKit(font: KitFonts.tajawal),
    ));

    final text = tester.widget<Text>(find.text('مرحباً'));
    expect(text.style?.fontFamily, 'Tajawal');
    expect(text.style?.fontSize, 30);
  });

  testWidgets('KitText يحترم الخط الصريح ويتجاهل الـ scope', (tester) async {
    await tester.pumpWidget(_wrap(
      const KitText('عنوان', font: KitFonts.reemKufi),
      kit: FontKit(font: KitFonts.tajawal),
    ));

    final text = tester.widget<Text>(find.text('عنوان'));
    expect(text.style?.fontFamily, 'Reem Kufi');
  });

  testWidgets('FontSpecimen يعرض اسم الخط العربي والإنجليزي والأوزان',
      (tester) async {
    await tester.pumpWidget(_wrap(
      const FontSpecimen(font: KitFonts.ibmPlexSansArabic),
    ));

    expect(find.text('آي بي إم بلكس'), findsOneWidget);
    expect(find.text('IBM Plex Sans Arabic'), findsOneWidget);
    expect(find.text('100'), findsOneWidget);
    expect(find.text('700'), findsOneWidget);
    expect(find.text('نوتو كوفي'), findsNothing);
  });

  testWidgets('FontSpecimen ينفّذ onTap', (tester) async {
    var tapped = false;
    await tester.pumpWidget(_wrap(
      FontSpecimen(font: KitFonts.cairo, onTap: () => tapped = true),
    ));

    await tester.tap(find.byType(FontSpecimen));
    await tester.pumpAndSettle();
    expect(tapped, isTrue);
  });

  testWidgets('FontPickerPage يبحث ويختار ويطبّق على FontKit', (tester) async {
    final kit = FontKit(font: KitFonts.cairo);
    await tester.pumpWidget(_wrap(FontPickerButton(kit: kit)));
    await tester.pumpAndSettle();

    // افتح المنتقي
    await tester.tap(find.byType(FontPickerButton));
    await tester.pumpAndSettle();
    expect(find.byType(FontPickerPage), findsOneWidget);

    // ابحث عن "أميري" ثم اختره
    await tester.enterText(find.byType(TextField), 'أميري');
    await tester.pumpAndSettle();
    expect(find.text('Amiri'), findsOneWidget);
    expect(find.text('Cairo'), findsNothing);

    await tester.tap(find.text('Amiri'));
    await tester.pumpAndSettle();

    expect(kit.font, KitFonts.amiri);
    expect(find.byType(FontPickerPage), findsNothing);
  });

  testWidgets('تبويب "لاتيني" يُخفي الخطوط العربية', (tester) async {
    await tester.pumpWidget(_wrap(
      const FontPickerPage(onSelected: _noop),
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.text('لاتيني'));
    await tester.pumpAndSettle();

    expect(find.text('Poppins'), findsOneWidget);
    expect(find.text('Cairo'), findsNothing);
  });

  testWidgets('FontKitScope.of يعمل داخل الشجرة', (tester) async {
    final kit = FontKit(font: KitFonts.almarai);
    FontKit? fromContext;

    await tester.pumpWidget(_wrap(
      Builder(builder: (context) {
        fromContext = context.fontKit;
        return Text(context.currentFontFamily);
      }),
      kit: kit,
    ));

    expect(fromContext, same(kit));
    expect(find.text('Almarai'), findsOneWidget);
  });
}

void _noop(KitFont font) {}
