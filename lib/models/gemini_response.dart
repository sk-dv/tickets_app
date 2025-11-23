class Producto {
  final String nombre;
  final int cantidad;
  final double precio;

  Producto({
    required this.nombre,
    required this.cantidad,
    required this.precio,
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      nombre: json['nombre'] ?? '',
      cantidad: json['cantidad'] ?? 1,
      precio: (json['precio'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'nombre': nombre,
    'cantidad': cantidad,
    'precio': precio,
  };
}

class GeminiResponse {
  final String comercio;
  final String fecha;
  final String hora;
  final double total;
  final String direccion;
  final List<Producto> productos;
  final String? categoria;
  final double? tiempoExtraccion;

  GeminiResponse({
    required this.comercio,
    required this.fecha,
    required this.hora,
    required this.total,
    required this.direccion,
    required this.productos,
    this.categoria,
    this.tiempoExtraccion,
  });

  factory GeminiResponse.fromJson(Map<String, dynamic> json) {
    return GeminiResponse(
      comercio: json['comercio'] ?? '',
      fecha: json['fecha'] ?? '',
      hora: json['hora'] ?? '',
      total: (json['total'] ?? 0).toDouble(),
      direccion: json['direccion'] ?? '',
      productos: (json['productos'] as List?)
          ?.map((p) => Producto.fromJson(p))
          .toList() ?? [],
      categoria: json['categoria'],
      tiempoExtraccion: (json['tiempo_extraccion'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'comercio': comercio,
    'fecha': fecha,
    'hora': hora,
    'total': total,
    'direccion': direccion,
    'productos': productos.map((p) => p.toJson()).toList(),
    'categoria': categoria,
    'tiempo_extraccion': tiempoExtraccion,
  };
}