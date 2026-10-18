import 'package:mind_map/features/tasks/domain/entity/task_entity.dart';

abstract class MapEntity {
  final String id;
  final String title;
  final Sphere sphere;

  const MapEntity({
    required this.id,
    required this.title,
    required this.sphere,
  });
}
