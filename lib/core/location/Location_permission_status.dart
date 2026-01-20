enum LocationPermissionStatus {
  serviceDisabled(
    "Location services Disabled , please enable it again",
  ), // user locks the location services
  denied(
    "Location access denied , please enable access ",
  ), // the permission for the app denied
  deniedForever("Location access denied , please enable access "),
  granted("Location access granted");

  final String permissionState;
  const LocationPermissionStatus(this.permissionState);
}
