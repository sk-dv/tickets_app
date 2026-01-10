// lib/widgets/category_selector.dart
import 'package:flutter/material.dart';
import 'package:tickets_app/core/theme/app_colors.dart';
import 'package:tickets_app/models/category.dart';

class CategorySelector extends StatelessWidget {
  final String value;
  final ValueChanged<Category> onChanged;

  const CategorySelector({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final selected = Categories.inferFromComercio(value);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Categoría',
          style: TextStyle(
            fontSize: 13,
            color: AppColors.gray600,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: Categories.all.map((cat) {
            final isSelected = cat.id == selected.id;
            return GestureDetector(
              onTap: () => onChanged(cat),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryPastel
                      : AppColors.gray100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      cat.icono,
                      size: 16,
                      color: isSelected ? AppColors.white : AppColors.gray600,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      cat.nombre,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? AppColors.white : AppColors.gray600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
