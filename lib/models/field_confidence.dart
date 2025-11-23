class FieldConfidence {
  final String fieldName;
  final double confidence;
  final String value;

  FieldConfidence({
    required this.fieldName,
    required this.confidence,
    required this.value,
  });

  // Calcula confianza simple basada en si hay datos
  static double calculate(String? value) {
    if (value == null || value.isEmpty) return 0.0;

    // Confianza basada en longitud y contenido
    if (value.length < 2) return 0.65;
    if (value.length < 5) return 0.80;
    return 0.92;
  }

  static String getLabel(double confidence) {
    if (confidence >= 0.85) return 'Alta';
    if (confidence >= 0.65) return 'Media';
    if (confidence > 0) return 'Baja';
    return 'Sin datos';
  }
}
