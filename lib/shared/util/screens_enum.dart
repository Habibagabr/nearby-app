enum ScreensType { store, clinic, generic, gym }


/// FIXME : WE HAVE TO MAKE IT WITHOUT RESTAURANT TYPE :: JUST STORE / CLINIC / GYM / GENERIC
ScreensType getScreenType(String category) {
  return switch (category) {
    "store" => ScreensType.store,
    "restaurant" => ScreensType.store,
    "clinic" => ScreensType.clinic,
    "generic" => ScreensType.generic,
    "gym" => ScreensType.gym,
    String() => ScreensType.generic,
  };
}
