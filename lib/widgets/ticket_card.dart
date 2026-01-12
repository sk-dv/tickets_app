import 'package:flutter/material.dart';
import 'package:tickets_app/core/theme/app_colors.dart';
import 'package:tickets_app/core/theme/app_theme.dart';
import 'package:tickets_app/models/ticket.dart';
import 'package:tickets_app/widgets/shadowned_button.dart';

class TicketCard extends StatelessWidget {
  final Ticket ticket;
  final VoidCallback onTap;

  const TicketCard({super.key, required this.ticket, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ShadownedButton(
      scales: (1.0, 0.98),
      onPressed: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            // Ícono circular
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.black,
                shape: BoxShape.circle,
              ),
              child: Icon(ticket.icon, size: 20, color: AppColors.white),
            ),
            const SizedBox(width: 16),
            // Info del ticket
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ticket.comercio,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatFecha(ticket.fecha),
                    style: AppTheme.mono.copyWith(
                      fontSize: 13,
                      color: AppColors.gray600,
                    ),
                  ),
                ],
              ),
            ),
            // Monto
            Text(
              '\$${ticket.total.toStringAsFixed(2)}',
              style: AppTheme.mono.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatFecha(DateTime fecha) {
    final months = [
      'Ene',
      'Feb',
      'Mar',
      'Abr',
      'May',
      'Jun',
      'Jul',
      'Ago',
      'Sep',
      'Oct',
      'Nov',
      'Dic',
    ];
    return '${months[fecha.month - 1]} ${fecha.day} • ${fecha.hour.toString().padLeft(2, '0')}:${fecha.minute.toString().padLeft(2, '0')}';
  }
}
