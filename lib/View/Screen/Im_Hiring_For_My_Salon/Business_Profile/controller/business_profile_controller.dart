import 'package:flutter/material.dart';
import 'package:get_x/get.dart';
import 'package:image_picker/image_picker.dart';
import '../model/business_profile_model.dart';

class BusinessProfileController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  final isLoading = false.obs;
  final profile = Rxn<BusinessProfileModel>();

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  // Form Controllers
  final nameController = TextEditingController();
  final categoryController = TextEditingController();
  final descriptionController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final websiteController = TextEditingController();
  final locationController = TextEditingController();

  // Social Media Controllers
  final linkedinController = TextEditingController();
  final twitterController = TextEditingController();
  final facebookController = TextEditingController();
  final instagramController = TextEditingController();

  final logoPath = Rxn<String>();
  final galleryImages = <String>[].obs;

  Future<void> refreshProfile() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    loadProfile();
  }

  void loadProfile() {
    isLoading.value = true;

    // Simulate API delay
    Future.delayed(const Duration(seconds: 1), () {
      final mockProfile = BusinessProfileModel(
        name: 'Glow Beauty Salon',
        category: 'Beauty Salon',
        description:
            'Premium beauty and wellness services in the heart of London. We specialize in hair styling, coloring, and treatments with over 15 years of experience.',
        logoUrl: 'https://i.pravatar.cc/150?u=glow_logo',
        // Placeholder
        coverUrl: 'https://picsum.photos/800/200',
        // Placeholder
        contactInfo: ContactInfo(
          email: 'careers@glowbeauty.co.uk',
          phone: '+44 20 7946 0123',
          website: 'https://www.glowbeauty.co.uk',
          location: 'London, UK',
        ),
        socialLinks: SocialLinks(
          linkedin: 'https://linkedin.com/company/glowbeauty',
          twitter: 'https://twitter.com/glowbeauty',
          facebook: 'https://facebook.com/glowbeauty',
          instagram: 'https://instagram.com/glowbeauty',
        ),
        galleryImages: [
          'https://picsum.photos/200/200?random=1',
          'https://picsum.photos/200/200?random=2',
          'https://picsum.photos/200/200?random=3',
        ],
      );

      profile.value = mockProfile;
      _populateFields(mockProfile);
      isLoading.value = false;
    });
  }

  void _populateFields(BusinessProfileModel? data) {
    if (data == null) return;

    nameController.text = data.name;
    categoryController.text = data.category;
    descriptionController.text = data.description;
    emailController.text = data.contactInfo.email;
    phoneController.text = data.contactInfo.phone;
    websiteController.text = data.contactInfo.website;
    locationController.text = data.contactInfo.location;

    linkedinController.text = data.socialLinks.linkedin;
    twitterController.text = data.socialLinks.twitter;
    facebookController.text = data.socialLinks.facebook;
    instagramController.text = data.socialLinks.instagram;

    logoPath.value = data.logoUrl;
    galleryImages.assignAll(data.galleryImages);
  }

  Future<void> pickLogo() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        logoPath.value = image.path;
        Get.snackbar('Success', 'Logo selected successfully');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick logo: $e');
    }
  }

  Future<void> pickGalleryImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        galleryImages.add(image.path);
        Get.snackbar('Success', 'Image added to gallery');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }

  Future<void> saveProfile() async {
    isLoading.value = true;

    // Simulate API POST request
    print("Saving profile data...");
    await Future.delayed(const Duration(seconds: 2));

    // Update local model
    profile.value = BusinessProfileModel(
      name: nameController.text,
      category: categoryController.text,
      description: descriptionController.text,
      logoUrl: logoPath.value ?? '',
      coverUrl: profile.value?.coverUrl ?? '',
      // Keep existing cover
      contactInfo: ContactInfo(
        email: emailController.text,
        phone: phoneController.text,
        website: websiteController.text,
        location: locationController.text,
      ),
      socialLinks: SocialLinks(
        linkedin: linkedinController.text,
        twitter: twitterController.text,
        facebook: facebookController.text,
        instagram: instagramController.text,
      ),
      galleryImages: List.from(galleryImages),
    );

    isLoading.value = false;
    Get.back(); // Return to profile view
    Get.snackbar(
      'Success',
      'Profile updated successfully',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  @override
  void onClose() {
    nameController.dispose();
    categoryController.dispose();
    descriptionController.dispose();
    emailController.dispose();
    phoneController.dispose();
    websiteController.dispose();
    locationController.dispose();
    linkedinController.dispose();
    twitterController.dispose();
    facebookController.dispose();
    instagramController.dispose();
    super.onClose();
  }
}
