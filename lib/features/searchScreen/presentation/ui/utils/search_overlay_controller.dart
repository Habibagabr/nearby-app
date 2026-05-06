// core/presentation/overlays/search_overlay_controller.dart

import 'package:flutter/material.dart';

/// Manages a single OverlayEntry lifecycle.
/// Keeps the View layer free of raw Overlay manipulation.
class SearchOverlayController {
  OverlayEntry? _entry;

  bool get isShown => _entry != null;

  void show({
    required BuildContext context,
    required OverlayEntry entry,
  }) {
    hide(); // always tear down before re-inserting
    _entry = entry;
    Overlay.of(context).insert(_entry!);
  }

  void hide() {
    if (_entry != null && _entry!.mounted) {
      _entry!.remove();
    }
    _entry = null;
  }

  void dispose() => hide();
}