import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickets_app/core/theme/app_colors.dart';
import 'package:tickets_app/core/theme/app_theme.dart';
import 'package:tickets_app/models/ticket.dart';
import 'package:tickets_app/providers/camera_provider.dart';
import 'package:tickets_app/providers/ticket_provider.dart';
import 'package:tickets_app/screens/ticket_detail_screen.dart';
import 'package:tickets_app/screens/ticket_form_modal.dart';
import 'package:tickets_app/widgets/ticket_card.dart';
import 'package:tickets_app/widgets/ticket_source_sheet.dart';

extension ScreenSizeExtension on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
}

extension ListTicketsExtension on List<Ticket> {
  Map<String, List<Ticket>> sortByDate() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    final Map<String, List<Ticket>> grouped = {
      'HOY': [],
      'AYER': [],
      'ESTE MES': [],
      'ANTERIORES': [],
    };

    for (final ticket in this) {
      if (ticket.fecha == today) {
        grouped['HOY']!.add(ticket);
      } else if (ticket.fecha == yesterday) {
        grouped['AYER']!.add(ticket);
      } else if (ticket.fecha.month == now.month &&
          ticket.fecha.year == now.year) {
        grouped['ESTE MES']!.add(ticket);
      } else {
        grouped['ANTERIORES']!.add(ticket);
      }
    }

    grouped.removeWhere((key, value) => value.isEmpty);
    return grouped;
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final response = ref.watch(ticketsProvider);

    return Scaffold(
      backgroundColor: AppColors.gray50,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: AppColors.gray50,
        title: Container(
          margin: const EdgeInsets.only(left: 16),
          child: Center(
            child: Text(
              'TICKETS',
              style: AppTheme.mono.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
          ),
        ),
      ),
      body: response.when<Widget>(
        data: (tickets) {
          final sorted = tickets.sortByDate();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'BUSCAR...',
                    hintStyle: AppTheme.mono.copyWith(
                      color: AppColors.gray400,
                      fontWeight: FontWeight.w400,
                    ),
                    prefixIcon: const Icon(
                      FeatherIcons.search,
                      color: AppColors.gray400,
                      size: 20,
                    ),
                    filled: false,
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.gray200),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.gray200),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primaryPastel,
                        width: 1.5,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),

              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  children: sorted.entries.expand((entry) {
                    return [
                      // Header de sección
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 16,
                          bottom: 8,
                          left: 16,
                        ),
                        child: Text(
                          entry.key,
                          style: AppTheme.mono.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.gray600,
                          ),
                        ),
                      ),
                      // Tickets de la sección
                      ...entry.value.map(
                        (ticket) => TicketCard(
                          ticket: ticket,
                          onTap: () => _openTicketDetail(context, ticket),
                        ),
                      ),
                    ];
                  }).toList(),
                ),
              ),
            ],
          );
        },
        loading: () {
          return const Center(child: CircularProgressIndicator(strokeWidth: 2));
        },
        error: (error, stack) {
          return const Center(
            child: Text(
              'No hay tickets',
              style: TextStyle(color: AppColors.gray400),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _handleAddTicket(context, ref),
        backgroundColor: AppColors.buttonPrimary,
        child: const Icon(FeatherIcons.camera, color: AppColors.white),
      ),
    );
  }

  void _handleAddTicket(BuildContext ctx, WidgetRef ref) async {
    final source = await showModalBottomSheet<TicketSource>(
      context: ctx,
      backgroundColor: Colors.transparent,
      builder: (_) => const TicketSourceSheet(),
    );

    if (source == null || !ctx.mounted) return;

    ref.read(cameraProvider.notifier).reset();

    switch (source) {
      case TicketSource.camera:
        await ref.read(cameraProvider.notifier).pickImage();
        break;
      case TicketSource.gallery:
        await ref.read(cameraProvider.notifier).pickFromGallery();
        break;
      case TicketSource.manual:
        // No hay procesamiento, directo al form
        break;
    }

    if (!ctx.mounted) return;

    final cameraState = ref.read(cameraProvider);

    if (source != TicketSource.manual &&
        cameraState.state == CameraState.error) {
      // TODO: mostrar error
      return;
    }

    await showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => TicketFormModal(
        isManual: source == TicketSource.manual,
        ticket: Ticket.empty(),
      ),
    );
  }

  void _openTicketDetail(BuildContext context, Ticket ticket) {
    print(ticket.toJson());
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => TicketDetailScreen(ticket: ticket)),
    );
  }
}
