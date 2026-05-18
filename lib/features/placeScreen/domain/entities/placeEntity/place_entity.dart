import 'package:near_buy_gp/features/placeScreen/domain/entities/placeEntity/paginated_item_entity.dart';
import 'package:near_buy_gp/features/placeScreen/domain/entities/placeEntity/social_entity.dart';
import 'package:near_buy_gp/features/placeScreen/domain/entities/placeEntity/working_hour_entity.dart';

import 'location_entity.dart';

class PlaceEntity {
  final String id;
  final String name;
  final String description;
  final List<String> tags;
  final String type;
  final String category;
  final String? phone;
  final String? email;
  final String? website;
  final SocialEntity? social;
  final String address;
  final LocationEntity location;
  final List<WorkingHourEntity> workingHours;
  final List<String> images;
  final String status;
  final double rate;
  final ItemsPaginatedEntity itemsPaginated;

  const PlaceEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.tags,
    required this.type,
    required this.category,
    this.phone,
    this.email,
    this.website,
    this.social,
    required this.address,
    required this.location,
    required this.workingHours,
    required this.images,
    required this.status,
    required this.rate,
    required this.itemsPaginated,
  });
}
