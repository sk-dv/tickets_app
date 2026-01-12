import 'dart:math';
import 'package:tickets_app/models/gemini_response.dart';

class FieldScore {
  final String fieldName;
  final double score;
  final String original;
  final String current;

  const FieldScore({
    required this.fieldName,
    required this.score,
    required this.original,
    required this.current,
  });

  bool get wasModified => score < 0.99;
}

class ConfidenceResult {
  final double overall;
  final List<FieldScore> fields;

  const ConfidenceResult({
    required this.overall,
    required this.fields,
  });

  int get modifiedFieldsCount => fields.where((f) => f.wasModified).length;
}

class ConfidenceCalculator {
  static double calculate({
    required GeminiResponse gemini,
    required GeminiResponse usuario,
  }) {
    final scores = <double>[
      gemini.comercio.compareString(usuario.comercio),
      gemini.fecha.compareString(usuario.fecha),
      gemini.hora.compareString(usuario.hora),
      gemini.total.compareNumber(usuario.total),
      gemini.direccion.compareString(usuario.direccion),
      gemini.categoria?.compareString(usuario.categoria ?? '') ?? 0.0,
    ];

    final avg = scores.reduce((a, b) => a + b) / scores.length;
    return (avg * 100).clamp(0, 100);
  }

  static ConfidenceResult calculateDetailed({
    required GeminiResponse gemini,
    required GeminiResponse usuario,
  }) {
    final fields = <FieldScore>[
      FieldScore(
        fieldName: 'Comercio',
        score: gemini.comercio.compareString(usuario.comercio),
        original: gemini.comercio,
        current: usuario.comercio,
      ),
      FieldScore(
        fieldName: 'Fecha',
        score: gemini.fecha.compareString(usuario.fecha),
        original: gemini.fecha,
        current: usuario.fecha,
      ),
      FieldScore(
        fieldName: 'Hora',
        score: gemini.hora.compareString(usuario.hora),
        original: gemini.hora,
        current: usuario.hora,
      ),
      FieldScore(
        fieldName: 'Total',
        score: gemini.total.compareNumber(usuario.total),
        original: '\$${gemini.total.toStringAsFixed(2)}',
        current: '\$${usuario.total.toStringAsFixed(2)}',
      ),
      FieldScore(
        fieldName: 'Categoría',
        score: gemini.categoria?.compareString(usuario.categoria ?? '') ?? 1.0,
        original: gemini.categoria ?? '',
        current: usuario.categoria ?? '',
      ),
    ];

    final avg = fields.map((f) => f.score).reduce((a, b) => a + b) / fields.length.toDouble();
    final overall = (avg * 100).clamp(0.0, 100.0).toDouble();

    return ConfidenceResult(overall: overall, fields: fields);
  }
}

extension on double {
  double compareNumber(double b) {
    if (this == 0 && b == 0) return 1.0;
    if (this == 0 || b == 0) return 0.0;

    final diff = (this - b).abs();
    final tolerance = max(this, b) * 0.05;
    if (diff <= tolerance) return 1.0;
    return max(0, 1.0 - (diff / max(this, b)));
  }
}

extension on String {
  double compareString(String b) {
    if (isEmpty && b.isEmpty) return 1.0;
    if (isEmpty || b.isEmpty) return 0.0;

    final distance = _levenshtein(toLowerCase(), b.toLowerCase());
    final maxLen = max(length, b.length);
    return 1.0 - (distance / maxLen);
  }

  static int _levenshtein(String s, String t) {
    if (s == t) return 0;
    if (s.isEmpty) return t.length;
    if (t.isEmpty) return s.length;

    List<int> v0 = List.generate(t.length + 1, (i) => i);
    List<int> v1 = List.filled(t.length + 1, 0);

    for (int i = 0; i < s.length; i++) {
      v1[0] = i + 1;
      for (int j = 0; j < t.length; j++) {
        final cost = s[i] == t[j] ? 0 : 1;
        v1[j + 1] = [v1[j] + 1, v0[j + 1] + 1, v0[j] + cost].reduce(min);
      }
      final temp = v0;
      v0 = v1;
      v1 = temp;
    }
    return v0[t.length];
  }
}
