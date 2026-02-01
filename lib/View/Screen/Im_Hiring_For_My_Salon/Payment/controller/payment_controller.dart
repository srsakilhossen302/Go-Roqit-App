import 'package:flutter/material.dart';
import 'package:get_x/get.dart';
import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_navigation/src/extension_navigation.dart';
import 'package:get_x/get_navigation/src/snackbar/snackbar.dart';
import 'package:get_x/get_rx/src/rx_types/rx_types.dart';
import 'package:get_x/get_state_manager/src/simple/get_controllers.dart';
import '../../Choose_Plan/model/plan_model.dart';

class PaymentController extends GetxController {
  late PlanModel selectedPlan;

  var isLoading = false.obs;

  // Form Controllers
  final cardNumberController = TextEditingController();
  final cardHolderController = TextEditingController();
  final expiryDateController = TextEditingController();
  final cvvController = TextEditingController();

  // Calculated Totals
  double get subtotal => _parsePrice(selectedPlan.price);
  double get vat => subtotal * 0.20; // Assuming 20% VAT
  double get total => subtotal + vat;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is PlanModel) {
      selectedPlan = Get.arguments;
    } else {
      // Fallback or error handling
      selectedPlan = PlanModel(
        id: 'err',
        name: 'Error',
        price: '0',
        features: [],
      );
    }
  }

  @override
  void onClose() {
    cardNumberController.dispose();
    cardHolderController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
    super.onClose();
  }

  double _parsePrice(String priceString) {
    // Remove "£" and any other non-numeric chars except period
    String sanitized = priceString.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(sanitized) ?? 0.0;
  }

  void proceedToPayment() {
    if (cardNumberController.text.isEmpty ||
        cardHolderController.text.isEmpty ||
        expiryDateController.text.isEmpty ||
        cvvController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all payment details',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.bottom,
      );
      return;
    }

    isLoading.value = true;

    // Simulate Payment Processing
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;

      Get.snackbar(
        'Success',
        'Subscription Activated!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.bottom,
      );

      // Navigate back to Dashboard or Jobs page
      // Get.until((route) => Get.currentRoute == '/RecruiterPanelView'); // Example
    });
  }
}
