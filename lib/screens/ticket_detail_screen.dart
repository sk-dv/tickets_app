import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickets_app/core/theme/app_colors.dart';
import 'package:tickets_app/core/theme/app_theme.dart';
import 'package:tickets_app/main.dart';
import 'package:tickets_app/models/ticket.dart';
import 'package:tickets_app/screens/home_screen.dart';
import 'package:tickets_app/utils/category_icon_mapper.dart';

class TicketDetailScreen extends ConsumerStatefulWidget {
  final Ticket ticket;

  const TicketDetailScreen({super.key, required this.ticket});

  @override
  ConsumerState<TicketDetailScreen> createState() => _TicketDetailScreenState();
}

class _TicketDetailScreenState extends ConsumerState<TicketDetailScreen> {
  double? _confianza;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadConfianza();
  }

  Future<void> _loadConfianza() async {
    try {
      final response = await supabase
          .from('training_data')
          .select('confianza_gemini')
          .eq('ticket_id', widget.ticket.id)
          .maybeSingle();

      if (response != null && mounted) {
        setState(() {
          _confianza = (response['confianza_gemini'] as num?)?.toDouble();
          _loading = false;
        });
      } else {
        setState(() => _loading = false);
      }
    } catch (e) {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenHeight * 0.9,

      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 1,
        minChildSize: 0.85,
        maxChildSize: 1,
        builder: (context, scrollController) {
          return Column(
            children: [
              // Notch
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  margin: const EdgeInsets.only(top: 8, bottom: 16),
                  decoration: BoxDecoration(
                    color: AppColors.gray300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Header
              Text(
                'Detalle del ticket',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),

              const SizedBox(height: 24),

              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: AppColors.gray100,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  CategoryIconMapper.getIcon(
                                    widget.ticket.categoria,
                                  ),
                                  size: 40,
                                  color: AppColors.gray600,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                widget.ticket.comercio,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.ticket.categoria,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppColors.gray600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        // Total
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.primaryPastel,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'Total',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '\$${widget.ticket.total.toStringAsFixed(2)}',
                                style: AppTheme.mono.copyWith(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Información
                        _buildInfoRow(
                          'Fecha',
                          _formatFecha(widget.ticket.fecha),
                        ),
                        const Divider(height: 32, color: AppColors.gray200),
                        // Confianza (si existe)
                        if (_loading)
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: CircularProgressIndicator(
                                color: AppColors.primaryPastel,
                              ),
                            ),
                          )
                        else if (_confianza != null) ...[
                          const Text(
                            'Precisión del modelo',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.gray600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.gray50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: _getConfianzaColor(_confianza!),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${_confianza!.toStringAsFixed(0)}%',
                                      style: AppTheme.mono.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _getConfianzaLabel(_confianza!),
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        _getConfianzaDescription(_confianza!),
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: AppColors.gray600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.gray600,
          ),
        ),
        Text(
          value,
          style: AppTheme.mono.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }

  String _formatFecha(DateTime fecha) {
    final months = [
      'Enero',
      'Febrero',
      'Marzo',
      'Abril',
      'Mayo',
      'Junio',
      'Julio',
      'Agosto',
      'Septiembre',
      'Octubre',
      'Noviembre',
      'Diciembre',
    ];
    return '${fecha.day} de ${months[fecha.month - 1]} ${fecha.year}';
  }

  Color _getConfianzaColor(double confianza) {
    if (confianza >= 80) return Colors.green;
    if (confianza >= 60) return Colors.orange;
    return Colors.red;
  }

  String _getConfianzaLabel(double confianza) {
    if (confianza >= 80) return 'Alta precisión';
    if (confianza >= 60) return 'Precisión media';
    return 'Baja precisión';
  }

  String _getConfianzaDescription(double confianza) {
    if (confianza >= 80) return 'Pocos campos modificados';
    if (confianza >= 60) return 'Algunos campos modificados';
    return 'Muchos campos modificados';
  }
}
