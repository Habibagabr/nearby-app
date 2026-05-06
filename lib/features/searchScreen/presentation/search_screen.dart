import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:near_buy_gp/core/di/injection.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';
import 'package:near_buy_gp/core/themes/app_dimen.dart';
import 'package:near_buy_gp/features/searchScreen/presentation/bloc/search_bloc.dart';
import 'package:near_buy_gp/features/searchScreen/presentation/ui/components/popular_search_header.dart';
import 'package:near_buy_gp/features/searchScreen/presentation/ui/components/popular_search_item.dart';
import 'package:near_buy_gp/features/searchScreen/presentation/ui/components/search_result_item.dart';
import 'package:near_buy_gp/features/searchScreen/presentation/ui/sections/filters_section.dart';
import 'package:near_buy_gp/features/searchScreen/presentation/ui/sections/seach_bar_header.dart';
import 'package:near_buy_gp/shared/widget/error_widget.dart';
import '../../../shared/util/get_error_image.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  bool showPopularSearch = true;

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
                      margin: EdgeInsets.symmetric(vertical: AppDimens.spacingM),
                      child:Center(
                      child: CustomErrorWidget(
                        errorImage: errorImage,
                        errorMessage: state.errorMsg,
                      ),
                    )
                    ),
                  );
                }
                if (state is SearchSuccess) {
                  final String errorImage = "assets/images/no_results.webp";
                  if (state.resultEmpty != null) {
                    return SliverToBoxAdapter(
                      child: Container(
                          margin: EdgeInsets.symmetric(vertical: AppDimens.spacingM),
                          child:Center(
                            child: CustomErrorWidget(
                              errorImage: errorImage,
                              errorMessage: state.resultEmpty,
                            ),
                          )
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
