import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:tickets_app/models/category.dart';

part 'ticket.g.dart';

@embedded
class Product {
  late String nombre;
  late int cantidad;
  late double precio;

  Product({
    this.nombre = '',
    this.cantidad = 0,
    this.precio = 0.0,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      nombre: json['nombre'] ?? '',
      cantidad: json['cantidad'] ?? 0,
      precio: (json['precio'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'nombre': nombre,
        'cantidad': cantidad,
        'precio': precio,
      };
}

@collection
class Ticket {
  Id id = Isar.autoIncrement;

  @Index()
  late String comercio;

  @Index()
  late DateTime fecha;

  late double total;

  @Index()
  late String categoria;

  String? direccion;
  double? tiempoExtraccion;
  DateTime? fechaProcesamiento;
  bool handmade;

  List<Product> productos;

  Ticket({
    this.id = Isar.autoIncrement,
    required this.comercio,
    required this.fecha,
    required this.total,
    required this.categoria,
    this.productos = const [],
    this.direccion,
    this.tiempoExtraccion,
    this.fechaProcesamiento,
    this.handmade = false,
  });

  @ignore
  IconData get icon {
    final category = Categories.all.cast<Category>().firstWhere(
      (c) => c.nombre.toLowerCase() == categoria.toLowerCase(),
      orElse: () => Categories.all.last,
    );
    return category.icono;
  }

  @ignore
  List<Product> get products => productos;

  factory Ticket.fromJson(Map<String, dynamic> json) {
    final items = json['productos'] as List<dynamic>? ?? [];

    DateTime parsedFecha;
    try {
      final fecha =
          json['fecha'] ?? DateTime.now().toIso8601String().split('T')[0];
      final hora = json['hora'] ?? '00:00:00';
      parsedFecha = DateTime.parse('${fecha}T$hora');
    } catch (_) {
      parsedFecha = DateTime.now();
    }

    return Ticket(
      comercio: json['comercio'] ?? '',
      fecha: parsedFecha,
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      categoria: json['categoría'] ?? json['categoria'] ?? '',
      productos: items.map((item) => Product.fromJson(item)).toList(),
      direccion: json['direccion'],
      tiempoExtraccion: (json['tiempo_extraccion'] as num?)?.toDouble(),
      fechaProcesamiento: json['fecha_procesamiento'] != null
          ? DateTime.parse(json['fecha_procesamiento'])
          : null,
      handmade: json['handmade'] ?? false,
    );
  }

  factory Ticket.empty() {
    return Ticket(
      comercio: '',
      fecha: DateTime.now(),
      total: 0.0,
      categoria: '',
      productos: [],
      handmade: false,
    );
  }
}
