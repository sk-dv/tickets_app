import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:tickets_app/core/theme/app_colors.dart';

enum TicketSource { camera, gallery, manual }

class TicketSourceSheet extends StatelessWidget {
  const TicketSourceSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 4,
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              color: AppColors.gray300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const Text(
            'Agregar ticket',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 24),
          _SourceOption(
            icon: FeatherIcons.camera,
            label: 'Tomar foto',
            sublabel: 'Escanear con cámara',
            onTap: () => Navigator.pop(context, TicketSource.camera),
          ),
          _SourceOption(
            icon: FeatherIcons.image,
            label: 'Galería',
            sublabel: 'Seleccionar imagen',
            onTap: () => Navigator.pop(context, TicketSource.gallery),
          ),
          _SourceOption(
            icon: FeatherIcons.edit3,
            label: 'Manual',
            sublabel: 'Escribir datos',
            onTap: () => Navigator.pop(context, TicketSource.manual),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _SourceOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final String sublabel;
  final VoidCallback onTap;

  const _SourceOption({
    required this.icon,
    required this.label,
    required this.sublabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.gray200),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.gray600),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  sublabel,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.gray600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
