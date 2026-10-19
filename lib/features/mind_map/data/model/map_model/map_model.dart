import 'package:mind_map/features/mind_map/domain/entity/map_entity.dart';
import 'package:mind_map/features/tasks/domain/entity/task_entity.dart';

class MapModel extends MapEntity {
  MapModel({required super.id, required super.title, required super.sphere});

  factory MapModel.fromEntity(MapEntity entity) {
    return MapModel(id: entity.id, title: entity.title, sphere: entity.sphere);
  }

  factory MapModel.fromJson(Map<String, dynamic> json) {
    // Безопасно достаем sphere. Если его нет или он невалидный - ставим other.
    Sphere parsedSphere;
    try {
      parsedSphere = Sphere.values.byName(json['sphere'] as String? ?? 'other');
    } catch (_) {
      parsedSphere = Sphere.other;
    }

    return MapModel(
      // Если id нет в самом документе, берем его из id документа (это нужно делать в DataSource)
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? 'Untitled',
      sphere: parsedSphere,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'sphere': sphere.name};
  }
}
