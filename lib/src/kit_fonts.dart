import 'kit_font.dart';

/// سجلّ كل الخطوط المضمّنة في Flutter Fonts Kit.
///
/// استخدام مباشر:
/// ```dart
/// Text('مرحباً', style: TextStyle(fontFamily: KitFonts.cairo.family));
/// ```
///
/// أو الاعتماد على [KitFonts.arabic] / [KitFonts.latin] للتصفية.
abstract final class KitFonts {
  // ───────────────────────────── خطوط عربية ─────────────────────────────

  /// Cairo — خط عربي حديث متوازن للواجهات والنصوص.
  static const KitFont cairo = KitFont(
    family: 'Cairo',
    nameAr: 'القاهرة',
    nameEn: 'Cairo',
    category: KitFontCategory.sans,
    weights: [200, 300, 400, 600, 700, 900],
    descriptionAr: 'خط عربي هندسي حديث، الأكثر استخداماً في واجهات التطبيقات.',
    descriptionEn: 'A modern geometric Arabic sans, the most popular UI choice.',
    designerNoteAr: 'ممتاز للعناوين والنصوص معاً.',
  );

  /// Tajawal — خط عربي واضح بسبعة أوزان.
  static const KitFont tajawal = KitFont(
    family: 'Tajawal',
    nameAr: 'تجوال',
    nameEn: 'Tajawal',
    category: KitFontCategory.sans,
    weights: [200, 300, 400, 500, 700, 800, 900],
    descriptionAr: 'خط عربي معاصر بتباعد حروف مريح للقراءة الطويلة.',
    descriptionEn: 'A contemporary Arabic sans with comfortable letter spacing.',
    designerNoteAr: 'مناسب للنصوص الطويلة والمحتوى.',
  );

  /// Almarai — خط عربي بسيط بأربعة أوزان.
  static const KitFont almarai = KitFont(
    family: 'Almarai',
    nameAr: 'المراعي',
    nameEn: 'Almarai',
    category: KitFontCategory.sans,
    weights: [300, 400, 700, 800],
    descriptionAr: 'خط عربي بسيط ومقروء جداً على الشاشات الصغيرة.',
    descriptionEn: 'A simple, highly legible Arabic face for small screens.',
    designerNoteAr: 'خفيف على العين في القوائم والفقرات.',
  );

  /// IBM Plex Sans Arabic — خط مؤسسي احترافي.
  static const KitFont ibmPlexSansArabic = KitFont(
    family: 'IBM Plex Sans Arabic',
    nameAr: 'آي بي إم بلكس',
    nameEn: 'IBM Plex Sans Arabic',
    category: KitFontCategory.sans,
    weights: [100, 200, 300, 400, 500, 600, 700],
    descriptionAr: 'عائلة مؤسسية من IBM بسبعة أوزان، متزنة بين العربية واللاتينية.',
    descriptionEn: 'IBM’s corporate family with seven weights.',
    designerNoteAr: 'الأنسب للتطبيقات المؤسسية ولوحات البيانات.',
  );

  /// Noto Kufi Arabic — الكوفي الحديث من Google.
  static const KitFont notoKufiArabic = KitFont(
    family: 'Noto Kufi Arabic',
    nameAr: 'نوتو كوفي',
    nameEn: 'Noto Kufi Arabic',
    category: KitFontCategory.kufi,
    weights: [300, 400, 500, 700],
    descriptionAr: 'خط كوفي حديث بتغطية واسعة لرموز العربية.',
    descriptionEn: 'A modern Kufi with wide Arabic coverage.',
    designerNoteAr: 'مميز للعناوين والشعارات.',
  );

  /// Reem Kufi — كوفي هندسي للعناوين.
  static const KitFont reemKufi = KitFont(
    family: 'Reem Kufi',
    nameAr: 'ريم كوفي',
    nameEn: 'Reem Kufi',
    category: KitFontCategory.kufi,
    weights: [400, 500, 600, 700],
    descriptionAr: 'كوفي هندسي أنيق يستخدم غالباً في الشعارات والعناوين الكبيرة.',
    descriptionEn: 'An elegant geometric Kufi for logos and large titles.',
    designerNoteAr: 'لا يُنصح به للنصوص الطويلة.',
  );

  /// Amiri — نسخ كلاسيكي بلمسة مطبعية.
  static const KitFont amiri = KitFont(
    family: 'Amiri',
    nameAr: 'أميري',
    nameEn: 'Amiri',
    category: KitFontCategory.naskh,
    weights: [400, 700],
    descriptionAr: 'نسخ كلاسيكي مستوحى من مطبعة بولاق، بدعم للخط المائل.',
    descriptionEn: 'A classical Naskh inspired by the Bulaq press, with italics.',
    designerNoteAr: 'مثالي للاقتباسات والكتب والمحتوى الديني.',
  );

  /// Aref Ruqaa — خط الرقعة بأسلوب الخطاطين.
  static const KitFont arefRuqaa = KitFont(
    family: 'Aref Ruqaa',
    nameAr: 'عارف رقعة',
    nameEn: 'Aref Ruqaa',
    category: KitFontCategory.display,
    weights: [400, 700],
    descriptionAr: 'خط رقعة عربي أصيل بلمسة يدوية من الخطاط عارف.',
    descriptionEn: 'An authentic Ruqaa with a calligraphic hand.',
    designerNoteAr: 'للعناوين الزخرفية والبطاقات فقط.',
  );

