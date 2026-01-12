import 'package:flutter/material.dart';
import 'package:tickets_app/core/theme/app_theme.dart';

class FieldConfidenceIndicator extends StatelessWidget {
  final double score;
  final bool isModified;

  const FieldConfidenceIndicator({
    super.key,
    required this.score,
    required this.isModified,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (score * 100).toInt();

    if (!isModified) {
      return const SizedBox(height: 4);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: _getScoreColor(score),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '$percentage% coincidencia',
            style: AppTheme.mono.copyWith(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: _getScoreColor(score),
            ),
          ),
        ],
      ),
    );
  }

  Color _getScoreColor(double score) {
    final percentage = score * 100;
    if (percentage >= 85) return const Color(0xFF10B981);
    if (percentage >= 70) return const Color(0xFFF59E0B);
    return const Color(0xFFEF4444);
  }
}
