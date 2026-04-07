import 'package:near_buy_gp/features/place_screen/data/mappers/items_mapper/clinic_to_entity.dart';
import 'package:near_buy_gp/features/place_screen/data/models/product_model.dart';

import '../../domain/entities/placeEntity/paginated_item_entity.dart';
import '../../domain/entities/placeEntity/product_entity.dart';
import '../../domain/entities/placeEntity/social_entity.dart';
import '../../domain/entities/placeEntity/working_hour_entity.dart';
import '../models/item_paginated_model.dart';
import '../models/social_media_model.dart';
import '../models/working_hour_model.dart';

extension SocialMapper on SocialModel {
  SocialEntity toEntity() {
    return SocialEntity(
      facebook: facebook,
      instagram: instagram,
      tiktok: tiktok,
      twitter: twitter,
      linkedin: linkedin,
    );
  }
}
extension WorkingHourMapper on WorkingHourModel {
  WorkingHourEntity toEntity() => WorkingHourEntity(
    day: day,
    from: from,
    to: to,
    isClosed: isClosed,
  );
}

extension ProductMapper on ProductModel{
  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      name: name,
      description: description,
      price: price,
      images: images,
      isAvailable: isAvailable,
      businessId: businessId,
      categoryId: categoryId,
      type: type,
      attributes: attributes.toEntity(),
    );
  }
}

extension ItemsPaginatedMapper on ItemsPaginatedModel {
  ItemsPaginatedEntity toEntity() {
    return ItemsPaginatedEntity(
      items: items.map((e) => e.toEntity()).toList(),
      total: total ,
      page: page,
      limit: limit,
    );
  }
}
