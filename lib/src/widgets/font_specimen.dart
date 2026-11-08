import 'package:flutter/material.dart';

import '../kit_font.dart';

/// بطاقة معاينة (Specimen) لعائلة خطية واحدة.
///
/// تعرض اسم الخط بالعربية والإنجليزية، نموذجاً نصياً بثلاثة أحجام، وشرائط
/// الأوزان المتاحة.
///
/// ```dart
/// FontSpecimen(font: KitFonts.cairo)
/// ```
class FontSpecimen extends StatelessWidget {
  /// ينشئ بطاقة معاينة للخط [font].
  const FontSpecimen({
    super.key,
    required this.font,
    this.sampleText = 'أبجد هوز حطي كلمن سعفص قرشت ثخذ ضظغ',
    this.sampleLatin = 'The quick brown fox jumps over the lazy dog',
    this.showWeights = true,
    this.showDescription = true,
    this.onTap,
    this.selected = false,
    this.padding = const EdgeInsets.all(16),
    this.backgroundColor,
    this.borderColor,
    this.borderRadius = 16,
  });

  /// الخط المعروض.
  final KitFont font;

  /// النص العربي النموذجي.
  final String sampleText;

  /// النص اللاتيني النموذجي.
  final String sampleLatin;

  /// إظهار شرائط الأوزان المتاحة.
  final bool showWeights;

  /// إظهار الوصف أسفل البطاقة.
  final bool showDescription;

  /// يُنفَّذ عند الضغط على البطاقة.
  final VoidCallback? onTap;

  /// هل البطاقة محدّدة (لإبراز الاختيار الحالي).
  final bool selected;

  /// الحشوة الداخلية.
  final EdgeInsets padding;

  /// لون خلفية البطاقة.
  final Color? backgroundColor;

  /// لون الإطار.
  final Color? borderColor;

  /// نصف قطر الزوايا.
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final accent = selected ? scheme.primary : scheme.outlineVariant;

    return Semantics(
      label: 'معاينة خط ${font.nameAr}',
      button: onTap != null,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: padding,
          decoration: BoxDecoration(
            color: backgroundColor ??
                (selected
                    ? scheme.primaryContainer.withValues(alpha: 0.35)
                    : scheme.surfaceContainerHighest.withValues(alpha: 0.35)),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: borderColor ?? accent,
              width: selected ? 2 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          font.nameAr,
                          style: TextStyle(
                            fontFamily: font.family,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: scheme.onSurface,
                          ),
                        ),
                        Text(
                          font.nameEn,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: scheme.onSurfaceVariant,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (selected)
                    Icon(Icons.check_circle_rounded, color: scheme.primary),
                  const SizedBox(width: 8),
                  _Badge(
                    label: font.category.labelAr,
                    icon: font.category.icon,
                    color: scheme.secondary,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                sampleText,
                textDirection: TextDirection.rtl,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: font.family,
                  fontSize: 26,
                  height: 1.7,
                  color: scheme.onSurface,
                ),
              ),
              if (font.hasLatin) ...[
                const SizedBox(height: 6),
                Text(
                  sampleLatin,
                  textDirection: TextDirection.ltr,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: font.family,
                    fontSize: 15,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
              if (showWeights) ...[
                const SizedBox(height: 14),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    for (final weight in font.weights)
                      _Badge(
                        label: '$weight',
                        color: scheme.tertiary,
                        trailingWeight: kitFontWeight(weight),
                      ),
                  ],
                ),
              ],
              if (showDescription && font.descriptionAr.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  font.descriptionAr,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                    height: 1.6,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    required this.label,
    this.icon,
    required this.color,
    this.trailingWeight,
  });

  final String label;
  final IconData? icon;
  final Color color;
  final FontWeight? trailingWeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 13, color: color),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: trailingWeight ?? FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
