import 'package:flutter/material.dart';
import 'package:tickets_app/core/theme/app_colors.dart';
import 'package:tickets_app/core/theme/app_theme.dart';
import 'package:tickets_app/models/category.dart';
import 'package:tickets_app/screens/home_screen.dart';

import 'shadowned_action_button.dart';
import 'shadowned_button.dart';

class IconPicker extends StatefulWidget {
  const IconPicker({
    super.key,
    required this.initialIcon,
    required this.onIconChanged,
  });

  final IconData initialIcon;
  final Function(IconData icon, String categoria) onIconChanged;

  @override
  State<IconPicker> createState() => _IconPickerState();
}

class _IconPickerState extends State<IconPicker> {
  late IconData _selectedIcon;

  @override
  void initState() {
    super.initState();
    _selectedIcon = widget.initialIcon;
  }

  Future<void> _showIconPicker() async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return IconTextPicker(currentIcon: _selectedIcon);
      },
    );

    if (result != null) {
      setState(() {
        _selectedIcon = result['icon'] as IconData;
      });
      widget.onIconChanged(
        result['icon'] as IconData,
        result['categoria'] as String,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showIconPicker,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.black, width: 0.5),
          boxShadow: [
            BoxShadow(
              color: AppColors.black,
              blurRadius: 0,
              spreadRadius: 1,
              offset: const Offset(1.5, 2),
            ),
          ],
        ),
        child: Icon(_selectedIcon, size: 25, color: AppColors.black),
      ),
    );
  }
}

class IconTextPicker extends StatefulWidget {
  const IconTextPicker({super.key, required this.currentIcon});

  final IconData currentIcon;

  @override
  State<IconTextPicker> createState() => _IconTextPickerState();
}

class _IconTextPickerState extends State<IconTextPicker> {
  late IconData _selectedIcon;

  @override
  void initState() {
    super.initState();
    _selectedIcon = widget.currentIcon;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'SELECCIONAR ÍCONO',
            style: AppTheme.mono.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: context.screenHeight * 0.285,
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 2,
                mainAxisSpacing: 10,
              ),
              itemCount: Categories.all.length,
              itemBuilder: (context, index) {
                final icon = Categories.all[index].icono;
                final isSelected = icon == _selectedIcon;

                return ShadownedButton(
                  shadowned: isSelected,
                  onPressed: () {
                    setState(() => _selectedIcon = icon);
                  },
                  child: Icon(
                    icon,
                    size: 22,
                    color: isSelected ? AppColors.white : AppColors.black,
                  ),
                );
              },
            ),
          ),
          Center(
            child: Text(
              Categories.all
                  .firstWhere((cat) => cat.icono == _selectedIcon)
                  .nombre,
              style: AppTheme.mono.copyWith(
                color: AppColors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 20),
          ShadownedActionButton(
            onPressed: () {
              final categoria = Categories.all
                  .firstWhere((cat) => cat.icono == _selectedIcon)
                  .nombre;
              Navigator.of(context).pop({
                'icon': _selectedIcon,
                'categoria': categoria,
              });
            },
            text: 'CONFIRMAR',
          ),
        ],
      ),
    );
  }
}
