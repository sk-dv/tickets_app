import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickets_app/main.dart';
import 'package:tickets_app/models/ticket.dart';

final ticketsProvider = AsyncNotifierProvider<TicketsNotifier, List<Ticket>>(
  () => TicketsNotifier(),
);

class TicketsNotifier extends AsyncNotifier<List<Ticket>> {
  Future<String?> saveTicket({
    required String comercio,
    required String fecha,
    required String hora,
    required double total,
    required String direccion,
    required String categoria,
    bool handmade = false,
  }) async {
    state = const AsyncValue.loading();

    final response = await supabase.from('tickets').insert({
      'comercio': comercio,
      'fecha': fecha,
      'hora': hora,
      'total': total,
      'direccion': direccion,
      'categoría': categoria,
      'productos': [],
      'handmade': handmade,
    }).select();

    if (response.isNotEmpty) {
      final newTicket = Ticket.fromJson(response.first);
      state = AsyncData<List<Ticket>>([newTicket, ...state.value ?? []]);
      return newTicket.id;
    }

    state = AsyncData<List<Ticket>>([]);
    return null;
  }

  Future<void> saveTrainingData({
    required String comercio,
    required String fotoPath,
    required Map<String, dynamic> geminiOriginal,
    required Map<String, dynamic> usuarioCorreccion,
    required String categoriaFinal,
    required bool handmade,
    required double confianzaGemini,
    String? ticketId,
  }) async {
    await supabase.from('training_data').insert({
      'comercio': comercio,
      'foto_path': fotoPath,
      'gemini_original': geminiOriginal,
      'usuario_correccion': usuarioCorreccion,
      'categoria_final': categoriaFinal,
      'handmade': handmade,
      'confianza_gemini': confianzaGemini,
      if (ticketId != null) 'ticket_id': ticketId,
    });
  }

  void addTicket(Ticket ticket) {
    state = AsyncData<List<Ticket>>([ticket, ...state.value ?? []]);
  }

  void updateTicket(String id, Ticket ticket) {
    state = AsyncData<List<Ticket>>([
      for (final t in state.value ?? [])
        if (t.id == id) ticket else t,
    ]);
  }

  @override
  Future<List<Ticket>> build() async {
    try {
      final tickets = await supabase
          .from('tickets')
          .select()
          .order('fecha', ascending: false);

      return tickets.map((ticket) => Ticket.fromJson(ticket)).toList();
    } catch (e) {
      return [];
    }
  }
}
