import 'package:get/get.dart';

import '../controllers/account_verified_controller.dart';

class AccountVerifiedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountVerifiedController>(
      () => AccountVerifiedController(),
    );
  }
}
