import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:near_buy_gp/core/di/injection.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';
import 'package:near_buy_gp/core/themes/app_dimen.dart';
import 'package:near_buy_gp/core/themes/app_text_style.dart';
import 'package:near_buy_gp/features/searchScreen/presentation/bloc/search_bloc.dart';
import 'package:near_buy_gp/features/searchScreen/presentation/ui/components/popular_search_header.dart';
import 'package:near_buy_gp/features/searchScreen/presentation/ui/components/popular_search_item.dart';
import 'package:near_buy_gp/features/searchScreen/presentation/ui/components/search_result_item.dart';
import 'package:near_buy_gp/features/searchScreen/presentation/ui/sections/filters_section.dart';
import 'package:near_buy_gp/features/searchScreen/presentation/ui/sections/seach_bar_header.dart';
import 'package:near_buy_gp/shared/widget/error_widget.dart';
import '../../../shared/util/get_error_image.dart';
import '../domain/entities/search_response_entity.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  bool showPopularSearch = true;

  @override
  void dispose() {

    context.read<SearchBloc>().add(
      SearchEmpty(),
    );

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SearchBloc>(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: SearchBarHeader()),
            SliverToBoxAdapter(child: FilterSection()),
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return SliverFillRemaining(
                    child: Center(
                      widthFactor: 1,
                      heightFactor: 5,
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(
                          color: AppColors.darkGray,
                        ),
                      ),
                    ),
                  );
                }
                if (state is SearchFailed) {
                  final String? errorImage = getErrorImage(state.appFailure);
                  return SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: AppDimens.spacingM,
                      ),
                      child: Center(
                        child: CustomErrorWidget(
                          errorImage: errorImage,
                          errorMessage: state.errorMsg,
                          errorMessageStyle: AppTextStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  );
                }
                if (state is SearchSuccess) {
                  final String errorImage = "assets/images/no_results.webp";
                  if (state.resultEmpty != null) {
                    return SliverToBoxAdapter(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          vertical: AppDimens.spacingM,
                        ),
                        child: Center(
                          child: CustomErrorWidget(
                            errorImage: errorImage,
                            errorMessage: state.resultEmpty,
                            errorMessageStyle: AppTextStyles.bodyLarge.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return SliverList.builder(
                      itemCount: (state.searchResults!.length),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsetsGeometry.all(AppDimens.paddingM),
                          child: SearchResultItem(
                            searchResponseEntity: state.searchResults![index],
                          ),
                        );
                      },
                    );
                  }
                }
                if (state is SearchAutoCompleteLoading ||
                    state is SearchAutoCompleteSuccess) {
                  final previousState = (state as dynamic).previousSearchState;

                  // ============================================================
                  // PREVIOUS SEARCH SUCCESS
                  // ============================================================

                  if (previousState is SearchSuccess) {
                    // EMPTY RESULT
                    if (previousState.resultEmpty != null) {
                      return SliverToBoxAdapter(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            vertical: AppDimens.spacingM,
                          ),

                          child: Center(
                            child: CustomErrorWidget(
                              errorImage: "assets/images/no_results.webp",

                              errorMessage: previousState.resultEmpty,

                              errorMessageStyle: AppTextStyles.bodyLarge
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                            ),
                          ),
                        ),
                      );
                    }

                    // SEARCH RESULTS
                    return SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return Padding(
                          padding: EdgeInsets.all(AppDimens.paddingM),

                          child: SearchResultItem(
                            searchResponseEntity:
                                previousState.searchResults![index],
                          ),
                        );
                      }, childCount: previousState.searchResults?.length ?? 0),
                    );
                  }

                  // ============================================================
                  // PREVIOUS SEARCH FAILURE
                  // ============================================================

                  if (previousState is SearchFailed) {
                    final String? errorImage = getErrorImage(
                      previousState.appFailure,
                    );

                    return SliverToBoxAdapter(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          vertical: AppDimens.spacingM,
                        ),

                        child: Center(
                          child: CustomErrorWidget(
                            errorImage: errorImage,

                            errorMessage: previousState.errorMsg,

                            errorMessageStyle: AppTextStyles.bodyLarge.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  // ============================================================
                  // NO PREVIOUS STATE
                  // ============================================================

                  return SliverList.builder(
                    itemCount: popularSearches.length + 1,
                    itemBuilder: (context, index) {
                      return index == 0
                          ? buildHeader()
                          : buildSearchItem(index - 1);
                    },
                  );
                }
                return SliverList.builder(
                  itemCount: popularSearches.length + 1,
                  itemBuilder: (context, index) {
                    return index == 0
                        ? buildHeader()
                        : buildSearchItem(index - 1);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
