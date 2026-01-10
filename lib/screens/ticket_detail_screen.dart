import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickets_app/core/theme/app_colors.dart';
import 'package:tickets_app/core/theme/app_theme.dart';
import 'package:tickets_app/models/ticket.dart';
import 'package:flutter/cupertino.dart';
import 'package:tickets_app/widgets/date_time_button.dart';
import 'package:tickets_app/widgets/shadowned_action_button.dart';
import 'package:tickets_app/widgets/shadowned_button.dart';
import 'package:tickets_app/widgets/time_wrapper.dart';

class TicketDetailScreen extends ConsumerStatefulWidget {
  final Ticket ticket;

  const TicketDetailScreen({super.key, required this.ticket});

  @override
  ConsumerState<TicketDetailScreen> createState() => _TicketDetailScreenState();
}

class _TicketDetailScreenState extends ConsumerState<TicketDetailScreen> {
  double? _confianza;
  bool _loading = true;

  late final TextEditingController _montoController;
  late final TextEditingController _comercioController;
  late final TextEditingController _categoriaController;
  late DateTime _selectedDateTime;
  late IconData _selectedIcon;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = widget.ticket.fecha;
    _selectedIcon = widget.ticket.icon;
    _montoController = TextEditingController(
      text: widget.ticket.total.toStringAsFixed(2),
    );
    _comercioController = TextEditingController(text: widget.ticket.comercio);
    _categoriaController = TextEditingController(text: widget.ticket.categoria);
    _loadConfianza();
  }

  @override
  void dispose() {
    _montoController.dispose();
    _comercioController.dispose();
    _categoriaController.dispose();
    super.dispose();
  }

  Future<void> _loadConfianza() async {
    // TODO: Implementar carga de confianza desde Isar si se necesita
    setState(() => _loading = false);
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
    } else {
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
    }
  }

  Future<void> _showIconPicker() async {
    final icons = [
      Icons.shopping_cart,
      Icons.restaurant,
      Icons.local_gas_station,
      Icons.medical_services,
      Icons.school,
      Icons.home,
      Icons.flight,
      Icons.hotel,
      Icons.local_movies,
      Icons.fitness_center,
      Icons.pets,
      Icons.toys,
      Icons.local_grocery_store,
      Icons.local_pharmacy,
      Icons.spa,
      Icons.sports_soccer,
      Icons.music_note,
      Icons.book,
      Icons.coffee,
      Icons.fastfood,
    ];

    await showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Seleccionar ícono',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: icons.length,
                  itemBuilder: (context, index) {
                    final icon = icons[index];
                    final isSelected = icon == _selectedIcon;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIcon = icon;
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryPastel
                              : AppColors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.gray300,
                              blurRadius: 2,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          icon,
                          size: 28,
                          color: isSelected ? AppColors.white : AppColors.black,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
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
              GestureDetector(
                onTap: _showIconPicker,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.black, width: 0.5),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black,
                        blurRadius: 0,
                        spreadRadius: 1,
                        offset: const Offset(1.5, 2),
                      ),
                    ],
                  ),
                  child: Icon(_selectedIcon, size: 25, color: AppColors.black),
                ),
              ),
              const SizedBox(height: 16),
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
              const SizedBox(height: 8),
              DateTimeButton(
                dateTime: _selectedDateTime,
                onTap: _showDateTimePicker,
              ),
              const SizedBox(height: 16),
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

              const SizedBox(height: 4),

              TextFormField(
                controller: _categoriaController,
                decoration: const InputDecoration(
                  labelText: 'Categoría',
                  labelStyle: TextStyle(fontSize: 13, color: AppColors.gray600),
                  border: InputBorder.none,
                ),
                style: const TextStyle(fontSize: 16, color: AppColors.black),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Ingrese la categoría'
                    : null,
              ),
              const SizedBox(height: 32),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
