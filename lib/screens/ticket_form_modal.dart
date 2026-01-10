import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickets_app/core/theme/app_colors.dart';
import 'package:tickets_app/models/gemini_response.dart';
import 'package:tickets_app/models/ticket.dart';
import 'package:tickets_app/providers/camera_provider.dart';
import 'package:tickets_app/providers/form_provider.dart';
import 'package:tickets_app/providers/ticket_provider.dart';
import 'package:tickets_app/widgets/app_button.dart';
import 'package:tickets_app/widgets/confirmation_view.dart';
import 'package:tickets_app/widgets/form_field.dart';

class TicketFormModal extends ConsumerWidget {
  final bool isManual;
  final Ticket ticket;

  const TicketFormModal({
    super.key,
    required this.ticket,
    this.isManual = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(formProvider);

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.92,
        minChildSize: 0.5,
        maxChildSize: 0.92,
        builder: (context, scrollController) {
          return formState.step == FormStep.editing
              ? EditingView(scrollController: scrollController, ticket: ticket)
              : ConfirmationView(
                  comercio: formState.userCorrections?.comercio ?? '',
                  total: formState.userCorrections?.total ?? 0,
                  categoria: formState.userCorrections?.categoria ?? '',
                  onDismiss: () {
                    ref.read(formProvider.notifier).reset();
                    Navigator.pop(context);
                  },
                );
        },
      ),
    );
  }
}

class EditingView extends ConsumerStatefulWidget {
  const EditingView({
    super.key,
    required this.scrollController,
    required this.ticket,
  });

  final ScrollController scrollController;
  final Ticket ticket;

  @override
  ConsumerState<EditingView> createState() => _EditingViewState();
}

class _EditingViewState extends ConsumerState<EditingView> {
  late final TextEditingController comercioController;
  late final TextEditingController fechaController;
  late final TextEditingController totalController;
  late final TextEditingController direccionController;
  late final TextEditingController categoriaController;

  @override
  void initState() {
    super.initState();
    comercioController = TextEditingController();
    fechaController = TextEditingController();
    totalController = TextEditingController();
    direccionController = TextEditingController();
    categoriaController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Prioridad 1: Cargar datos de Gemini si existen
      final cameraState = ref.read(cameraProvider);
      if (cameraState.geminiData != null) {
        _loadGeminiData(cameraState.geminiData!);
        ref.read(formProvider.notifier).setGeminiData(cameraState.geminiData!);
      }
      // Prioridad 2: Cargar datos del ticket existente
      else if (widget.ticket.id != 0) {
        _loadTicketData(widget.ticket);
      }
    });
  }

  void _loadGeminiData(GeminiResponse data) {
    comercioController.text = data.comercio;
    fechaController.text = data.fecha;
    totalController.text = data.total.toString();
    direccionController.text = data.direccion;
    categoriaController.text = data.categoria ?? '';
  }

  void _loadTicketData(Ticket ticket) {
    comercioController.text = ticket.comercio;
    fechaController.text = ticket.fecha.toIso8601String().split('T')[0];
    totalController.text = ticket.total.toString();
    direccionController.text = ''; // No tenemos dirección en el ticket
    categoriaController.text = ticket.categoria;
  }

  @override
  void dispose() {
    comercioController.dispose();
    fechaController.dispose();
    totalController.dispose();
    direccionController.dispose();
    categoriaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        // Título
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Revisar información',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      FeatherIcons.x,
                      color: AppColors.gray600,
                      size: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Consumer(
                builder: (context, ref, child) {
                  final isHandmade =
                      ref.read(cameraProvider).geminiData == null;
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isHandmade
                          ? AppColors.gray200
                          : AppColors.primaryPastel.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isHandmade ? FeatherIcons.edit3 : FeatherIcons.cpu,
                          size: 12,
                          color: isHandmade
                              ? AppColors.gray600
                              : AppColors.primaryPastel,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          isHandmade ? 'Creado manualmente' : 'Extraído con IA',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: isHandmade
                                ? AppColors.gray600
                                : AppColors.primaryPastel,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Formulario
        Expanded(
          child: SingleChildScrollView(
            controller: widget.scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                AppFormField(label: 'Comercio', controller: comercioController),
                const SizedBox(height: 16),
                AppFormField(label: 'Fecha', controller: fechaController),
                const SizedBox(height: 16),
                AppFormField(
                  label: 'Total',
                  controller: totalController,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                AppFormField(
                  label: 'Dirección',
                  controller: direccionController,
                  maxLines: 2,
                ),
                const SizedBox(height: 16),
                AppFormField(
                  label: 'Categoría',
                  controller: categoriaController,
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
        // Botón guardar
        Padding(
          padding: const EdgeInsets.all(24),
          child: AppButton(
            label: 'Guardar',
            onPressed: () async {
              // Guardar datos del formulario en el provider
              final corrections = GeminiResponse(
                comercio: comercioController.text,
                fecha: fechaController.text,
                hora: '',
                total: double.tryParse(totalController.text) ?? 0,
                direccion: direccionController.text,
                productos: [],
                categoria: categoriaController.text,
              );

              ref.read(formProvider.notifier).setUserCorrections(corrections);

              // Guardar en Isar
              try {
                final cameraState = ref.read(cameraProvider);

                // Guardar ticket
                await ref.read(ticketsProvider.notifier).saveTicket(
                      comercio: comercioController.text,
                      fecha: fechaController.text.isEmpty
                          ? DateTime.now().toIso8601String().split('T')[0]
                          : fechaController.text,
                      hora: '00:00:00',
                      total: double.tryParse(totalController.text) ?? 0,
                      direccion: direccionController.text,
                      categoria: categoriaController.text,
                      handmade: cameraState.geminiData == null,
                    );

                // Si llegamos aquí, el guardado fue exitoso
                ref.read(formProvider.notifier).moveToConfirming();
              } catch (e) {
                // TODO: Mostrar error al usuario
              }
            },
          ),
        ),
      ],
    );
  }
}
