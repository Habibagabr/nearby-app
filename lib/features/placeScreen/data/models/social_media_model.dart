class SocialModel {
  final String? facebook;
  final String? instagram;
  final String? tiktok;
  final String? twitter;
  final String? linkedin;

  SocialModel({
    this.facebook,
    this.instagram,
    this.tiktok,
    this.linkedin,
    this.twitter,
  });

  factory SocialModel.fromJson(Map<String, dynamic> json) {
    return SocialModel(
      facebook: json['facebook'] as String?,
      instagram: json['instagram'] as String?,
      tiktok: json['tiktok'] as String?,
      linkedin: json['linkedin'] as String?,
      twitter: json['twitter'] as String?,
    );
  }
}