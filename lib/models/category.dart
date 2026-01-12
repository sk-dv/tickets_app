
import 'package:flutter/material.dart';

class Category {
  final String id;
  final String nombre;
  final IconData icono;
  final List<String> keywords;

  const Category({
    required this.id,
    required this.nombre,
    required this.icono,
    this.keywords = const [],
  });
}

class Categories {
  static const List<Category> all = [
    Category(
      id: 'electronica',
      nombre: 'Electrónica',
      icono: Icons.devices,
      keywords: [
        'electrónica',
        'celular',
        'computadora',
        'laptop',
        'tablet',
        'auriculares',
        'cargador',
        'cable',
        'gadget',
      ],
    ),
    Category(
      id: 'bebidas',
      nombre: 'Bebidas/Aguas',
      icono: Icons.local_drink,
      keywords: [
        'agua',
        'refresco',
        'jugo',
        'bebida',
        'soda',
        'té',
        'café',
        'ciel',
        'bonafont',
        'coca',
      ],
    ),
    Category(
      id: 'alcohol',
      nombre: 'Alcohol',
      icono: Icons.local_bar,
      keywords: [
        'cerveza',
        'vino',
        'licor',
        'bar',
        'cantina',
        'whisky',
        'tequila',
        'ron',
        'vodka',
      ],
    ),
    Category(
      id: 'comida',
      nombre: 'Comida/Restaurante',
      icono: Icons.restaurant,
      keywords: [
        'restaurante',
        'comida',
        'taquería',
        'mariscos',
        'pizzería',
        'sushi',
        'tacos',
        'hamburguesa',
        'tortas',
      ],
    ),
    Category(
      id: 'ropa',
      nombre: 'Ropa/Telas',
      icono: Icons.shopping_bag,
      keywords: [
        'ropa',
        'tela',
        'tienda',
        'moda',
        'zapatos',
        'pantalón',
        'camisa',
        'vestido',
        'zara',
        'hm',
      ],
    ),
    Category(
      id: 'salud',
      nombre: 'Medicina/Salud',
      icono: Icons.medical_services,
      keywords: [
        'farmacia',
        'medicina',
        'doctor',
        'hospital',
        'consulta',
        'guadalajara',
        'benavides',
        'ahorro',
        'similares',
      ],
    ),
    Category(
      id: 'higiene',
      nombre: 'Higiene',
      icono: Icons.cleaning_services,
      keywords: [
        'jabón',
        'shampoo',
        'pasta',
        'higiene',
        'limpieza',
        'detergente',
        'suavizante',
        'desodorante',
        'papel',
      ],
    ),
    Category(
      id: 'esparcimiento',
      nombre: 'Esparcimiento',
      icono: Icons.movie,
      keywords: [
        'cine',
        'diversión',
        'parque',
        'museo',
        'entretenimiento',
        'cinépolis',
        'cinemex',
        'teatro',
        'concierto',
      ],
    ),
    Category(
      id: 'lavanderia',
      nombre: 'Lavandería',
      icono: Icons.local_laundry_service,
      keywords: [
        'lavandería',
        'tintorería',
        'lavado',
        'planchado',
        'limpieza',
        'ropa',
      ],
    ),
    Category(
      id: 'compras',
      nombre: 'Compras generales',
      icono: Icons.shopping_cart,
      keywords: [
        'oxxo',
        'soriana',
        'walmart',
        'chedraui',
        'super',
        '7-eleven',
        'supermercado',
        'tienda',
        'abarrotes',
      ],
    ),
    Category(
      id: 'transporte',
      nombre: 'Transporte',
      icono: Icons.directions_car,
      keywords: [
        'uber',
        'didi',
        'gasolina',
        'estacionamiento',
        'taxi',
        'metro',
        'autobús',
        'pemex',
        'combustible',
      ],
    ),
    Category(
      id: 'hogar',
      nombre: 'Hogar',
      icono: Icons.home,
      keywords: [
        'hogar',
        'casa',
        'muebles',
        'decoración',
        'ikea',
        'home depot',
        'reparación',
        'jardín',
        'ferretería',
      ],
    ),
    Category(
      id: 'educacion',
      nombre: 'Educación',
      icono: Icons.school,
      keywords: [
        'escuela',
        'universidad',
        'curso',
        'libros',
        'papelería',
        'útiles',
        'matrícula',
        'colegiatura',
        'academia',
      ],
    ),
    Category(
      id: 'mascotas',
      nombre: 'Mascotas',
      icono: Icons.pets,
      keywords: [
        'mascotas',
        'veterinario',
        'perro',
        'gato',
        'alimento',
        'comida',
        'petco',
        'pet',
        'veterinaria',
      ],
    ),
    Category(
      id: 'otros',
      nombre: 'Otros',
      icono: Icons.more_horiz,
      keywords: [],
    ),
  ];

  static Category inferFromComercio(String comercio) {
    final lower = comercio.toLowerCase();
    for (final cat in all) {
      if (cat.keywords.any((k) => lower.contains(k))) {
        return cat;
      }
    }
    return all.last;
  }
}
