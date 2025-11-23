import 'package:flutter/material.dart';
import 'package:tickets_app/core/theme/app_colors.dart';
import 'package:tickets_app/core/theme/app_theme.dart';

class ConfidenceIndicator extends StatelessWidget {
  final double confidence;
  final bool show;

  const ConfidenceIndicator({
    super.key,
    required this.confidence,
    this.show = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!show || confidence == 0) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: _getColor().withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: _getColor().withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: _getColor(),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            '${(confidence * 100).toInt()}%',
            style: AppTheme.mono.copyWith(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: _getColor(),
            ),
          ),
        ],
      ),
    );
  }

  Color _getColor() {
    if (confidence >= 0.85) return AppColors.success;
    if (confidence >= 0.65) return AppColors.warning;
    return AppColors.error;
  }
}
