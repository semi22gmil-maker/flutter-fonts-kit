import 'package:flutter/material.dart';
import 'package:flutter_fonts_kit/flutter_fonts_kit.dart';

import 'pages/home_page.dart';

void main() => runApp(const ExampleApp());

/// التطبيق التجريبي لمكتبة Flutter Fonts Kit.
///
/// يعرض: اختيار الخط من شاشة كاملة أو من لوحة سفلية، تدرّج الأحجام، تغيير
/// النص، وتطبيق الخط على الثيم بالكامل.
class ExampleApp extends StatefulWidget {
  /// ينشئ التطبيق التجريبي.
  const ExampleApp({super.key});

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  final FontKit kit = FontKit(font: KitFonts.cairo);
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: kit,
      builder: (context, _) {
        final base = darkMode
            ? ThemeData.dark(useMaterial3: true)
            : ThemeData.light(useMaterial3: true);
        return FontKitScope(
          kit: kit,
          child: MaterialApp(
            title: 'Flutter Fonts Kit',
            debugShowCheckedModeBanner: false,
            theme: kit.applyTo(base),
            locale: const Locale('ar'),
            builder: (context, child) => Directionality(
              textDirection: TextDirection.rtl,
              child: MediaQuery.withClampedTextScaling(
                minScaleFactor: kit.textScale,
                maxScaleFactor: kit.textScale,
                child: child!,
              ),
            ),
            home: HomePage(
              kit: kit,
              darkMode: darkMode,
              onToggleDark: () => setState(() => darkMode = !darkMode),
            ),
          ),
        );
      },
    );
  }
}
