import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fonts_kit/flutter_fonts_kit.dart';

/// صفحة تفاصيل خط واحد: معاينة كبيرة، تفاعل مع الأوزان، وتطبيق فوري على الثيم.
class SpecimenPage extends StatefulWidget {
  /// ينشئ صفحة تفاصيل الخط [font].
  const SpecimenPage({super.key, required this.font});

  /// الخط المعروض.
  final KitFont font;

  @override
  State<SpecimenPage> createState() => _SpecimenPageState();
}

class _SpecimenPageState extends State<SpecimenPage> {
  final TextEditingController _text =
      TextEditingController(text: 'العلم نور والجهل ظلام\nالخط العربي فنٌّ وأصالة');
  double _size = 30;
  late int _weight = widget.font.weights.contains(400)
      ? 400
      : widget.font.weights.first;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final font = widget.font;
    final kit = FontKitScope.maybeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          font.nameAr,
          style: TextStyle(
            fontFamily: font.family,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          if (kit != null)
            IconButton(
              tooltip: 'تطبيق هذا الخط على التطبيق',
              onPressed: () {
                kit.font = font;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'تم تطبيق خط ${font.nameAr} على التطبيق كامل',
                      style: TextStyle(fontFamily: font.family),
                    ),
                  ),
                );
              },
              icon: Icon(Icons.check_circle_outline_rounded,
                  color: kit.font == font ? scheme.primary : null),
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // لوحة المعاينة
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: scheme.surfaceContainerHighest.withValues(alpha: 0.45),
              border: Border.all(color: scheme.outlineVariant),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ابدأ بكتابة نصك — كل تعديل يظهر فوراً',
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: scheme.onSurfaceVariant),
                ),
                const SizedBox(height: 8),
                AnimatedSize(
                  duration: const Duration(milliseconds: 200),
                  child: Text(
                    _text.text,
                    key: ValueKey('$_weight-$_size'),
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontFamily: font.family,
                      fontSize: _size,
                      fontWeight: kitFontWeight(_weight),
                      height: 1.9,
                      color: scheme.onSurface,
                    ),
                  ),
                ),
                const Divider(height: 32),
                TextField(
                  controller: _text,
                  maxLines: 3,
                  minLines: 1,
                  style: TextStyle(fontFamily: font.family),
                  decoration: const InputDecoration(
                    labelText: 'نص المعاينة',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          Text('حجم الخط: ${_size.round()}',
              style: theme.textTheme.titleSmall),
          Slider(
            value: _size,
            min: 12,
            max: 96,
            divisions: 84,
            label: '${_size.round()}',
            onChanged: (v) => setState(() => _size = v),
          ),
          const SizedBox(height: 8),

          Text('الوزن: $_weight', style: theme.textTheme.titleSmall),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final w in font.weights)
                ChoiceChip(
                  label: Text(
                    '$w',
                    style: TextStyle(
                      fontFamily: font.family,
                      fontWeight: kitFontWeight(w),
                    ),
                  ),
                  selected: _weight == w,
                  onSelected: (_) => setState(() => _weight = w),
                ),
            ],
          ),
          const SizedBox(height: 24),

          Card.filled(
            color: scheme.surfaceContainerLow,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _InfoRow(label: 'الاسم الإنجليزي', value: font.nameEn),
                  _InfoRow(label: 'التصنيف', value: font.category.labelAr),
                  _InfoRow(label: 'يدعم العربية', value: font.hasArabic ? 'نعم' : 'لا'),
                  _InfoRow(label: 'يدعم اللاتينية', value: font.hasLatin ? 'نعم' : 'لا'),
                  _InfoRow(
                    label: 'الأوزان',
                    value: font.weights.join(' · '),
                  ),
                  if (font.designerNoteAr.isNotEmpty)
                    _InfoRow(label: 'ملاحظة', value: font.designerNoteAr),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Clipboard.setData(
                      ClipboardData(text: "fontFamily: '${font.family}'"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم نسخ اسم العائلة')),
                    );
                  },
                  icon: const Icon(Icons.copy_rounded, size: 18),
                  label: const Text('نسخ fontFamily'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back_rounded, size: 18),
                  label: const Text('رجوع'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(value, style: theme.textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}
