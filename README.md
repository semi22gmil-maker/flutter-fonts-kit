<div dir="rtl">

<img src="screenshots/banner.png" alt="Flutter Fonts Kit" width="100%" />

<h1 align="center">Flutter Fonts Kit — مكتبة الخطوط لتطبيقات Flutter</h1>

مكتبة **جاهزة للاستخدام** تضم **13 عائلة خطية** عربية ولاتينية مضمّنة داخل الحزمة
(56 وزناً)، مع أدوات لاختيار الخط ومعاينته وتطبيقه على كل التطبيق بضغطة زر.

> ✅ لا تحميل من الإنترنت — الخطوط داخل الحزمة نفسها  
> ✅ دعم كامل للعربية (تشكيل وتوصيل الحروف) واللاتينية  
> ✅ واجهة عربية جاهزة (RTL) لاختيار الخط  
> ✅ اختبارات: **22 اختباراً ناجحاً** و`flutter analyze` نظيف

---

## 📸 لقطات الشاشة

| الرئيسية | منتقي الخطوط | تفاصيل الخط | الوضع الليلي |
|:---:|:---:|:---:|:---:|
| ![الرئيسية](screenshots/home.png) | ![منتقي الخطوط](screenshots/picker.png) | ![تفاصيل الخط](screenshots/specimen.png) | ![الوضع الليلي](screenshots/dark.png) |

> الصور مأخوذة من التطبيق التجريبي الفعلي (`example/`) بعد بناء الويب. لقطات
> الشاشة مولّدة عبر Chromium + Playwright بمقاس iPhone 430×932 @2x.

---

## ✨ الخطوط المتضمنة (13 عائلة / 56 وزناً)

### الخطوط العربية (9 عائلات)

| الخط | الاسم | الأوزان | التصنيف | الاستخدام المقترح |
|---|:---:|:---:|:---:|---|
| **Cairo** | القاهرة | 200 · 300 · 400 · 600 · 700 · 900 | بلا زخرفة | العناوين والنصوص — الأكثر شيوعاً |
| **Tajawal** | تجوال | 200 · 300 · 400 · 500 · 700 · 800 · 900 | بلا زخرفة | فقرات ومحتوى طويل |
| **Almarai** | المراعي | 300 · 400 · 700 · 800 | بلا زخرفة | شاشات صغيرة وقوائم |
| **IBM Plex Sans Arabic** | آي بي إم بلكس | 100 → 700 (7 أوزان) | بلا زخرفة | تطبيقات مؤسسية |
| **Noto Kufi Arabic** | نوتو كوفي | 300 · 400 · 500 · 700 | كوفي | عناوين وشعارات |
| **Reem Kufi** | ريم كوفي | 400 · 500 · 600 · 700 | كوفي | عناوين كبيرة وزخرفية |
| **Amiri** | أميري | 400 · 700 (+ مائل) | نسخ | اقتباسات وكتب |
| **Aref Ruqaa** | عارف رقعة | 400 · 700 | رقعة | بطاقات وعناوين يدوية |
| **Scheherazade New** | شهرزاد | 400 · 500 · 600 · 700 | نسخ | نصوص مطوّلة |

### الخطوط اللاتينية (4 عائلات)

| الخط | الأوزان | التصنيف |
|---|:---:|:---:|
| **Poppins** | 400 · 500 · 600 · 700 | هندسي |
| **Montserrat** | 300 → 700 | هندسي |
| **Inter** | 400 · 500 · 600 · 700 | واجهات |
| **Roboto** | 400 · 500 · 700 | واجهات |

---

## 📦 التثبيت

### 1) من GitHub (مستودع مباشر)

```yaml
dependencies:
  flutter_fonts_kit:
    git:
      url: https://github.com/<USERNAME>/flutter-fonts-kit.git
      ref: main
```

### 2) من مسار محلي

```yaml
dependencies:
  flutter_fonts_kit:
    path: ../flutter_fonts_kit
```

ثم:

```bash
flutter pub get
```

> **ملاحظة:** لا تحتاج أي إعداد إضافي — الخطوط مسجّلة داخل `pubspec.yaml` الخاص
> بالحزمة، وFlutter يضمّها تلقائياً عند البناء.

---

## 🚀 البدء السريع

