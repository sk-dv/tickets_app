import 'package:flutter/material.dart';
import 'package:tickets_app/core/theme/app_colors.dart';
import 'package:tickets_app/core/theme/app_theme.dart';
import 'package:tickets_app/utils/confidence_calculator.dart';

class ConfidenceBreakdown extends StatelessWidget {
  final ConfidenceResult result;

  const ConfidenceBreakdown({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.black, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.black,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: _getConfidenceColor(result.overall),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.black, width: 2),
            ),
            child: Center(
              child: Text(
                '${result.overall.toStringAsFixed(0)}%',
                style: AppTheme.mono.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getConfidenceLabel(result.overall),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _getConfidenceDescription(result),
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.gray600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getConfidenceColor(double confidence) {
    if (confidence >= 85) return const Color(0xFF10B981);
    if (confidence >= 70) return const Color(0xFFF59E0B);
    return const Color(0xFFEF4444);
  }

  String _getConfidenceLabel(double confidence) {
    if (confidence >= 85) return 'Alta precisión';
    if (confidence >= 70) return 'Precisión media';
    return 'Baja precisión';
  }

  String _getConfidenceDescription(ConfidenceResult result) {
    final modified = result.modifiedFieldsCount;
    if (modified == 0) return 'Información sin modificar';
    if (modified == 1) return '1 campo modificado';
    return '$modified campos modificados';
  }
}
