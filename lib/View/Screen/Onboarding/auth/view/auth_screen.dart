import 'package:flutter/material.dart';
import 'package:go_roqit_app/View/Screen/Onboarding/auth/view/sign_in_view.dart';

// Since AuthScreen is referenced in many places (Onboarding, Logout logic, etc.),
// we update it to simply return the SignInView, which now handles the UI.
// This preserves existing navigation calls while updating the behavior.

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SignInView();
  }
}
