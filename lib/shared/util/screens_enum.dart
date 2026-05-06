enum ScreensType { store, clinic, generic, gym }

ScreensType getScreenType(String category) {
  return switch (category) {
    "store" => ScreensType.store,
    "clinic" => ScreensType.clinic,
    "generic" => ScreensType.generic,
    "gym" => ScreensType.gym,
    String() => ScreensType.generic,
  };
}
