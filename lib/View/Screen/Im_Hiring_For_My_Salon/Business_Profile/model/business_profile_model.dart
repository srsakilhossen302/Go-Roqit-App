class BusinessProfileModel {
  final String name;
  final String category;
  final String description;
  final String logoUrl;
  final String coverUrl;
  final ContactInfo contactInfo;
  final SocialLinks socialLinks;
  final List<String> galleryImages;

  BusinessProfileModel({
    required this.name,
    required this.category,
    required this.description,
    required this.logoUrl,
    required this.coverUrl,
    required this.contactInfo,
    required this.socialLinks,
    required this.galleryImages,
  });
}

class ContactInfo {
  final String email;
  final String phone;
  final String website;
  final String location;

  ContactInfo({
    required this.email,
    required this.phone,
    required this.website,
    required this.location,
  });
}

class SocialLinks {
  final String linkedin;
  final String twitter;
  final String facebook;
  final String instagram;

  SocialLinks({
    required this.linkedin,
    required this.twitter,
    required this.facebook,
    required this.instagram,
  });
}
