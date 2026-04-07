import 'item_attribute_model.dart';

class GymMembershipAttributes extends ItemAttributesModel {
  final String? accessLevel;
  final String? validity;
  final List<String>? benefits;

  const GymMembershipAttributes({
    this.accessLevel,
    this.validity,
    this.benefits,
  });

  factory GymMembershipAttributes.fromJson(Map<String, dynamic> json) {
    return GymMembershipAttributes(
      accessLevel: json['accessLevel'],
      validity: json['validity'],
      benefits: json['benefits'] != null
          ? List<String>.from(json['benefits'])
          : null,
    );
  }

  @override
  toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}
