# مثال Flutter Fonts Kit

تطبيق تجريبي كامل يوضّح قدرات المكتبة، بواجهة عربية ودعم RTL.
لتنزيل المشروع وإعداد المتطلبات، راجع [دليل README الرئيسي](../README.md).

## التشغيل من Windows PowerShell

افتح PowerShell داخل مجلد `example` بعد تنزيل المشروع. نفّذ كل سطر على حدة:

```powershell
flutter pub get
flutter devices
flutter run -d chrome
```

**النتيجة المتوقعة:** تُجلب الاعتماديات، ويظهر Chrome ضمن الأجهزة، ثم تُفتح
نافذة التطبيق التجريبي. يعتمد المثال على المكتبة الموجودة في المجلد الأب عبر
`path: ../`، ولا يحتاج إلى نشرها على pub.dev.

### تشغيل تطبيق Windows مستقل

يتطلب Visual Studio 2022 مع حِمل **Desktop development with C++**.
ملفات منصة Windows غير مضمّنة في المستودع؛ أنشئها من داخل `example`:

```powershell
flutter create . --platforms=windows --project-name flutter_fonts_kit_example
flutter run -d windows
```

**النتيجة المتوقعة:** تُنشأ ملفات منصة Windows ثم تُفتح نافذة التطبيق.
إذا لم تكتمل أدوات البناء، استخدم Chrome بدلاً من ذلك.

## ما يعرضه

- **معاينة حيّة**: اكتب نصاً وشاهد الخط يتغيّر فوراً.
- **تدرّج الأحجام** بنفس الخط (Display / Headline / Body / Caption).
- **تصفية حسب التصنيف**: بلا زخرفة، كوفي، نسخ، زخرفي…
- **منتقي الخطوط** كصفحة كاملة أو كلوحة سفلية، مع بحث عربي/إنجليزي.
- **صفحة تفاصيل الخط**: شريط الحجم، أزرار الأوزان، نسخ `fontFamily`.
- **وضع ليلي/نهاري** متكامل.

## الاختبارات

من داخل `example` في PowerShell:

```powershell
flutter analyze
flutter test
```

**النتيجة المتوقعة:** فحص نظيف ونجاح اختبارَي التطبيق التجريبي.

## بنية الصفحات

```text
lib/
├── main.dart                     # التطبيق + FontKit
└── pages/
    ├── home_page.dart            # الرئيسية
    ├── specimen_page.dart        # تفاصيل الخط
    └── widgets/
        └── category_chips.dart   # شرائح التصنيف
```
