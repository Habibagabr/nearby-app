import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:near_buy_gp/features/mapScreen/domain/entity/nearby_pin_entity.dart';
import 'package:near_buy_gp/features/mapScreen/domain/repositories/mapRepository.dart';

@LazySingleton()
class GetNearbyPinsUseCase {
  final MapRepository repository;
  GetNearbyPinsUseCase({required this.repository});

  Future<Either<String, List<NearbyPinEntity>>> getNearbyPinsUseCase(
    double swLng,
    double swLat,
    double neLng,
    double neLat,
    double zoom,
  ) async {
    final result = await repository.getNearbyPins(
      swLng,
      swLat,
      neLng,
      neLat,
      zoom,
    );

    return result.fold(
      (error) => Left(error.msg ?? "Error happened"),
      (data) => Right(data),
    );
  }
}
