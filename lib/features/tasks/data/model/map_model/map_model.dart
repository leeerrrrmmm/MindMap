import 'package:mind_map/features/tasks/domain/entity/map_entity.dart';
import 'package:mind_map/features/tasks/domain/entity/task_entity.dart';

class MapModel extends MapEntity {
  MapModel({required super.id, required super.title, required super.sphere});

  factory MapModel.fromEntity(MapEntity entity) {
    return MapModel(id: entity.id, title: entity.title, sphere: entity.sphere);
  }

  factory MapModel.fromJson(Map<String, dynamic> json) {
    return MapModel(
      id: json['id'] as String,
      title: json['title'] as String,
      sphere: Sphere.values.byName(json['sphere'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'sphere': sphere.name};
  }
}
