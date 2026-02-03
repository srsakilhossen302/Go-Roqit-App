import 'package:get_x/get.dart';

class ProfileHelpSupportController extends GetxController {
  final faqList = [
    "How do I update my profile?",
    "How does the swipe system work?",
    "How do I get verified?",
  ];

  void onFaqTap(String question) {
    // Navigate to FAQ detail or expand
    print("FAQ Tapped: $question");
  }

  void onContactSupportTap() {
    // Navigate to support chat or email
    print("Contact Support Tapped");
  }
}
