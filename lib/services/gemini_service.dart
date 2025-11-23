import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:tickets_app/models/gemini_response.dart';

class GeminiService {
  late final GenerativeModel _model;

  GeminiService() {
    final apiKey = dotenv.env['GEMINI_API_KEY'];

    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('GEMINI_API_KEY no encontrada en .env');
    }

    _model = GenerativeModel(model: 'gemini-2.5-flash', apiKey: apiKey);
  }

  Future<GeminiResponse> analyzeTicket(String imagePath) async {
    final startTime = DateTime.now();

    try {
      // Leer imagen
      final imageBytes = await File(imagePath).readAsBytes();

      // Prompt optimizado para tickets
      final prompt = '''
Analiza este ticket de compra y extrae la siguiente información en formato JSON.
Si algún campo no está visible, usa null.

Formato requerido:
{
  "comercio": "nombre del establecimiento",
  "fecha": "YYYY-MM-DD",
  "hora": "HH:MM:SS",
  "total": número (sin símbolo de moneda),
  "direccion": "dirección completa",
  "categoria": "categoría inferida (Comida, Supermercado, Transporte, Café, Compras, Restaurante, etc.)",
  "productos": [
    {
      "nombre": "producto",
      "cantidad": número,
      "precio": número
    }
  ]
}

IMPORTANTE:
- Responde SOLO con el JSON, sin markdown ni explicaciones
- Si no encuentras un campo, usa null
- El total debe ser un número sin símbolos
- La categoría infierela del tipo de comercio
''';

      final content = [
        Content.multi([TextPart(prompt), DataPart('image/jpeg', imageBytes)]),
      ];

      final response = await _model.generateContent(content);
      final text = response.text ?? '';

      // Limpiar respuesta (remover markdown si existe)
      final cleanJson = text
          .replaceAll('```json', '')
          .replaceAll('```', '')
          .trim();

      // Calcular tiempo de extracción
      final extractionTime =
          DateTime.now().difference(startTime).inMilliseconds / 1000;

      // Parse JSON
      final json = _parseJson(cleanJson);
      json['tiempo_extraccion'] = extractionTime;

      return GeminiResponse.fromJson(json);
    } catch (e) {
      throw Exception('Error al analizar ticket: $e');
    }
  }

  Map<String, dynamic> _parseJson(String text) {
    try {
      // Intenta parsear como JSON
      return Map<String, dynamic>.from(
        // ignore: avoid_dynamic_calls
        const JsonDecoder().convert(text),
      );
    } catch (e) {
      // Si falla, retorna estructura vacía
      return {
        'comercio': '',
        'fecha': '',
        'hora': '',
        'total': 0.0,
        'direccion': '',
        'categoria': '',
        'productos': [],
      };
    }
  }
}
