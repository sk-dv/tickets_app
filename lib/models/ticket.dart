import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String nombre;
  final int cantidad;
  final double precio;

  const Product({
    required this.nombre,
    required this.cantidad,
    required this.precio,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      nombre: json['nombre'] ?? '',
      cantidad: json['cantidad'] ?? 0,
      precio: (json['precio'] as num).toDouble(),
    );
  }

  @override
  List<Object> get props => [nombre, cantidad, precio];
}

class Ticket extends Equatable {
  final String id;
  final String comercio;
  final DateTime fecha;
  final double total;
  final String categoria;
  final List<Product> products;

  const Ticket({
    required this.id,
    required this.comercio,
    required this.fecha,
    required this.total,
    required this.categoria,
    this.products = const [],
  });
  

  factory Ticket.fromJson(Map<String, dynamic> json) {
    final items = json['productos'] as List<dynamic>? ?? [];

    // Manejar fecha/hora NULLs
    DateTime parsedFecha;
    try {
      final fecha = json['fecha'] ?? DateTime.now().toIso8601String().split('T')[0];
      final hora = json['hora'] ?? '00:00:00';
      parsedFecha = DateTime.parse('${fecha}T$hora');
    } catch (_) {
      parsedFecha = DateTime.now();
    }

    return Ticket(
      id: json['id'].toString(),
      comercio: json['comercio'] ?? '',
      fecha: parsedFecha,
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      categoria: json['categoría'] ?? '',
      products: items.map((item) => Product.fromJson(item)).toList(),
    );
  }

  @override
  List<Object> get props => [id, comercio, fecha, total, categoria, products];
}
