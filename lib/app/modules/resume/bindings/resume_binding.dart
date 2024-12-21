import 'package:get/get.dart';

import '../controllers/resume_controller.dart';

class ResumeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResumeController>(
      () => ResumeController(),
    );
  }
}
