import 'package:get/get.dart';

import '../controllers/vente_controller.dart';

class VenteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VenteController>(
      () => VenteController(),
    );
  }
}
