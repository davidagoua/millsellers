import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  //TODO: Implement OnboardingController
  final scrollController = PageController();
  final count = 0.obs;



  void increment() => count.value++;
}
