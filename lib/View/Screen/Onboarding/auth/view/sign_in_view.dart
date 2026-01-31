import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get_x/get_state_manager/src/simple/get_view.dart';

import '../../../../Widgegt/mainButton.dart';
import '../../../../Widgegt/textField.dart';
import '../controller/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        textField('Email', controller.signInEmail, hintText: 'your@email.com'),
        SizedBox(height: 16.h),
        textField(
          'Password',
          controller.signInPassword,
          obscure: true,
          hintText: 'Enter your password',
        ),
        const SizedBox(height: 32),

        Obx(
          () => mainButton(
            loading: controller.isLoading.value,
            onTap: controller.signIn,
          ),
        ),

        const SizedBox(height: 16),
        termsText(),
      ],
    );
  }
}