```dart
import 'package:flutter/material.dart';
import 'package:flutter_fonts_kit/flutter_fonts_kit.dart';

void main() => runApp(const DemoApp());

class DemoApp extends StatefulWidget {
  const DemoApp({super.key});
  @override
  State<DemoApp> createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  final FontKit kit = FontKit(font: KitFonts.cairo);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: kit,
      builder: (context, _) => FontKitScope(
        kit: kit,
        child: MaterialApp(
          // يطبّق خط المكتبة على كل نصوص التطبيق
          theme: kit.applyTo(ThemeData.light(useMaterial3: true)),
          home: Scaffold(
            appBar: AppBar(title: const Text('مكتبة الخطوط')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KitText('الخط الحالي: ${kit.font.nameAr}', size: 24),
                  const SizedBox(height: 16),
                  FontPickerButton(kit: kit), // زر يفتح منتقي الخطوط
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

---

## 🧩 واجهة البرمجة (API)

### `KitFonts` — سجل الخطوط

```dart
KitFonts.all             // كل العائلات (13)
KitFonts.arabic          // الخطوط العربية (9)
KitFonts.latin           // الخطوط اللاتينية (4)
KitFonts.forBodyText     // المناسبة للنصوص
KitFonts.forHeadings     // المناسبة للعناوين
KitFonts.byCategory(KitFontCategory.kufi)
KitFonts.byFamily('Cairo')
KitFonts.cairo           // ثوابت جاهزة لكل خط
```

### `KitFont` — وصف الخط

```dart
final f = KitFonts.cairo;
f.family                 // 'Cairo'  → لـ fontFamily
f.nameAr                 // 'القاهرة'
f.weights                // [200, 300, 400, 600, 700, 900]
f.category.labelAr       // 'بلا زخرفة'
f.textStyle(fontSize: 24, fontWeight: FontWeight.w700)
f.matches('قاهرة')       // true — بحث عربي/إنجليزي
```

### `FontKit` — المتحكّم

```dart
final kit = FontKit(font: KitFonts.cairo);
kit.font = KitFonts.tajawal;   // يحدّث التطبيق كله تلقائياً
kit.next();                    // الخط التالي
kit.previous();                // الخط السابق
kit.textScale = 1.3;           // تكبير النصوص
kit.reset();                   // العودة للافتراضي
kit.applyTo(theme);            // ينسخ ThemeData مع الخط
```

### الودجات

| الودجت | الوظيفة |
|---|---|
| `FontKitScope` | يوفّر المتحكّم لأبناء الشجرة + يُعيد البناء تلقائياً |
| `KitText` | نص بخط المكتبة (`font:` للتحديد اليدوي) |
| `FontSpecimen` | بطاقة معاينة لخط واحد |
| `FontPickerPage` | صفحة اختيار الخطوط (بحث + تبويبات) |
| `showFontPicker(context)` | يفتح الصفحة ويُعيد `KitFont?` |
| `showFontPickerSheet(context)` | نفس الشيء كلوحة سفلية |
| `FontPickerButton(kit: kit)` | زر جاهز يفتح المنتقي ويطبّق النتيجة |

### الوصول من أي مكان

```dart
final kit = context.fontKit;        // FontKit الأقرب
final family = context.currentFontFamily;
```

---

## 🖥️ تشغيل التطبيق التجريبي

```bash
cd example
flutter pub get
flutter run                 # على جهاز/محاكي
flutter run -d chrome       # على الويب
```

التطبيق التجريبي يحتوي:

- معاينة حيّة يتغيّر خطها فوراً، وكتابة نص تجريبي.
- تدرّج أحجام بنفس الخط.
- تصفية حسب التصنيف (كوفي، نسخ، زخرفي…).
- منتقي خطوط كصفحة كاملة أو كلوحة سفلية.
- صفحة تفاصيل لكل خط: شريط الحجم، أزرار الأوزان، نسخ `fontFamily`.
- وضع ليلي/نهاري.

---

## 🧪 الاختبارات

```bash
flutter test          # 20 اختباراً للمكتبة
cd example && flutter test   # اختبارا التطبيق التجريبي
```

---

## 🔤 إضافة خط جديد

1. ضع ملفات `.ttf` في `assets/fonts/<اسم-الخط>/`.
2. سجّلها في `pubspec.yaml` تحت `flutter: fonts:` بنفس النمط الموجود.
3. أضف ثابتاً جديداً في `lib/src/kit_fonts.dart` وأضفه إلى `KitFonts.all`.

> سكربت مساعد لجلب الخطوط من مستودع Google Fonts:
> ```bash
> python3 tool/fetch_fonts.py
> ```

---

## 📄 الترخيص

- **كود المكتبة:** رخصة MIT (انظر `LICENSE`).
- **الخطوط:** كلها من [Google Fonts](https://fonts.google.com) بترخيص
  **SIL Open Font License 1.1** — النسخ الأصلية للتراخيص في مجلد `licenses/`.
  يجوز استخدامها في التطبيقات التجارية، مع بقاء اسم الخط محفوظاً وعدم بيع
  الخطوط منفردة.

---

## 🤝 المساهمة

المساهمات مرحّب بها: افتح Issue أو Pull Request. قبل الإرسال شغّل:

```bash
flutter analyze && flutter test
```

</div>
