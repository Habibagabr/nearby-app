class WorkingHourModel {
  final String? day;
  final String? from;
  final String? to;
  final bool? isClosed;

  WorkingHourModel({
    this.day,
    this.from,
    this.to,
    this.isClosed,
  });

  factory WorkingHourModel.fromJson(Map<String, dynamic> json) {
    return WorkingHourModel(
      day: json['day'] as String?,
      from: json['from'] as String?,
      to: json['to'] as String?,
      isClosed: json['isClosed'] as bool?,
    );
  }
}
