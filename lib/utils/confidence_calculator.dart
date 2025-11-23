import 'package:tickets_app/models/gemini_response.dart';

class ConfidenceCalculator {
  static double calculate({
    required GeminiResponse gemini,
    required GeminiResponse usuario,
  }) {
    int totalCampos = 7;
    int camposSinCambios = 0;

    if (gemini.comercio == usuario.comercio) camposSinCambios++;
    if (gemini.fecha == usuario.fecha) camposSinCambios++;
    if (gemini.hora == usuario.hora) camposSinCambios++;
    if (gemini.total == usuario.total) camposSinCambios++;
    if (gemini.direccion == usuario.direccion) camposSinCambios++;
    if (gemini.categoria == usuario.categoria) camposSinCambios++;

    // Comparar productos (cantidad)
    if (gemini.productos.length == usuario.productos.length) {
      camposSinCambios++;
    }

    return (camposSinCambios / totalCampos) * 100;
  }
}
