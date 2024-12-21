import 'package:get/get.dart';

import '../controllers/account_verifying_controller.dart';

class AccountVerifyingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountVerifyingController>(
      () => AccountVerifyingController(),
    );
  }
}