  /// Scheherazade New — نسخ كبير لعرض النصوص المطوّلة.
  static const KitFont scheherazadeNew = KitFont(
    family: 'Scheherazade New',
    nameAr: 'شهرزاد',
    nameEn: 'Scheherazade New',
    category: KitFontCategory.naskh,
    weights: [400, 500, 600, 700],
    descriptionAr: 'نسخ واضح بأحجام كبيرة، شائع في عرض النصوص العربية المطوّلة.',
    descriptionEn: 'A clear Naskh at large sizes, common in long-form Arabic text.',
    designerNoteAr: 'يحتاج مقاسات أكبر من المعتاد بسبب ارتفاع الحروف.',
  );

  // ───────────────────────────── خطوط لاتينية ─────────────────────────────

  /// Poppins — خط لاتيني هندسي ودود.
  static const KitFont poppins = KitFont(
    family: 'Poppins',
    nameAr: 'بوبينز',
    nameEn: 'Poppins',
    category: KitFontCategory.latinDisplay,
    weights: [400, 500, 600, 700],
    hasArabic: false,
    descriptionAr: 'خط لاتيني هندسي متوازن، شائع في التطبيقات الحديثة.',
    descriptionEn: 'A geometric Latin sans popular in modern apps.',
    designerNoteAr: 'للأرقام والعناوين اللاتينية.',
  );

  /// Montserrat — لاتيني هندسي بعناصر عريضة.
  static const KitFont montserrat = KitFont(
    family: 'Montserrat',
    nameAr: 'مونتسيرات',
    nameEn: 'Montserrat',
    category: KitFontCategory.latinDisplay,
    weights: [300, 400, 500, 600, 700],
    hasArabic: false,
    descriptionAr: 'خط لاتيني هندسي مستوحى من لافتات بوينس آيرس.',
    descriptionEn: 'A geometric Latin face inspired by Buenos Aires signage.',
    designerNoteAr: 'رائع للعناوين والشعارات.',
  );

  /// Inter — لاتيني مصمم لقراءة الواجهات.
  static const KitFont inter = KitFont(
    family: 'Inter',
    nameAr: 'إنتر',
    nameEn: 'Inter',
    category: KitFontCategory.latinSans,
    weights: [400, 500, 600, 700],
    hasArabic: false,
    descriptionAr: 'خط لاتيني مصمم خصيصاً لواجهات الشاشات وقراءة الأرقام.',
    descriptionEn: 'A Latin face designed for screen UI and numerals.',
    designerNoteAr: 'الأفضل لواجهات بالإنجليزية.',
  );

  /// Roboto — الخط الافتراضي في أندرويد.
  static const KitFont roboto = KitFont(
    family: 'Roboto',
    nameAr: 'روبوتو',
    nameEn: 'Roboto',
    category: KitFontCategory.latinSans,
    weights: [400, 500, 700],
    hasArabic: false,
    descriptionAr: 'الخط الافتراضي في نظام أندرويد، محايد وعملي.',
    descriptionEn: 'The Android default: neutral and practical.',
    designerNoteAr: 'خيار آمن للواجهات اللاتينية.',
  );

  // ───────────────────────────── قوائم مجمّعة ─────────────────────────────

  /// كل الخطوط (13 عائلة).
  static const List<KitFont> all = [
    cairo,
    tajawal,
    almarai,
    ibmPlexSansArabic,
    notoKufiArabic,
    reemKufi,
    amiri,
    arefRuqaa,
    scheherazadeNew,
    poppins,
    montserrat,
    inter,
    roboto,
  ];

  /// الخطوط التي تدعم العربية فقط.
  static List<KitFont> get arabic =>
      all.where((f) => f.hasArabic).toList(growable: false);

  /// الخطوط اللاتينية فقط.
  static List<KitFont> get latin =>
      all.where((f) => !f.hasArabic).toList(growable: false);

  /// الخطوط المناسبة للنصوص الطويلة.
  static List<KitFont> get forBodyText => const [
        cairo,
        tajawal,
        almarai,
        ibmPlexSansArabic,
        amiri,
        scheherazadeNew,
        inter,
        roboto,
      ];

  /// الخطوط المناسبة للعناوين والشعارات.
  static List<KitFont> get forHeadings => const [
        cairo,
        notoKufiArabic,
        reemKufi,
        arefRuqaa,
        amiri,
        poppins,
        montserrat,
      ];

  /// الخط المفضّل كافتراضي للمكتبة.
  static const KitFont defaultFont = cairo;

  /// يُرجع الخط المطابق لاسم العائلة، أو [defaultFont] إن لم يوجد.
  static KitFont byFamily(String family) =>
      all.firstWhere((f) => f.family == family, orElse: () => defaultFont);

  /// الخطوط المنتمية لتصنيف معيّن.
  static List<KitFont> byCategory(KitFontCategory category) =>
      all.where((f) => f.category == category).toList(growable: false);

  /// خط عشوائي مفيد للاختبارات وشاشات العرض.
  static KitFont random([int? seed]) {
    final index = seed == null
        ? DateTime.now().microsecondsSinceEpoch % all.length
        : seed.abs() % all.length;
    return all[index];
  }

  /// عدد العائلات المتاحة.
  static int get count => all.length;

  /// مجموع ملفات الأوزان داخل المكتبة.
  static int get faceCount => all.fold(0, (sum, f) => sum + f.weights.length);
}
