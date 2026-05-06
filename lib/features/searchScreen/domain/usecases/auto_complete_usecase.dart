import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:near_buy_gp/core/error/app_failure.dart';
import 'package:near_buy_gp/features/searchScreen/domain/entities/auto_complete_entity.dart';

import '../repository/search_repository.dart';

@LazySingleton()
class AutoCompleteUseCase {
  final SearchRepository searchRepository;

  AutoCompleteUseCase(this.searchRepository);

  Future<Either<AppFailure, List<AutoCompleteResponseEntity>>> call(
      {
    required String query,
  }) async {
    return await searchRepository.getAutoCompleteResult(query: query);
  }
}
