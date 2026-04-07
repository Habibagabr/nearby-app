// place_model.dart

import 'package:near_buy_gp/features/place_screen/data/models/social_media_model.dart';

import 'location_model.dart';
import 'working_hour_model.dart';
import 'item_paginated_model.dart';

class PlaceModel {
  final String? id;
  final String? name;
  final String? description;
  final List<String>? tags;
  final String? type;
  final String? category;
  final String? phone;
  final String? email;
  final String? website;
  final String? address;
  final LocationModel? location;
  final List<WorkingHourModel>? workingHours;
  final List<String>? images;
  final String? status;
  final double? rate;
  final SocialModel? socialModel;
  final ItemsPaginatedModel? itemsPaginated;

  PlaceModel({
    this.id,
    this.name,
    this.description,
    this.tags,
    this.type,
    this.category,
    this.phone,
    this.email,
    this.website,
    this.address,
    this.location,
    this.workingHours,
    this.images,
    this.status,
    this.rate,
    this.itemsPaginated,
    this.socialModel,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
      type: json['type'] as String?,
      category: json['category'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      website: json['website'] as String?,
      address: json['address'] as String?,
      location: json['location'] != null
          ? LocationModel.fromJson(json['location'])
          : null,
      workingHours: json['workingHours'] != null
          ? (json['workingHours'] as List)
                .map((e) => WorkingHourModel.fromJson(e))
                .toList()
          : null,
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      status: json['status'] as String?,
      rate: (json['rate'] as num?)?.toDouble(),
      socialModel: json['social'] != null
          ? SocialModel.fromJson(json['social'])
          : null,
      itemsPaginated: json['itemsPaginated'] != null
          ? ItemsPaginatedModel.fromJson(json['itemsPaginated'])
          : null,
    );
  }
}
