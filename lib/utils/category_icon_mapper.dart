import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class CategoryIconMapper {
  static dynamic getIcon([String? categoria]) {
    final map = {
      'Alimentos': FeatherIcons.shoppingCart,
      'Limpieza': FeatherIcons.droplet,
      'Higiene Personal': FeatherIcons.wind,
      'Farmacia': FeatherIcons.activity,
      'Electrónica': FeatherIcons.zap,
      'Ropa': FeatherIcons.layers,
      'Hogar': FeatherIcons.home,
      'Papelería': FeatherIcons.edit3,
      'Ferretería': FeatherIcons.settings,
      'Departamental': FeatherIcons.box,
      'Otros': FeatherIcons.helpCircle,
    };

    return map[categoria] ?? FeatherIcons.helpCircle;
  }
}
