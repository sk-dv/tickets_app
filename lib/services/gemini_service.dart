import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:tickets_app/models/category.dart';
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
      final prompt =
          '''
          Analiza este ticket de compra y extrae la siguiente información en formato JSON.
          Si algún campo no está visible, usa null.

          Formato requerido:
          {
            "comercio": "nombre del establecimiento",
            "fecha": "YYYY-MM-DD",
            "hora": "HH:MM:SS",
            "total": número (sin símbolo de moneda),
            "direccion": "dirección completa",
            "categoria": "UNA de: ${Categories.all.map((c) => c.nombre).join(', ')}",
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
          ''';

      final content = [
        Content.multi([
          TextPart(prompt),
          DataPart('image/jpeg', await File(imagePath).readAsBytes()),
        ]),
      ];

      final response = await _model.generateContent(content);
      final text = response.text ?? '';

      final cleanJson = text
          .replaceAll('```json', '')
          .replaceAll('```', '')
          .trim();

      final extractionTime =
          DateTime.now().difference(startTime).inMilliseconds / 1000;

      final json = _parseJson(cleanJson);
      json['tiempo_extraccion'] = extractionTime;

      return GeminiResponse.fromJson(json);
    } catch (e) {
      throw Exception('Error al analizar ticket: $e');
    }
  }

  Map<String, dynamic> _parseJson(String text) {
    try {
      return Map<String, dynamic>.from(const JsonDecoder().convert(text));
    } catch (e) {
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
