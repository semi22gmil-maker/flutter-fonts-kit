import 'package:flutter/material.dart';

/// يحوّل رقماً (100..900) إلى [FontWeight] المطابق.
FontWeight kitFontWeight(int weight) {
  const weights = FontWeight.values; // w100 .. w900 بالترتيب
  final index = (weight ~/ 100 - 1).clamp(0, weights.length - 1);
  return weights[index];
}

/// تصنيفات الخطوط العربية واللاتينية داخل المكتبة.
enum KitFontCategory {
  /// خطوط عربية حديثة بلا زخرفة مناسبة للواجهات (Cairo، Almarai…).
  sans('بلا زخرفة', 'Sans Serif'),

  /// خطوط كوفية هندسية.
  kufi('كوفي', 'Kufi'),

  /// خطوط نسخية كلاسيكية.
  naskh('نسخ', 'Naskh'),

  /// خطوط رقعة/ديواني زخرفية للعناوين.
  display('زخرفي', 'Display'),

  /// خطوط لاتينية بلا زخرفة.
  latinSans('لاتيني بلا زخرفة', 'Latin Sans'),

  /// خطوط لاتينية زخرفية/هندسية.
  latinDisplay('لاتيني هندسي', 'Latin Display');

  const KitFontCategory(this.labelAr, this.labelEn);

  /// الاسم العربي للتصنيف.
  final String labelAr;

  /// الاسم الإنجليزي للتصنيف.
  final String labelEn;

  /// أيقونة مناسبة لعرض التصنيف في الواجهات.
  IconData get icon => switch (this) {
        KitFontCategory.sans => Icons.text_fields_rounded,
        KitFontCategory.kufi => Icons.grid_view_rounded,
        KitFontCategory.naskh => Icons.menu_book_rounded,
        KitFontCategory.display => Icons.brush_rounded,
        KitFontCategory.latinSans => Icons.abc_rounded,
        KitFontCategory.latinDisplay => Icons.auto_awesome_rounded,
      };
}

/// وصف عائلة خطية واحدة داخل المكتبة.
///
/// كل كائن يمثّل عائلة مسجّلة في `pubspec.yaml` تحت `flutter: fonts:`.
@immutable
class KitFont {
  /// ينشئ وصف عائلة خطية.
  const KitFont({
    required this.family,
    required this.nameAr,
    required this.nameEn,
    required this.category,
    required this.weights,
    this.hasArabic = true,
    this.hasLatin = true,
    this.descriptionAr = '',
    this.descriptionEn = '',
    this.designerNoteAr = '',
  });

  /// اسم العائلة كما هو مسجّل في `pubspec.yaml` (يُمرَّر إلى `fontFamily`).
  final String family;

  /// الاسم العربي المعروض للمستخدم.
  final String nameAr;

  /// الاسم الإنجليزي المعروض للمستخدم.
  final String nameEn;

  /// تصنيف الخط.
  final KitFontCategory category;

  /// الأوزان المتوفرة في هذه العائلة، مثل `[400, 700]`.
  final List<int> weights;

  /// هل يدعم الخط الحروف العربية؟
  final bool hasArabic;

  /// هل يدعم الخط الحروف اللاتينية؟
  final bool hasLatin;

  /// وصف عربي قصير يظهر في شاشة الاختيار.
  final String descriptionAr;

  /// وصف إنجليزي قصير.
  final String descriptionEn;

  /// ملاحظة عن استخدام الخط (مثل: مناسب للعناوين).
  final String designerNoteAr;

  /// الأوزان ككائنات [FontWeight] جاهزة للاستخدام.
  List<FontWeight> get fontWeights => weights.map(kitFontWeight).toList();

  /// أخف وزن متاح.
  FontWeight get lightest => kitFontWeight(weights.reduce((a, b) => a < b ? a : b));

  /// أثقل وزن متاح.
  FontWeight get heaviest => kitFontWeight(weights.reduce((a, b) => a > b ? a : b));

  /// هل العائلة تدعم كل الأوزان القياسية (100..900)؟
  bool get isFullRange => weights.length >= 9;

  /// إنشاء [TextStyle] بهذه العائلة مع خصائص اختيارية.
  TextStyle textStyle({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
    FontStyle? fontStyle,
    List<Shadow>? shadows,
  }) {
    return TextStyle(
      fontFamily: family,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
      decoration: decoration,
      fontStyle: fontStyle,
      shadows: shadows,
    );
  }

  /// بحث نصي بسيط (عربي أو إنجليزي) يُستخدم في واجهة الاختيار.
  bool matches(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return true;
    return family.toLowerCase().contains(q) ||
        nameAr.toLowerCase().contains(q) ||
        nameEn.toLowerCase().contains(q) ||
        category.labelAr.contains(q) ||
        category.labelEn.toLowerCase().contains(q) ||
        descriptionAr.contains(q);
  }

  @override
  bool operator ==(Object other) => other is KitFont && other.family == family;

  @override
  int get hashCode => family.hashCode;

  @override
  String toString() => 'KitFont($family, weights: $weights)';
}
