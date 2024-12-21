import 'package:get/get.dart';

import '../controllers/fieul_controller.dart';

class FieulBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FieulController>(
      () => FieulController(),
    );
  }
}
