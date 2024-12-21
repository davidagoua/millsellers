import 'package:get/get.dart';

import '../controllers/inscription_form_controller.dart';

class InscriptionFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InscriptionFormController>(
      () => InscriptionFormController(),
    );
  }
}
