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
  final profileImagePath = Rxn<String>();
  final galleryImages = <String>[].obs;

  Future<void> refreshProfile() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    loadProfile();
  }

  Future<void> loadProfile() async {
    isLoading.value = true;

    try {
      final apiClient = Get.find<ApiClient>();
      final token = await SharePrefsHelper.getString(SharedPreferenceValue.token);
      final headers = {'Authorization': 'Bearer $token'};

      final response = await apiClient.getData(ApiUrl.getProfile, headers: headers);

      if (response.statusCode == 200) {
        final resData = response.body['data'];
        final profileData = resData['profile'];
        final userObject = resData; // User object might contain 'image' direktly

        if (profileData != null) {
          // Helper to prepend baseUrl to local paths
          String fullUrl(String? path) {
            if (path == null || path.isEmpty) return '';
            if (path.startsWith('http')) return path;
            return "https://api.goroqit.com$path";
          }

          final fetchedProfile = BusinessProfileModel(
            name: profileData['companyName'] ?? '',
            userName: resData['name'] ?? '',
            category: "Recruiter", // Mocked
            description: profileData['companyDescription'] ?? '',
            logoUrl: fullUrl(profileData['companyLogo']),
            profileImageUrl: fullUrl(resData['image']), // Get profile image from parent data
            coverUrl: 'https://picsum.photos/800/200', // Mocked
            contactInfo: ContactInfo(
              email: profileData['companyEmail'] ?? '',
              phone: profileData['phone'] ?? '',
              website: profileData['companyWebsite'] ?? '',
              location: profileData['location'] ?? '',
            ),
            socialLinks: SocialLinks(
              linkedin: profileData['linkedinProfile'] ?? '',
              twitter: profileData['twitterProfile'] ?? '',
              facebook: profileData['facebookProfile'] ?? '',
              instagram: profileData['instagramProfile'] ?? '',
            ),
            galleryImages: (profileData['portfolio'] != null &&
                    (profileData['portfolio'] as List).isNotEmpty)
                ? (profileData['portfolio'][0]['portfolioImages'] as List)
                    .map((e) => fullUrl(e.toString()))
                    .toList()
                : [],
          );

          profile.value = fetchedProfile;
          _populateFields(fetchedProfile);
        }
      } else {
        Get.snackbar('Error', response.statusText ?? 'Failed to fetch profile');
      }
    } catch (e) {
      Get.snackbar('Error', 'Connection Error: $e');
    } finally {
      isLoading.value = false;
    }
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
    profileImagePath.value = data.profileImageUrl;
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

  Future<void> pickProfileImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        profileImagePath.value = image.path;
        Get.snackbar('Success', 'Profile image selected successfully');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick profile image: $e');
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

      // Handle Profile Image
      if (profileImagePath.value != null && !profileImagePath.value!.startsWith('http')) {
        final profileFile = File(profileImagePath.value!);
        if (await profileFile.exists()) {
          formDataMap["image"] = MultipartFile(
            await profileFile.readAsBytes(),
            filename: profileImagePath.value!.split('/').last,
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
