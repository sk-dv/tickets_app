class TrainingData {
  final String usuarioId;
  final String comercio;
  final String fotoPath;
  final Map<String, dynamic> geminiOriginal;
  final Map<String, dynamic> usuarioCorreccion;
  final String categoriaFinal;
  final bool handmade;
  final double confianzaGemini;
  final String? ticketId;

  TrainingData({
    required this.usuarioId,
    required this.comercio,
    required this.fotoPath,
    required this.geminiOriginal,
    required this.usuarioCorreccion,
    required this.categoriaFinal,
    required this.handmade,
    required this.confianzaGemini,
    this.ticketId,
  });

  Map<String, dynamic> toJson() => {
    'usuario_id': usuarioId,
    'comercio': comercio,
    'foto_path': fotoPath,
    'gemini_original': geminiOriginal,
    'usuario_correccion': usuarioCorreccion,
    'categoria_final': categoriaFinal,
    'handmade': handmade,
    'confianza_gemini': confianzaGemini,
    if (ticketId != null) 'ticket_id': ticketId,
  };
}