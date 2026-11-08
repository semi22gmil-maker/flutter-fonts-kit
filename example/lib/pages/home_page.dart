import 'package:flutter/material.dart';
import 'package:flutter_fonts_kit/flutter_fonts_kit.dart';

import 'specimen_page.dart';
import 'widgets/category_chips.dart';

/// الصفحة الرئيسية للتطبيق التجريبي: معاينة حيّة + قائمة الخطوط.
class HomePage extends StatefulWidget {
  /// ينشئ الصفحة.
  const HomePage({
    super.key,
    required this.kit,
    required this.darkMode,
    required this.onToggleDark,
  });

  /// متحكّم الخطوط.
  final FontKit kit;

  /// هل الوضع الليلي مفعّل.
  final bool darkMode;

  /// تبديل الوضع الليلي.
  final VoidCallback onToggleDark;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _text =
      TextEditingController(text: 'الخط الجميل يعبّر عن رسالتك قبل أن تُقرأ كلماتك');
  KitFontCategory? _category;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  List<KitFont> get _visible => _category == null
      ? KitFonts.all
      : KitFonts.byCategory(_category!);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final font = widget.kit.font;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter Fonts Kit',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            tooltip: widget.darkMode ? 'الوضع النهاري' : 'الوضع الليلي',
            onPressed: widget.onToggleDark,
            icon: Icon(
              widget.darkMode
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
            ),
          ),
          IconButton(
            tooltip: 'منتقي الخطوط كصفحة',
            onPressed: () async {
              final picked =
                  await showFontPicker(context, current: widget.kit.font);
              if (picked != null) widget.kit.font = picked;
            },
            icon: const Icon(Icons.tune_rounded),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final picked =
              await showFontPickerSheet(context, current: widget.kit.font);
          if (picked != null) widget.kit.font = picked;
        },
        icon: const Icon(Icons.font_download_outlined),
        label: const Text('اختر الخط'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
        children: [
          _HeroPreview(kit: widget.kit, controller: _text),
          const SizedBox(height: 16),
          _ScaleCard(kit: widget.kit),
          const SizedBox(height: 16),
          CategoryChips(
            selected: _category,
            onChanged: (c) => setState(() => _category = c),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                'الخطوط المتاحة (${_visible.length})',
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              Text(
                '${KitFonts.count} عائلة · ${KitFonts.faceCount} وزن',
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: scheme.onSurfaceVariant),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ..._visible.map(
            (f) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: FontSpecimen(
                font: f,
                sampleText: _text.text.isEmpty ? f.nameAr : _text.text,
                showDescription: false,
                selected: f == font,
                onTap: () {
                  widget.kit.font = f;
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => SpecimenPage(font: f)),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              'صُنعت بـ Flutter Fonts Kit · 13 عائلة خطية',
              style: TextStyle(fontSize: 11, color: scheme.outline),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroPreview extends StatefulWidget {
  const _HeroPreview({required this.kit, required this.controller});

  final FontKit kit;
  final TextEditingController controller;

  @override
  State<_HeroPreview> createState() => _HeroPreviewState();
}

class _HeroPreviewState extends State<_HeroPreview> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onText);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onText);
    super.dispose();
  }

  void _onText() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final font = widget.kit.font;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            scheme.primaryContainer,
            scheme.tertiaryContainer.withValues(alpha: 0.85),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: scheme.primary.withValues(alpha: 0.15),
                child: Icon(Icons.auto_stories_rounded, color: scheme.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      font.nameAr,
                      style: TextStyle(
                        fontFamily: font.family,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: scheme.onPrimaryContainer,
                      ),
                    ),
                    Text(
                      '${font.nameEn} · ${font.weights.length} أوزان · ${font.category.labelAr}',
                      style: TextStyle(
                        fontSize: 12,
                        color: scheme.onPrimaryContainer.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 280),
            child: Text(
              widget.controller.text.isEmpty
                  ? 'اكتب هنا لمشاهدة الخط…'
                  : widget.controller.text,
              key: ValueKey(font.family),
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontFamily: font.family,
                fontSize: 26,
                height: 1.9,
                color: scheme.onPrimaryContainer,
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: widget.controller,
            textDirection: TextDirection.rtl,
            maxLines: 2,
            minLines: 1,
            style: TextStyle(fontFamily: font.family, fontSize: 16),
            decoration: InputDecoration(
              hintText: 'اكتب نصاً لتجربته بكل الخطوط…',
              prefixIcon: const Icon(Icons.edit_rounded),
              filled: true,
              fillColor: scheme.surface.withValues(alpha: 0.8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScaleCard extends StatelessWidget {
  const _ScaleCard({required this.kit});

  final FontKit kit;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final weights = kit.font.weights;
    final samples = <(String, double, int)>[
      ('عنوان رئيسي — Display', 28, weights.last),
      ('عنوان فرعي — Headline', 22, weights[weights.length ~/ 2]),
      ('نص أساسي — Body Text', 16, 400),
      ('تعليق صغير — Caption', 12, weights.first),
    ];

    return Card.filled(
      color: scheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.format_size_rounded, size: 18, color: scheme.primary),
                const SizedBox(width: 8),
                Text(
                  'تدرّج الأحجام بنفس الخط',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: scheme.primary,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            for (final (label, size, weight) in samples)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  label,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontFamily: kit.font.family,
                    fontSize: size,
                    fontWeight: kitFontWeight(weight),
                    height: 1.6,
                    color: scheme.onSurface,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
