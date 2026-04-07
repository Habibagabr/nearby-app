import 'package:near_buy_gp/features/place_screen/data/mappers/place_model_extension_to_entity.dart';

import '../../domain/entities/placeEntity/location_entity.dart';
import '../../domain/entities/placeEntity/paginated_item_entity.dart';
import '../../domain/entities/placeEntity/place_entity.dart';
import '../models/place_model.dart';

extension PlaceMapper on PlaceModel {
  PlaceEntity toEntity() {
    return PlaceEntity(
      id: id ?? '',
      name: name ?? 'Unknown',
      description: description ?? 'i don\'t know ',
      tags: tags ?? ["i don't know"],
      type: type ?? 'i don\'t know',
      category: category ?? 'no',
      phone: phone ?? 'no',
      email: email ?? 'no',
      website: website ?? 'no',
      address: address ?? 'no',
      location: _mapLocation(),
      workingHours:
      workingHours?.map((e) => e.toEntity()).toList() ?? [],
      images: images ?? [],
      status: status ?? '',
      rate: rate ?? 0.0,
      social: socialModel?.toEntity(),
      itemsPaginated:
      itemsPaginated?.toEntity() ??
          ItemsPaginatedEntity.empty(),
    );
  }

  LocationEntity _mapLocation() {
    if (location == null ||
        location!.coordinates == null ||
        location!.coordinates!.length < 2) {
      return LocationEntity(latitude: 0, longitude: 0);
    }

    return LocationEntity(
      latitude: location!.coordinates![1],
      longitude: location!.coordinates![0],
    );
  }
}
