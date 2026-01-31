class ClinicService {
  final String serviceName;
  final String serviceDescription;
  final String serviceTime;
  final double servicePrice;

  ClinicService({
    required this.serviceDescription,
    required this.serviceName,
    required this.servicePrice,
    required this.serviceTime,
  });
}
