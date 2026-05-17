// features/searchScreen/presentation/widgets/search_bar_header.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:near_buy_gp/core/location/presentation/bloc/location_bloc.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';
import 'package:near_buy_gp/core/themes/app_dimen.dart';
import 'package:near_buy_gp/core/themes/app_text_style.dart';
import 'package:near_buy_gp/features/searchScreen/domain/entities/auto_complete_entity.dart';
import 'package:near_buy_gp/features/searchScreen/presentation/bloc/search_bloc.dart';

import '../components/search_autocomplete_overlay.dart';
import '../utils/search_overlay_controller.dart';

class SearchBarHeader extends StatefulWidget {
  const SearchBarHeader({super.key});

  @override
  State<SearchBarHeader> createState() => _SearchBarHeaderState();
}

class _SearchBarHeaderState extends State<SearchBarHeader> {
  final LayerLink _layerLink = LayerLink();
  final SearchOverlayController _overlayController = SearchOverlayController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    _overlayController.dispose();
    super.dispose();
  }

  // ── Overlay management ──────────────────────────────────────────────────────

  void _showOverlay(List<AutoCompleteResponseEntity> suggestions) {
    _overlayController.show(
      context: context,
      entry: _buildOverlayEntry(suggestions),
    );
  }

  void _hideOverlay() => _overlayController.hide();

  OverlayEntry _buildOverlayEntry(
    List<AutoCompleteResponseEntity> suggestions,
  ) {
    return OverlayEntry(
      builder: (_) => SearchAutocompleteOverlay(
        layerLink: _layerLink,
        searchBloc: context.read<SearchBloc>(),
        locationBloc: context.read<LocationBloc>(),
        onDismiss: _hideOverlay,
        // just close, keep query per UX decision
        controller: _searchController,
      ),
    );
  }

  // ── Search actions ──────────────────────────────────────────────────────────

  void _onSearchChanged(String value) {
    // Debounce is handled inside SearchBloc via EventTransformer — fire freely
    context.read<SearchBloc>().add(AutoCompleteTriggered(query: value));
  }

  void _onSearchSubmitted(String query) {
    _hideOverlay();
    final location = context.read<LocationBloc>().state;
    final searchState = context.read<SearchBloc>().state;
    if (query.isNotEmpty) {
      context.read<SearchBloc>().add(
        SearchTriggered(
          searchQuery: query,
          userLat: location.location?.latitude,
          userLng: location.location?.longitude,
          isOpenedNow: searchState.isOpenNow,
          miniRate: searchState.miniRate,
        ),
      );
    }
  }

  // ── Build ───────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchBloc, SearchState>(
      listener: _onStateChanged,
      child: Container(
        width: double.infinity,
        padding: EdgeInsetsGeometry.symmetric(
          vertical: AppDimens.paddingL,
          horizontal: AppDimens.paddingM,
        ),
        color: AppColors.darkGray,
        child: Column(
          children: [
            Center(
              child: Column(
                spacing: AppDimens.spacingS,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CompositedTransformTarget(
                    link: _layerLink,
                    child: _SearchInput(
                      onChanged: _onSearchChanged,
                      onSubmitted: _onSearchSubmitted,
                      controller: _searchController,
                    ),
                  ),
                  _SearchHintRow(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onStateChanged(BuildContext context, SearchState state) {
    if (state is SearchAutoCompleteLoading ||
        state is SearchAutoCompleteSuccess) {
      final suggestions = state is SearchAutoCompleteSuccess
          ? state.autoCompleteResponse ?? []
          : <AutoCompleteResponseEntity>[];
      _showOverlay(suggestions);
    } else {
      _hideOverlay();
    }
  }
}

// ── Private sub-widgets (stateless, no bloc access needed) ───────────────────

class _SearchInput extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final TextEditingController controller;

  const _SearchInput({
    required this.onChanged,
    required this.onSubmitted,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      shape: const WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppDimens.radiusM)),
        ),
      ),
      padding: const WidgetStatePropertyAll(
        EdgeInsetsGeometry.symmetric(horizontal: AppDimens.paddingM),
      ),
      backgroundColor: const WidgetStatePropertyAll(AppColors.white),
      hintStyle: WidgetStatePropertyAll(
        AppTextStyles.bodyLarge.copyWith(color: AppColors.lightGray),
      ),
      hintText: "Try: gym with pool near me",
      leading: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: AppDimens.spacingS,
        children: [
          Icon(
            Icons.search,
            color: AppColors.lightGray,
            size: AppDimens.iconSmall,
          ),
          Image.asset(
            "assets/images/search_star.webp",
            width: AppDimens.iconSmall,
            height: AppDimens.iconSmall,
          ),
        ],
      ),
    );
  }
}

class _SearchHintRow extends StatelessWidget {
  const _SearchHintRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      spacing: AppDimens.spacingS,
      children: [
        Image.asset(
          "assets/images/search_star.webp",
          width: AppDimens.iconSmall,
          height: AppDimens.iconSmall,
        ),
        const Text(
          "Ask naturally - I understand what you mean",
          style: TextStyle(color: AppColors.white),
        ),
      ],
    );
  }
}
