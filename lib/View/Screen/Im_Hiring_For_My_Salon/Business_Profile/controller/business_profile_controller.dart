import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_x/get.dart';
import 'package:get_x/get_connect.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_roqit_app/helper/shared_prefe/shared_prefe.dart';
import 'package:go_roqit_app/service/api_client.dart';
import 'package:go_roqit_app/service/api_url.dart';
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

  Future<void> pickGalleryImage({int? index}) async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        if (index != null && index < galleryImages.length) {
          galleryImages[index] = image.path;
        } else {
          if (galleryImages.length < 3) {
            galleryImages.add(image.path);
          } else {
            Get.snackbar('Limit Reached', 'Maximum 3 images allowed');
          }
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }

  void removeGalleryImage(int index) {
    if (index < galleryImages.length) {
      galleryImages.removeAt(index);
    }
  }

  Future<void> saveProfile() async {
    isLoading.value = true;

    try {
      final apiClient = Get.find<ApiClient>();
      final token = await SharePrefsHelper.getString(SharedPreferenceValue.token);

      final dataBody = {
        "companyName": nameController.text,
        "companyDescription": descriptionController.text,
        "phone": phoneController.text,
        "companyEmail": emailController.text,
        "location": locationController.text,
        "facebookProfile": facebookController.text,
        "instagramProfile": instagramController.text,
        "bio": descriptionController.text, // Using description as bio for now
        "companyWebsite": websiteController.text,
        "linkedinProfile": linkedinController.text,
        "twitterProfile": twitterController.text,
      };

      final Map<String, dynamic> formDataMap = {
        "data": jsonEncode(dataBody),
      };

      // Handle Company Logo
      if (logoPath.value != null && !logoPath.value!.startsWith('http')) {
        final logoFile = File(logoPath.value!);
        if (await logoFile.exists()) {
          formDataMap["companyLogo"] = MultipartFile(
            await logoFile.readAsBytes(),
            filename: logoPath.value!.split('/').last,
            contentType: 'image/jpeg',
          );
        }
      }

      final body = FormData(formDataMap);
      final headers = {'Authorization': 'Bearer $token'};

      final response =
          await apiClient.patchData(ApiUrl.updateProfile, body, headers: headers);

      print("Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.back();
        Get.snackbar(
          'Success',
          'Profile updated successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        refreshProfile();
      } else {
        Get.snackbar(
          'Error',
          response.statusText ?? 'Something went wrong',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Connection Error: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
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
