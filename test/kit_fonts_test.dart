import 'package:flutter/material.dart';
import 'package:flutter_fonts_kit/flutter_fonts_kit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('KitFonts registry', () {
    test('يسجّل 13 عائلة خطية', () {
      expect(KitFonts.all, hasLength(13));
      expect(KitFonts.count, 13);
    });

    test('أسماء العائلات فريدة', () {
      final families = KitFonts.all.map((f) => f.family).toSet();
      expect(families, hasLength(KitFonts.all.length));
    });

    test('كل عائلة لها وزن واحد على الأقل وأوزان صحيحة', () {
      for (final font in KitFonts.all) {
        expect(font.weights, isNotEmpty, reason: font.family);
        for (final w in font.weights) {
          expect(w, inInclusiveRange(100, 900), reason: font.family);
          expect(w % 100, 0, reason: '${font.family}: $w ليس من مضاعفات 100');
        }
      }
    });

    test('التقسيم عربي/لاتيني متسق', () {
      expect(KitFonts.arabic, hasLength(9));
      expect(KitFonts.latin, hasLength(4));
      expect(KitFonts.arabic.every((f) => f.hasArabic), isTrue);
      expect(KitFonts.latin.every((f) => !f.hasArabic), isTrue);
    });

    test('byFamily يُرجع العائلة المطلوبة أو الافتراضية', () {
      expect(KitFonts.byFamily('Cairo'), KitFonts.cairo);
      expect(KitFonts.byFamily('خط-غير-موجود'), KitFonts.defaultFont);
    });

    test('byCategory يُصفّي بشكل صحيح', () {
      final kufi = KitFonts.byCategory(KitFontCategory.kufi);
      expect(kufi.map((f) => f.family), containsAll(['Noto Kufi Arabic', 'Reem Kufi']));
    });

    test('البحث النصي يعمل بالعربية والإنجليزية', () {
      expect(KitFonts.cairo.matches('قاهرة'), isTrue);
      expect(KitFonts.cairo.matches('cairo'), isTrue);
      expect(KitFonts.cairo.matches('  '), isTrue);
      expect(KitFonts.cairo.matches('zzz'), isFalse);
      expect(KitFonts.cairo.matches('كوفي'), isFalse);
    });

    test('تحويل الأرقام إلى FontWeight صحيح', () {
      expect(kitFontWeight(400), FontWeight.w400);
      expect(kitFontWeight(700), FontWeight.w700);
      expect(KitFonts.cairo.lightest, FontWeight.w200);
      expect(KitFonts.cairo.heaviest, FontWeight.w900);
    });

    test('textStyle يحمل اسم العائلة', () {
      final style = KitFonts.amiri.textStyle(fontSize: 22, fontWeight: FontWeight.w700);
      expect(style.fontFamily, 'Amiri');
      expect(style.fontSize, 22);
      expect(style.fontWeight, FontWeight.w700);
    });
  });

  group('FontKit controller', () {
    test('يبدأ بالخط الافتراضي ويُخطر المستمعين عند التغيير', () {
      final kit = FontKit();
      var notifications = 0;
      kit.addListener(() => notifications++);

      expect(kit.font, KitFonts.defaultFont);

      kit.font = KitFonts.tajawal;
      expect(kit.font, KitFonts.tajawal);
      expect(notifications, 1);

      // نفس الخط لا يُطلق إشعاراً
      kit.font = KitFonts.tajawal;
      expect(notifications, 1);

      kit.textScale = 1.4;
      expect(kit.textScale, 1.4);
      expect(notifications, 2);

      kit.textScale = 99; // تُقصّ عند 3.0
      expect(kit.textScale, 3.0);

      kit.reset();
      expect(kit.font, KitFonts.defaultFont);
      expect(kit.textScale, 1.0);
    });

    test('next/previous يتنقلان دائرياً بين العائلات', () {
      final kit = FontKit(font: KitFonts.all.last);
      kit.next();
      expect(kit.font, KitFonts.all.first);

      kit.previous();
      expect(kit.font, KitFonts.all.last);
    });

    test('applyTo يطبّق عائلة الخط على TextTheme كاملة', () {
      final kit = FontKit(font: KitFonts.amiri);
      final theme = kit.applyTo(ThemeData.light(useMaterial3: true));
      final text = theme.textTheme;

      for (final style in [
        text.displayLarge,
        text.headlineMedium,
        text.titleLarge,
        text.bodyMedium,
        text.labelSmall,
      ]) {
        expect(style?.fontFamily, 'Amiri');
      }
    });

    test('supportsArabic يعكس خصائص الخط', () {
      expect(FontKit(font: KitFonts.poppins).supportsArabic, isFalse);
      expect(FontKit(font: KitFonts.cairo).supportsArabic, isTrue);
    });
  });
}
