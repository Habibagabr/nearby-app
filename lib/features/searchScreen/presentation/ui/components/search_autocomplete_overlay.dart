// features/searchScreen/presentation/widgets/search_autocomplete_overlay.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:near_buy_gp/core/location/presentation/bloc/location_bloc.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';
import 'package:near_buy_gp/core/themes/app_dimen.dart';
import 'package:near_buy_gp/core/themes/app_text_style.dart';
import 'package:near_buy_gp/features/searchScreen/domain/entities/auto_complete_entity.dart';
import 'package:near_buy_gp/features/searchScreen/presentation/bloc/search_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Pure UI widget — renders the autocomplete dropdown.
/// Receives blocs explicitly because it lives inside an Overlay
/// (outside the normal widget tree).
class SearchAutocompleteOverlay extends StatelessWidget {
  final LayerLink layerLink;
  final SearchBloc searchBloc;
  final LocationBloc locationBloc;
  final VoidCallback onDismiss;
  final TextEditingController controller;

  const SearchAutocompleteOverlay({
    super.key,
    required this.layerLink,
    required this.searchBloc,
    required this.locationBloc,
    required this.onDismiss,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: MediaQuery.of(context).size.width - 40,
      child: CompositedTransformFollower(
        link: layerLink,
        showWhenUnlinked: false,
        offset: const Offset(0, 60),
        child: Material(
          color: Colors.transparent,
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(value: searchBloc),
              BlocProvider.value(value: locationBloc),
            ],
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                final isLoading = state is SearchAutoCompleteLoading;
                final items = _resolveItems(state, isLoading);

                if (items.isEmpty && !isLoading) return const SizedBox.shrink();

                return TapRegion(
                  onTapOutside: (_) => onDismiss(),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 350),
                    child: Skeletonizer(
                      enabled: isLoading,
                      child: _OverlayList(
                        items: items,
                        isLoading: isLoading,
                        onItemTap: (displayText) {
                          controller.text = _onSuggestionTapped(context, displayText);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  List<AutoCompleteResponseEntity> _resolveItems(
    SearchState state,
    bool isLoading,
  ) {
    if (isLoading) {
      return List.generate(
        2,
        (_) =>
            AutoCompleteResponseEntity(businessName: '', queryComplement: ''),
      );
    }
    if (state is SearchAutoCompleteSuccess) {
      return state.autoCompleteResponse ?? [];
    }
    return [];
  }

  String _onSuggestionTapped(BuildContext context, String displayText) {
    final location = context.read<LocationBloc>().state;
    context.read<SearchBloc>().add(
      AutoCompleteSuggestionPressed(
        query: displayText,
        userLat: location.location?.latitude ?? 0.0,
        userLng: location.location?.longitude ?? 0.0,
      ),
    );
    onDismiss();
    return displayText;
  }
}

// ── Private sub-widget ────────────────────────────────────────────────────────

class _OverlayList extends StatelessWidget {
  final List<AutoCompleteResponseEntity> items;
  final bool isLoading;
  final ValueChanged<String> onItemTap;

  const _OverlayList({
    required this.items,
    required this.isLoading,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimens.radiusS),
        color: AppColors.darkGray,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: AppDimens.spacingS),
        itemCount: items.length,
        itemBuilder: (_, index) {
          final item = items[index];
          final displayText = item.queryComplement ?? item.businessName ?? '';

          return _OverlayItem(
            displayText: displayText,
            onTap: isLoading ? null : () => onItemTap(displayText),
          );
        },
      ),
    );
  }
}

class _OverlayItem extends StatelessWidget {
  final String displayText;
  final VoidCallback? onTap;

  const _OverlayItem({required this.displayText, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: AppDimens.spacingM,
          vertical: AppDimens.spacingXS,
        ),
        padding: EdgeInsets.all(AppDimens.paddingS),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimens.radiusL),
          color: AppColors.white,
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: AppColors.darkGray),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                displayText,
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.darkGray,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
