import 'package:get_x/get.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Profile/UserInformation/model/user_information_model.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Profile/controller/profile_controller.dart';

class UserInformationController extends GetxController {
  final ProfileController _profileController = Get.find<ProfileController>();

  late Rx<UserInformationModel> userModel;

  @override
  void onInit() {
    super.onInit();
    final profile = _profileController.userData.value?.profile;
    final user = _profileController.userData.value;
    
    userModel = UserInformationModel(
      firstName: profile?.firstName ?? user?.name?.split(' ').first ?? "",
      lastName: user?.name?.split(' ').length == 2 ? user?.name?.split(' ').last ?? "" : "",
      gender: profile?.gender ?? "",
      dateOfBirth: profile?.dateOfBirth?.split('T').first ?? "",
      citizenship: profile?.citizenship ?? "",
      streetAddress: profile?.streetAddress ?? "",
      city: profile?.city ?? "",
      zipCode: profile?.zipCode ?? "",
      country: profile?.country ?? "",
      mobileNumber: profile?.mobile ?? "",
      landline: profile?.landLine ?? "",
      profileImagePath: user?.image ?? "",
    ).obs;
  }

  void updateBasicInfo(
    String firstName,
    String lastName,
    String gender,
    String dob,
    String citizenship,
  ) {
    userModel.value.firstName = firstName;
    userModel.value.lastName = lastName;
    userModel.value.gender = gender;
    userModel.value.dateOfBirth = dob;
    userModel.value.citizenship = citizenship;
    userModel.refresh();
  }

  void updateAddress(String street, String city, String zip, String country) {
    userModel.value.streetAddress = street;
    userModel.value.city = city;
    userModel.value.zipCode = zip;
    userModel.value.country = country;
    userModel.refresh();
  }

  void updateContact(String mobile, String landline) {
    userModel.value.mobileNumber = mobile;
    userModel.value.landline = landline;
    userModel.refresh();
  }
}
