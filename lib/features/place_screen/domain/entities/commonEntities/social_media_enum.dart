enum SocialMedia{
  facebook(iconName: "facebook"),
  linkedin(iconName: "linkedin"),
  instagram(iconName: "instagram"),
  tiktok(iconName: "tiktok"),
  twitter(iconName: "twitter"),
  whatsApp(iconName: "whatsapp"),
  phone(iconName: "phone");

  final String iconName;
  const SocialMedia({required this.iconName});

}