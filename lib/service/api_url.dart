class ApiUrl {
  static const String baseUrl =
      "https://fahim5001.naimulhassan.me/api/v1"; // Replace with your actual base URL

  static const String IMGUrl = "https://fahim5001.naimulhassan.me/";

  static const String signUp = "/auth/signup";
  static const String signIn = "/auth/login";
  static const String otpVerify = "/auth/verify-account";
  static const String updateProfile = "/user/profile";
  static const String addPortfolio = "/user/applicants/portfolio";
  static const String getProfile = "/user/me";
  static const String addEducation = "/user/applicants/education";
  static const String addWorkExperience = "/user/applicants/experience";
  static const String getJobs = "/job";
  static const String myJobs = "/job/my-jobs";
  static const String applyJob = "/application";
  static const String createChat = "/chat";
  static const String getPlans = "/plan";
  static const String createCheckout = "/plan/create-checkout-session";
  static const String getMessages = "/message";
  static const String getJobsByDistance = "/job/get-jobs-by-distance";
  static const String getCategories = "/category";
}
