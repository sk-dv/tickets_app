import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickets_app/models/ticket.dart';
import 'package:tickets_app/services/isar_service.dart';

final ticketsProvider = AsyncNotifierProvider<TicketsNotifier, List<Ticket>>(
  () => TicketsNotifier(),
);

class TicketsNotifier extends AsyncNotifier<List<Ticket>> {
  final _isarService = IsarService();

  Future<int?> saveTicket({
    required String comercio,
    required String fecha,
    required String hora,
    required double total,
    required String direccion,
    required String categoria,
    bool handmade = false,
  }) async {
    state = const AsyncValue.loading();

    try {
      final parsedFecha = DateTime.parse('${fecha}T$hora');

      final ticket = Ticket(
        comercio: comercio,
        fecha: parsedFecha,
        total: total,
        categoria: categoria,
        direccion: direccion,
        productos: [],
        handmade: handmade,
        fechaProcesamiento: DateTime.now(),
      );

      final id = await _isarService.saveTicket(ticket);
      final newTicket = await _isarService.getTicket(id);

      if (newTicket != null) {
        state = AsyncData<List<Ticket>>([newTicket, ...state.value ?? []]);
        return id;
      }

      state = AsyncData<List<Ticket>>([]);
      return null;
    } catch (e) {
      state = AsyncData<List<Ticket>>([]);
      return null;
    }
  }

  void addTicket(Ticket ticket) {
    state = AsyncData<List<Ticket>>([ticket, ...state.value ?? []]);
  }

  void updateTicket(int id, Ticket ticket) {
    state = AsyncData<List<Ticket>>([
      for (final t in state.value ?? [])
        if (t.id == id) ticket else t,
    ]);
  }

  Future<void> deleteTicket(int id) async {
    await _isarService.deleteTicket(id);
    state = AsyncData<List<Ticket>>([
      for (final t in state.value ?? [])
        if (t.id != id) t,
    ]);
  }

  @override
  Future<List<Ticket>> build() async {
    try {
      return await _isarService.getAllTickets();
    } catch (e) {
      return [];
    }
  }
}
