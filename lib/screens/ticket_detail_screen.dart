import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickets_app/core/theme/app_colors.dart';
import 'package:tickets_app/core/theme/app_theme.dart';
import 'package:tickets_app/models/ticket.dart';
import 'package:tickets_app/models/gemini_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:tickets_app/widgets/date_time_button.dart';
import 'package:tickets_app/widgets/icon_picker.dart';
import 'package:tickets_app/widgets/shadowned_action_button.dart';
import 'package:tickets_app/widgets/shadowned_button.dart';
import 'package:tickets_app/widgets/time_wrapper.dart';
import 'package:tickets_app/utils/confidence_calculator.dart';
import 'package:tickets_app/widgets/confidence_breakdown.dart';
import 'package:tickets_app/widgets/field_confidence_indicator.dart';
import 'package:intl/intl.dart';

class TicketDetailScreen extends ConsumerStatefulWidget {
  final Ticket ticket;

  const TicketDetailScreen({super.key, required this.ticket});

  @override
  ConsumerState<TicketDetailScreen> createState() => _TicketDetailScreenState();
}

class _TicketDetailScreenState extends ConsumerState<TicketDetailScreen> {
  ConfidenceResult? _confidenceResult;
  late final GeminiResponse _originalValues;

  late final TextEditingController _montoController;
  late final TextEditingController _comercioController;
  late final TextEditingController _categoriaController;
  late DateTime _selectedDateTime;
  late IconData _selectedIcon;
  late String _selectedCategoria;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = widget.ticket.fecha;
    _selectedIcon = widget.ticket.icon;
    _selectedCategoria = widget.ticket.categoria;

    _montoController = TextEditingController(
      text: widget.ticket.total.toStringAsFixed(2),
    );
    _comercioController = TextEditingController(text: widget.ticket.comercio);
    _categoriaController = TextEditingController(text: widget.ticket.categoria);

    // Guardar valores originales como referencia
    _originalValues = GeminiResponse(
      comercio: widget.ticket.comercio,
      fecha: DateFormat('yyyy-MM-dd').format(widget.ticket.fecha),
      hora: DateFormat('HH:mm:ss').format(widget.ticket.fecha),
      total: widget.ticket.total,
      direccion: widget.ticket.direccion ?? '',
      productos: [],
      categoria: widget.ticket.categoria,
    );

    _montoController.addListener(_recalculateConfidence);
    _comercioController.addListener(_recalculateConfidence);

