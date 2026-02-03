class UserInformationModel {
  String firstName;
  String lastName;
  String gender;
  String dateOfBirth;
  String citizenship;
  String streetAddress;
  String city;
  String zipCode;
  String country;
  String mobileNumber;
  String landline;
  String profileImagePath;

  UserInformationModel({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.dateOfBirth,
    required this.citizenship,
    required this.streetAddress,
    required this.city,
    required this.zipCode,
    required this.country,
    required this.mobileNumber,
    required this.landline,
    required this.profileImagePath,
  });

  // Getter for full name
  String get fullName => "$firstName $lastName";

  // Getter for full address
  String get fullAddress => "$streetAddress, $city $zipCode";
}
