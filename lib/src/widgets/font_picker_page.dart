import 'package:flutter/material.dart';

import '../font_kit.dart';
import '../kit_font.dart';
import '../kit_fonts.dart';
import 'font_specimen.dart';

/// صفحة كاملة لاختيار الخط من بين كل خطوط المكتبة.
///
/// فيها بحث، وتبويبات تصفية (الكل / عربي / لاتيني)، وبطاقات معاينة حيّة.
///
/// الاستخدام الأسهل عبر [showFontPicker]:
/// ```dart
/// final picked = await showFontPicker(context, current: kit.font);
/// if (picked != null) kit.font = picked;
/// ```
///
/// أو كصفحة مستقلّة:
/// ```dart
/// Navigator.push(context, MaterialPageRoute(
///   builder: (_) => FontPickerPage(onSelected: (font) => kit.font = font),
/// ));
/// ```
class FontPickerPage extends StatefulWidget {
  /// ينشئ صفحة اختيار الخطوط.
  const FontPickerPage({
    super.key,
    this.fonts = KitFonts.all,
    this.current,
    this.onSelected,
    this.title = 'اختيار الخط',
    this.sampleText = 'بسم الله الرحمن الرحيم — الخط الجميل يعبّر عن رسالتك',
    this.searchHint = 'ابحث عن خط…',
  });

  /// قائمة الخطوط القابلة للاختيار (افتراضياً الكل).
  final List<KitFont> fonts;

  /// الخط المحدّد حالياً (يظهر بعلامة صح).
  final KitFont? current;

  /// يُنفَّذ عند اختيار خط؛ إن كان `null` يُضاف الاختيار إلى نتيجة `Navigator.pop`.
  final ValueChanged<KitFont>? onSelected;

  /// عنوان الصفحة.
  final String title;

  /// النص النموذجي في المعاينة الحيّة أعلى الشاشة.
  final String sampleText;

  /// نص مربع البحث.
  final String searchHint;

  @override
  State<FontPickerPage> createState() => _FontPickerPageState();
}

class _FontPickerPageState extends State<FontPickerPage>
    with SingleTickerProviderStateMixin {
  late KitFont _preview;
  final TextEditingController _search = TextEditingController();
  late final TabController _tabs = TabController(length: 3, vsync: this);
  String _query = '';

  @override
  void initState() {
    super.initState();
    _preview = widget.current ??
        (widget.fonts.isNotEmpty ? widget.fonts.first : KitFonts.defaultFont);
  }

  @override
  void dispose() {
    _search.dispose();
    _tabs.dispose();
    super.dispose();
  }

  List<KitFont> get _visible {
    final tab = _tabs.index;
    return widget.fonts.where((f) {
      final byTab = switch (tab) {
        1 => f.hasArabic,
        2 => !f.hasArabic,
        _ => true,
      };
      return byTab && f.matches(_query);
    }).toList(growable: false);
  }

  void _select(KitFont font) {
    setState(() => _preview = font);
    if (widget.onSelected != null) {
      widget.onSelected!(font);
    } else {
      Navigator.of(context).pop(font);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.w700)),
        bottom: TabBar(
          controller: _tabs,
          onTap: (_) => setState(() {}),
          tabs: const [
            Tab(text: 'الكل'),
            Tab(text: 'عربي'),
            Tab(text: 'لاتيني'),
          ],
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            // المعاينة الحيّة
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    scheme.primaryContainer.withValues(alpha: 0.75),
                    scheme.secondaryContainer.withValues(alpha: 0.55),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'معاينة حيّة · ${_preview.nameAr}',
                    style: TextStyle(
                      fontSize: 12,
                      color: scheme.onPrimaryContainer.withValues(alpha: 0.8),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: Text(
                      widget.sampleText,
                      key: ValueKey(_preview.family),
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: _preview.family,
                        fontSize: 24,
                        height: 1.8,
                        color: scheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextField(
                controller: _search,
                onChanged: (v) => setState(() => _query = v),
                decoration: InputDecoration(
                  hintText: widget.searchHint,
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: _query.isEmpty
                      ? null
                      : IconButton(
                          icon: const Icon(Icons.close_rounded),
                          onPressed: () {
                            _search.clear();
                            setState(() => _query = '');
                          },
                        ),
                  filled: true,
                  fillColor: scheme.surfaceContainerHighest.withValues(alpha: 0.4),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 4),
                ),
              ),
            ),
            Expanded(
              child: AnimatedBuilder(
                animation: _tabs,
                builder: (context, _) {
                  final fonts = _visible;
                  if (fonts.isEmpty) {
                    return const Center(
                      child: Text('لا توجد نتائج مطابقة للبحث'),
                    );
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                    itemCount: fonts.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final font = fonts[index];
                      return FontSpecimen(
                        font: font,
                        sampleText: widget.sampleText,
                        showWeights: false,
                        selected: font == _preview,
                        onTap: () => _select(font),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// يفتح [FontPickerPage] كصفحة كاملة ويُعيد الخط المختار (أو `null`).
Future<KitFont?> showFontPicker(
  BuildContext context, {
  List<KitFont> fonts = KitFonts.all,
  KitFont? current,
  String title = 'اختيار الخط',
}) {
  return Navigator.of(context).push<KitFont>(
    MaterialPageRoute(
      builder: (_) => FontPickerPage(
        fonts: fonts,
        current: current,
        title: title,
      ),
    ),
  );
}

/// يفتح منتقي الخطوط كلوحة سفلية (Bottom Sheet) ويُعيد الخط المختار.
Future<KitFont?> showFontPickerSheet(
  BuildContext context, {
  List<KitFont> fonts = KitFonts.all,
  KitFont? current,
}) {
  return showModalBottomSheet<KitFont>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (sheetContext) => SizedBox(
      height: MediaQuery.sizeOf(sheetContext).height * 0.85,
      child: FontPickerPage(
        fonts: fonts,
        current: current,
        title: 'اختيار الخط',
      ),
    ),
  );
}

/// زر جاهز يفتح منتقي الخطوط ويطبّق الاختيار على [FontKit] الأقرب.
///
/// ```dart
/// FontPickerButton(kit: kit)              // زر بأيقونة نصية
/// FontPickerButton.icon(kit: kit)         // زر أيقونة فقط
/// ```
class FontPickerButton extends StatelessWidget {
  /// زر نصي بأيقونة "الخط".
  const FontPickerButton({super.key, required this.kit, this.text = 'تغيير الخط'})
      : _iconOnly = false;

  /// زر أيقونة فقط.
  const FontPickerButton.icon({super.key, required this.kit})
      : text = null,
        _iconOnly = true;

  /// المتحكّم الذي سيُطبَّق عليه الاختيار.
  final FontKit kit;

  /// نص الزر.
  final String? text;

  final bool _iconOnly;

  Future<void> _open(BuildContext context) async {
    final picked = await showFontPicker(context, current: kit.font);
    if (picked != null) kit.font = picked;
  }

  @override
  Widget build(BuildContext context) {
    final icon = Icon(
      Icons.font_download_outlined,
      color: Theme.of(context).colorScheme.primary,
    );
    if (_iconOnly) {
      return IconButton(
        tooltip: 'تغيير الخط',
        onPressed: () => _open(context),
        icon: icon,
      );
    }
    return FilledButton.tonalIcon(
      onPressed: () => _open(context),
      icon: icon,
      label: Text(text ?? 'تغيير الخط', style: TextStyle(fontFamily: kit.font.family)),
    );
  }
}
