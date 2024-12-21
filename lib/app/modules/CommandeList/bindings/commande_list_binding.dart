import 'package:get/get.dart';

import '../controllers/commande_list_controller.dart';

class CommandeListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommandeListController>(
      () => CommandeListController(),
    );
  }
}
