class NotificationEntity {
  final String productImage;
  final String productName;
  final String notificationTitle;
  final String notificationTime;
  final String placeLocation;

  NotificationEntity({
    required this.productName,
    required this.notificationTime,
    required this.placeLocation,
    required this.notificationTitle,
    required this.productImage,
  });
}
