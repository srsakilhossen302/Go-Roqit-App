import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get_x/get_state_manager/src/simple/get_view.dart';

import '../../../../Widgegt/mainButton.dart';
import '../../../../Widgegt/textField.dart';
import '../controller/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        textField('Full Name', controller.fullName, hintText: 'Fahim Brother'),
        SizedBox(height: 16.h),
        textField('Email', controller.signUpEmail, hintText: 'your@email.com'),
        SizedBox(height: 16.h),
        textField(
          'Password',
          controller.signUpPassword,
          obscure: true,
          hintText: 'Enter your password',
        ),
        const SizedBox(height: 32),

        Obx(
          () => mainButton(
            loading: controller.isLoading.value,
            onTap: controller.signUp,
          ),
        ),

        const SizedBox(height: 16),
        termsText(),
      ],
    );
  }
}
