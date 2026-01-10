import 'package:flutter_feather_icons/flutter_feather_icons.dart';
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
      id: 'supermercado',
      nombre: 'Supermercado',
      icono: FeatherIcons.shoppingCart,
      keywords: ['oxxo', 'soriana', 'walmart', 'chedraui', 'super', '7-eleven'],
    ),
    Category(
      id: 'restaurante',
      nombre: 'Restaurante',
      icono: FeatherIcons.coffee,
      keywords: ['restaurante', 'taquería', 'mariscos', 'pizzería'],
    ),
    Category(
      id: 'transporte',
      nombre: 'Transporte',
      icono: FeatherIcons.navigation,
      keywords: ['uber', 'didi', 'gasolina', 'estacionamiento'],
    ),
    Category(
      id: 'farmacia',
      nombre: 'Farmacia',
      icono: FeatherIcons.activity,
      keywords: ['farmacia', 'guadalajara', 'benavides', 'ahorro'],
    ),
    Category(
      id: 'servicios',
      nombre: 'Servicios',
      icono: FeatherIcons.zap,
      keywords: ['cfe', 'telmex', 'agua', 'luz', 'gas'],
    ),
    Category(
      id: 'entretenimiento',
      nombre: 'Entretenimiento',
      icono: FeatherIcons.film,
      keywords: ['cine', 'netflix', 'spotify'],
    ),
    Category(
      id: 'otro',
      nombre: 'Otro',
      icono: FeatherIcons.moreHorizontal,
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
