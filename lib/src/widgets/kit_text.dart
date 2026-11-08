import 'package:flutter/widgets.dart';

import '../font_kit.dart';
import '../kit_font.dart';

/// ودجت نص جاهز يستخدم الخط الحالي من [FontKitScope] تلقائياً.
///
/// ```dart
/// KitText('مرحباً بالعالم', size: 24, bold: true);
/// KitText('العنوان', font: KitFonts.reemKufi, size: 32);
/// ```
class KitText extends StatelessWidget {
  /// ينشئ نصاً بخط المكتبة.
  const KitText(
    this.text, {
    super.key,
    this.font,
    this.size,
    this.weight,
    this.color,
    this.bold = false,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.height,
    this.letterSpacing,
    this.softWrap,
  });

  /// النص المطلوب عرضه.
  final String text;

  /// خط محدّد؛ إن كان `null` يُستخدم الخط الحالي من [FontKitScope]
  /// أو [KitFonts.defaultFont] إن لم يوجد scope.
  final KitFont? font;

  /// حجم الخط.
  final double? size;

  /// وزن الخط.
  final FontWeight? weight;

  /// لون النص.
  final Color? color;

  /// اختصار لوزن عريض (700).
  final bool bold;

  /// أقصى عدد أسطر.
  final int? maxLines;

  /// محاذاة النص.
  final TextAlign? textAlign;

  /// سلوك تجاوز النص.
  final TextOverflow? overflow;

  /// ارتفاع السطر.
  final double? height;

  /// تباعد الحروف.
  final double? letterSpacing;

  /// السماح بالالتفاف.
  final bool? softWrap;

  @override
  Widget build(BuildContext context) {
    final kit = FontKitScope.maybeOf(context);
    final family = font?.family ?? kit?.font.family ?? ClipKitDefaults.fontFamily;
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      softWrap: softWrap,
      style: TextStyle(
        fontFamily: family,
        fontSize: size,
        fontWeight: weight ?? (bold ? FontWeight.w700 : null),
        color: color ?? DefaultTextStyle.of(context).style.color,
        height: height,
        letterSpacing: letterSpacing,
      ),
    );
  }
}

/// قيم افتراضية داخلية تُستخدم عند عدم توفّر [FontKitScope].
abstract final class ClipKitDefaults {
  /// عائلة الخط الافتراضية.
  static const String fontFamily = 'Cairo';
}
