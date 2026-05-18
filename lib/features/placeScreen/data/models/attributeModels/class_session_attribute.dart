import 'package:near_buy_gp/features/placeScreen/domain/entities/placeEntity/item_attribute_entity.dart';

import 'item_attribute_model.dart';

class ClassSessionAttributes extends ItemAttributesModel {
  final String trainerName;
  final String? schedule;
  final String? duration;
  final int? capacity;
  final String? intensityLevel;

  const ClassSessionAttributes({
    required this.trainerName,
    this.schedule,
    this.duration,
    this.capacity,
    this.intensityLevel,
  });

  factory ClassSessionAttributes.fromJson(Map<String, dynamic> json) {
    return ClassSessionAttributes(
      trainerName: json['trainerName'],
      schedule: json['schedule'],
      duration: json['duration'],
      capacity: json['capacity'],
      intensityLevel: json['intensityLevel'],
    );
  }

  @override
  ItemAttributesEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}
