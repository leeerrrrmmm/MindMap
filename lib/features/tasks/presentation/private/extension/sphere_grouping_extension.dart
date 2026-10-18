import 'package:flutter/material.dart';
import 'package:mind_map/features/tasks/domain/entity/task_entity.dart';

extension SphereGrouping on Sphere {
  /// Название группы для отображения
  String get groupTitle {
    switch (this) {
      case Sphere.personal:
      case Sphere.health:
      case Sphere.learning:
      case Sphere.ideas:
        return 'Personal goals and experiences';
      case Sphere.work:
      case Sphere.finance:
      case Sphere.other:
        return 'Work & Finance';
    }
  }

  /// Проверяем, относится ли сфера к нужной группе
  bool belongsTo(String group) => groupTitle == group;

  IconData get icon {
    switch (this) {
      case Sphere.work:
        return Icons.work_outline;
      case Sphere.health:
        return Icons.favorite_border;
      case Sphere.ideas:
        return Icons.lightbulb_outline;
      case Sphere.personal:
        return Icons.person_outline;
      case Sphere.finance:
        return Icons.attach_money;
      case Sphere.learning:
        return Icons.school_outlined;
      case Sphere.other:
        return Icons.category_outlined;
    }
  }

  /// Цвет для сферы (возьми свои цвета из дизайна)
  Color get color {
    switch (this) {
      case Sphere.work:
        return const Color(0xFF4A90D9); // Синий
      case Sphere.health:
        return const Color(0xFFE85D75); // Красный
      case Sphere.ideas:
        return const Color(0xFFF5B74F); // Желтый
      case Sphere.personal:
        return const Color(0xFF9B7FD4); // Фиолетовый
      case Sphere.finance:
        return const Color(0xFF4CAF50); // Зеленый
      case Sphere.learning:
        return const Color(0xFF3F9AA8); // Бирюзовый
      case Sphere.other:
        return const Color(0xFF8D8D8D); // Серый
    }
  }

  /// Контрастный цвет для текста (чтобы читалось на фоне)
  Color get textColor {
    final luminance = color.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}
