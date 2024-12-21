import 'package:get/get.dart';

import '../controllers/reapform_controller.dart';

class ReapformBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReapformController>(
      () => ReapformController(),
    );
  }
}
