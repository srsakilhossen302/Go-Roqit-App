import 'package:get_x/get.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Personal_Information/view/personal_information_view.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Profile/UserInformation/model/user_information_model.dart';

class UserInformationController extends GetxController {
  // Use Rx for the model to update UI automatically
  final userModel = UserInformationModel(
    firstName: "Sarah",
    lastName: "Mitchell",
    gender: "Female",
    dateOfBirth: "1995-03-15",
    citizenship: "United Kingdom",
    streetAddress: "45 Oxford Street",
    city: "London",
    zipCode: "W1D 2DZ",
    country: "United Kingdom",
    mobileNumber: "+44 7456 123789",
    landline: "+44 20 7946 0958",
    profileImagePath: "",
  ).obs;

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
