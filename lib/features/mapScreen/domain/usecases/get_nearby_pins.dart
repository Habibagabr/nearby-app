import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:near_buy_gp/features/mapScreen/domain/entity/nearby_pin_entity.dart';
import 'package:near_buy_gp/features/mapScreen/domain/repositories/mapRepository.dart';

@LazySingleton()
class GetNearbyPinsUseCase {
  final MapRepository repository;

  GetNearbyPinsUseCase({required this.repository});

  Future<Either<String, List<NearbyPinEntity>>> getNearbyPinsUseCase({
    required double swLng,
    required double swLat,
    required double neLng,
    required double neLat,
    required double zoom,
    required String? businessType
  }) async {
    final result = await repository.getNearbyPins(
      swLng,
      swLat,
      neLng,
      neLat,
      zoom,
      businessType
    );

    return result.fold(
      (error) => Left(error.msg ?? "Error happened"),
      (data) => Right(data),
    );
  }
}
