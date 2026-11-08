import 'package:flutter/material.dart';
import 'package:flutter_fonts_kit/flutter_fonts_kit.dart';

/// صف شرائح لتصفية الخطوط حسب التصنيف (الكل + التصنيفات).
class CategoryChips extends StatelessWidget {
  /// ينشئ شريط التصنيفات.
  const CategoryChips({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  /// التصنيف المحدّد حالياً (`null` = الكل).
  final KitFontCategory? selected;

  /// يُنفَّذ عند اختيار تصنيف.
  final ValueChanged<KitFontCategory?> onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ChoiceChip(
            label: const Text('الكل'),
            avatar: Icon(Icons.apps_rounded, size: 16, color: scheme.primary),
            selected: selected == null,
            onSelected: (_) => onChanged(null),
          ),
          const SizedBox(width: 8),
          for (final category in KitFontCategory.values) ...[
            ChoiceChip(
              label: Text(category.labelAr),
              avatar: Icon(category.icon, size: 16, color: scheme.secondary),
              selected: selected == category,
              onSelected: (isSelected) =>
                  onChanged(isSelected ? category : null),
            ),
            const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}