    _recalculateConfidence();
  }

  @override
  void dispose() {
    _montoController.removeListener(_recalculateConfidence);
    _comercioController.removeListener(_recalculateConfidence);
    _montoController.dispose();
    _comercioController.dispose();
    _categoriaController.dispose();
    super.dispose();
  }

  void _onIconChanged(IconData icon, String categoria) {
    setState(() {
      _selectedIcon = icon;
      _selectedCategoria = categoria;
      _categoriaController.text = categoria;
    });
    _recalculateConfidence();
  }

  void _recalculateConfidence() {
    final parsedTotal = double.tryParse(
      _montoController.text.replaceAll(',', '.'),
    ) ?? 0.0;

    final currentValues = GeminiResponse(
      comercio: _comercioController.text.trim(),
      fecha: DateFormat('yyyy-MM-dd').format(_selectedDateTime),
      hora: DateFormat('HH:mm:ss').format(_selectedDateTime),
      total: parsedTotal,
      direccion: _originalValues.direccion,
      productos: [],
      categoria: _selectedCategoria,
    );

    setState(() {
      _confidenceResult = ConfidenceCalculator.calculateDetailed(
        gemini: _originalValues,
        usuario: currentValues,
      );
    });
  }

  FieldScore? _getFieldScore(String fieldName) {
    if (_confidenceResult == null) return null;
    return _confidenceResult!.fields.firstWhere(
      (field) => field.fieldName == fieldName,
    );
  }

  void _saveForm() {
    final parsedTotal = double.tryParse(
      _montoController.text.replaceAll(',', '.'),
    );
    if (parsedTotal == null) return;

    // TODO: Persistir cambios en la fuente de datos (supabase / estado)
    // Ejemplo de payload:
    // final updated = widget.ticket.copyWith(
    //   total: parsedTotal,
    //   fecha: _selectedDateTime,
    //   comercio: _comercioController.text.trim(),
    //   categoria: _categoriaController.text.trim(),
    // );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cambios validados. Listo para guardar.')),
    );
  }

  Future<void> _showDateTimePicker() async {
    DateTime? pickedDate = _selectedDateTime;
    Duration? pickedTime;

    await showTimeModal(
      context,
      section: TimeSection.date,
      builder: (context, overlay) => CupertinoDatePicker(
        backgroundColor: AppColors.white,
        mode: CupertinoDatePickerMode.date,
        minimumYear: 2020,
        maximumYear: DateTime.now().year,
        initialDateTime: _selectedDateTime,
        dateOrder: DatePickerDateOrder.mdy,
        onDateTimeChanged: (datetime) => pickedDate = datetime,
        selectionOverlayBuilder: overlay,
      ),
    );

    if (pickedDate != null && mounted) {
      await showTimeModal(
        context,
        section: TimeSection.time,
        builder: (context, overlay) => CupertinoDatePicker(
          backgroundColor: AppColors.white,
          mode: CupertinoDatePickerMode.time,
          initialDateTime: DateTime(
            _selectedDateTime.year,
            _selectedDateTime.month,
            _selectedDateTime.day,
            _selectedDateTime.hour,
            _selectedDateTime.minute,
            _selectedDateTime.second,
          ),
          onDateTimeChanged: (DateTime newDateTime) {
            pickedTime = Duration(
              hours: newDateTime.hour,
              minutes: newDateTime.minute,
              seconds: newDateTime.second,
            );
          },
          selectionOverlayBuilder: overlay,
        ),
      );
    }

    if (pickedTime != null) {
      setState(() {
        _selectedDateTime = DateTime(
          pickedDate!.year,
          pickedDate!.month,
          pickedDate!.day,
          pickedTime!.inHours,
          pickedTime!.inMinutes.remainder(60),
          pickedTime!.inSeconds.remainder(60),
        );
      });
      _recalculateConfidence();
    } else if (pickedDate != null) {
      setState(() {
        _selectedDateTime = DateTime(
          pickedDate!.year,
          pickedDate!.month,
          pickedDate!.day,
          _selectedDateTime.hour,
          _selectedDateTime.minute,
          _selectedDateTime.second,
        );
      });
      _recalculateConfidence();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.all(8),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.white,
        appBar: AppBar(
          surfaceTintColor: AppColors.white,
          elevation: 0,
          actions: [
            ShadownedButton(
              onPressed: _saveForm,
              child: Icon(Icons.save, color: AppColors.black, size: 24),
            ),
          ],
          leading: ShadownedButton(
            onPressed: Navigator.of(context).pop,
            child: Icon(Icons.chevron_left, color: AppColors.black, size: 24),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.fromLTRB(8, 10, 8, 20),
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.black),
            boxShadow: [
              BoxShadow(color: AppColors.black, offset: const Offset(3, 3)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconPicker(
                initialIcon: _selectedIcon,
                onIconChanged: _onIconChanged,
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _montoController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    style: AppTheme.mono.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Total',
                      labelStyle: TextStyle(color: AppColors.gray600, fontSize: 13),
                      prefixText: '\$',
                      border: InputBorder.none,
                    ),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Ingrese el total';
                      final parsed = double.tryParse(v.replaceAll(',', '.'));
                      if (parsed == null) return 'Total inválido';
                      if (parsed < 0) return 'El total no puede ser negativo';
                      return null;
                    },
                  ),
                  if (_getFieldScore('Total') != null)
                    FieldConfidenceIndicator(
                      score: _getFieldScore('Total')!.score,
                      isModified: _getFieldScore('Total')!.wasModified,
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DateTimeButton(
                    dateTime: _selectedDateTime,
                    onTap: _showDateTimePicker,
                  ),
                  if (_getFieldScore('Fecha') != null)
                    FieldConfidenceIndicator(
                      score: (_getFieldScore('Fecha')!.score + _getFieldScore('Hora')!.score) / 2,
                      isModified: _getFieldScore('Fecha')!.wasModified || _getFieldScore('Hora')!.wasModified,
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _comercioController,
                    decoration: const InputDecoration(
                      labelText: 'Comercio',
                      labelStyle: TextStyle(fontSize: 13, color: AppColors.gray600),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'Ingrese el comercio'
                        : null,
                  ),
                  if (_getFieldScore('Comercio') != null)
                    FieldConfidenceIndicator(
                      score: _getFieldScore('Comercio')!.score,
                      isModified: _getFieldScore('Comercio')!.wasModified,
                    ),
                ],
              ),

              const SizedBox(height: 4),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _categoriaController,
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'Categoría',
                      labelStyle: TextStyle(fontSize: 13, color: AppColors.gray600),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(fontSize: 16, color: AppColors.gray600),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'Seleccione un ícono'
                        : null,
                  ),
                  if (_getFieldScore('Categoría') != null)
                    FieldConfidenceIndicator(
                      score: _getFieldScore('Categoría')!.score,
                      isModified: _getFieldScore('Categoría')!.wasModified,
                    ),
                ],
              ),
              const SizedBox(height: 24),
              if (_confidenceResult != null) ...[
                const Text(
                  'CONFIABILIDAD DE DATOS',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.gray600,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 12),
                ConfidenceBreakdown(result: _confidenceResult!),
              ],

              const Spacer(),
              ShadownedActionButton(
                text: 'GUARDAR CAMBIOS',
                onPressed: _saveForm,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
