/// Flutter Fonts Kit — مكتبة خطوط عربية ولاتينية جاهزة لتطبيقات Flutter.
///
/// المزايا:
/// * 13 عائلة خطية مضمّنة داخل الحزمة (لا تحميل من الشبكة، تعمل دون إنترنت).
/// * دعم كامل للعربية واللاتينية مع أوزان متعددة (حتى 7 أوزان للعائلة).
/// * متحكّم [FontKit] لتغيير الخط في كل التطبيق لحظياً + تطبيقه على [ThemeData].
/// * واجهة اختيار ومعاينة خطوط [FontPickerPage] عربية وجاهزة للاستخدام.
/// * بطاقة معاينة [FontSpecimen] وودجت نص [KitText].
///
/// ## البداية السريعة
/// ```dart
/// import 'package:flutter_fonts_kit/flutter_fonts_kit.dart';
///
/// void main() => runApp(const DemoApp());
///
/// class DemoApp extends StatefulWidget {
///   const DemoApp({super.key});
///   @override
///   State<DemoApp> createState() => _DemoAppState();
/// }
///
/// class _DemoAppState extends State<DemoApp> {
///   final FontKit kit = FontKit(font: KitFonts.cairo);
///
///   @override
///   Widget build(BuildContext context) {
///     return FontKitScope(
///       kit: kit,
///       child: AnimatedBuilder(
///         animation: kit,
///         builder: (context, _) => MaterialApp(
///           theme: kit.applyTo(ThemeData.light(useMaterial3: true)),
///           home: const HomePage(),
///         ),
///       ),
///     );
///   }
/// }
/// ```
///
/// الخطوط مصدرها مستودع Google Fonts الرسمي، وكلها بترخيص OFL-1.1
/// (انظر مجلد `licenses/` في المستودع).
library;

export 'src/font_kit.dart';
export 'src/kit_font.dart';
export 'src/kit_fonts.dart';
export 'src/widgets/font_picker_page.dart';
export 'src/widgets/font_specimen.dart';
export 'src/widgets/kit_text.dart';
