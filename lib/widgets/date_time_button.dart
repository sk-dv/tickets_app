import 'package:flutter/material.dart';
import 'package:tickets_app/core/theme/app_colors.dart';
import 'package:tickets_app/core/theme/app_theme.dart';
import 'package:intl/intl.dart';
import 'package:tickets_app/widgets/shadowned_button.dart';

class DateTimeButton extends StatelessWidget {
  const DateTimeButton({
    super.key,
    required this.dateTime,
    required this.onTap,
  });

  final DateTime dateTime;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM dd, yyyy', 'es_MX');
    final timeFormat = DateFormat('HH:mm', 'es_MX');
  

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Fecha y hora',
          style: TextStyle(fontSize: 13, color: AppColors.gray600),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: ShadownedButton(
            onPressed: onTap,
            child: Container(
              margin: const EdgeInsets.all(4),
              child: Row(
                children: [
                  _TimeSection(
                    icon: Icons.calendar_today,
                    text: dateFormat.format(dateTime),
                  ),
                  const _TimeDivider(),
                  _TimeSection(
                    icon: Icons.access_time,
                    text: timeFormat.format(dateTime),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TimeDivider extends StatelessWidget {
  const _TimeDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 20,
      color: AppColors.gray300,
      margin: const EdgeInsets.symmetric(horizontal: 12),
    );
  }
}

class _TimeSection extends StatelessWidget {
  const _TimeSection({required this.text, required this.icon});

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.black),
        const SizedBox(width: 12),
        Text(
          text,
          style: AppTheme.mono.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }
}
