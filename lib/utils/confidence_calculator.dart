import 'dart:math';
import 'package:tickets_app/models/gemini_response.dart';

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
