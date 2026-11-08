import 'package:flutter/material.dart';

import 'kit_font.dart';
import 'kit_fonts.dart';

/// متحكّم حالة الخط الحالي في التطبيق.
///
/// يستخدم [ChangeNotifier] حتى تُحدَّث الواجهة تلقائياً عند تغيير الخط:
/// ```dart
/// final kit = FontKit(font: KitFonts.cairo);
/// // ...
/// kit.font = KitFonts.tajawal;              // خط عربي
/// kit.font = KitFonts.poppins;              // خط لاتيني
/// kit.textScale = 1.2;                      // تكبير النص
/// kit.reset();                              // العودة للافتراضي
/// ```
///
/// لتطبيق الخط على كل التطبيق استخدم [applyTo]:
/// ```dart
/// MaterialApp(theme: kit.applyTo(ThemeData.light()));
/// ```
class FontKit extends ChangeNotifier {
  /// ينشئ متحكّماً بالخط [font] (الافتراضي [KitFonts.defaultFont]).
  FontKit({
    KitFont font = KitFonts.defaultFont,
    FontKit? fallback,
    double textScale = 1.0,
  })  : _font = font,
        _fallback = fallback,
        _textScale = textScale;

  KitFont _font;
  FontKit? _fallback;
  double _textScale;

  /// الخط الحالي.
  KitFont get font => _font;

  set font(KitFont value) {
    if (value == _font) return;
    _font = value;
    notifyListeners();
  }

  /// خط احتياطي يستخدم للعناوين الزخرفية أو للأحرف غير المدعومة.
  FontKit? get fallback => _fallback;

  set fallback(FontKit? value) {
    if (identical(value, _fallback)) return;
    _fallback = value;
    notifyListeners();
  }

  /// معامل تكبير/تصغير النص المطبّق على كل التطبيق (بين 0.5 و 3.0).
  double get textScale => _textScale;

  set textScale(double value) {
    final clamped = value.clamp(0.5, 3.0);
    if (clamped == _textScale) return;
    _textScale = clamped;
    notifyListeners();
  }

  /// هل الخط الحالي يدعم العربية؟
  bool get supportsArabic => _font.hasArabic;

  /// يُرجع [ThemeData] منسوخاً من [base] مع تطبيق خط المكتبة عليه.
  ThemeData applyTo(ThemeData base) {
    final family = _font.family;
    TextStyle? withFamily(TextStyle? style) =>
        style?.copyWith(fontFamily: family) ?? TextStyle(fontFamily: family);

    final textTheme = base.textTheme.copyWith(
      displayLarge: withFamily(base.textTheme.displayLarge),
      displayMedium: withFamily(base.textTheme.displayMedium),
      displaySmall: withFamily(base.textTheme.displaySmall),
      headlineLarge: withFamily(base.textTheme.headlineLarge),
      headlineMedium: withFamily(base.textTheme.headlineMedium),
      headlineSmall: withFamily(base.textTheme.headlineSmall),
      titleLarge: withFamily(base.textTheme.titleLarge),
      titleMedium: withFamily(base.textTheme.titleMedium),
      titleSmall: withFamily(base.textTheme.titleSmall),
      bodyLarge: withFamily(base.textTheme.bodyLarge),
      bodyMedium: withFamily(base.textTheme.bodyMedium),
      bodySmall: withFamily(base.textTheme.bodySmall),
      labelLarge: withFamily(base.textTheme.labelLarge),
      labelMedium: withFamily(base.textTheme.labelMedium),
      labelSmall: withFamily(base.textTheme.labelSmall),
    );

    return base.copyWith(
      textTheme: textTheme,
      primaryTextTheme: base.primaryTextTheme.copyWith(
        displayLarge: withFamily(base.primaryTextTheme.displayLarge),
        displayMedium: withFamily(base.primaryTextTheme.displayMedium),
        displaySmall: withFamily(base.primaryTextTheme.displaySmall),
        headlineLarge: withFamily(base.primaryTextTheme.headlineLarge),
        headlineMedium: withFamily(base.primaryTextTheme.headlineMedium),
        headlineSmall: withFamily(base.primaryTextTheme.headlineSmall),
        titleLarge: withFamily(base.primaryTextTheme.titleLarge),
        titleMedium: withFamily(base.primaryTextTheme.titleMedium),
        titleSmall: withFamily(base.primaryTextTheme.titleSmall),
        bodyLarge: withFamily(base.primaryTextTheme.bodyLarge),
        bodyMedium: withFamily(base.primaryTextTheme.bodyMedium),
        bodySmall: withFamily(base.primaryTextTheme.bodySmall),
        labelLarge: withFamily(base.primaryTextTheme.labelLarge),
        labelMedium: withFamily(base.primaryTextTheme.labelMedium),
        labelSmall: withFamily(base.primaryTextTheme.labelSmall),
      ),
      typography: base.typography.copyWith(
        englishLike: base.typography.englishLike.merge(
          TextTheme(bodyMedium: TextStyle(fontFamily: family)),
        ),
        dense: base.typography.dense.merge(
          TextTheme(bodyMedium: TextStyle(fontFamily: family)),
        ),
        tall: base.typography.tall.merge(
          TextTheme(bodyMedium: TextStyle(fontFamily: family)),
        ),
      ),
    );
  }

  /// يعيد الخط للتكوين الافتراضي.
  void reset() {
    _font = KitFonts.defaultFont;
    _fallback = null;
    _textScale = 1.0;
    notifyListeners();
  }

  /// ينقل الخط إلى العائلة اللي بعدها في القائمة (مفيد للأزرار السريعة).
  void next() {
    const list = KitFonts.all;
    final index = list.indexOf(_font);
    _font = list[(index + 1) % list.length];
    notifyListeners();
  }

  /// ينقل الخط إلى العائلة اللي قبلها في القائمة.
  void previous() {
    const list = KitFonts.all;
    final index = list.indexOf(_font);
    _font = list[(index - 1 + list.length) % list.length];
    notifyListeners();
  }
}

/// يوفّر [FontKit] لأبناء الشجرة عبر [InheritedNotifier]، ويُعيد بناء نفسها
/// تلقائياً عند تغيير الخط.
///
/// ```dart
/// FontKitScope(
///   kit: kit,
///   child: MaterialApp(...),
/// );
///
/// // في أي مكان داخل الشجرة:
/// final kit = FontKitScope.of(context);
/// ```
class FontKitScope extends InheritedNotifier<FontKit> {
  /// غلاف يوفّر [kit] لكل الشجرة تحته.
  const FontKitScope({
    super.key,
    required FontKit kit,
    required super.child,
  }) : super(notifier: kit);

  /// المتحكّم الأقرب في الشجرة (يُشترط وجود [FontKitScope] أعلى).
  static FontKit of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<FontKitScope>();
    assert(scope?.notifier != null, 'لا يوجد FontKitScope أعلى هذا الـ context');
    return scope!.notifier!;
  }

  /// المتحكّم الأقرب إن وُجد، وإلا `null`.
  static FontKit? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<FontKitScope>()?.notifier;
}

/// امتدادات مختصرة للوصول إلى الخط الحالي من أي [BuildContext].
extension FontKitContext on BuildContext {
  /// [FontKit] الأقرب من الشجرة.
  FontKit get fontKit => FontKitScope.of(this);

  /// العائلة الخطية الحالية.
  String get currentFontFamily => fontKit.font.family;

  /// [ThemeData] الحالية بعد تطبيق الخط عليها.
  ThemeData get kitTheme => fontKit.applyTo(Theme.of(this));
}
