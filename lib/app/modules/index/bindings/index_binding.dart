import 'package:get/get.dart';
import 'package:millsellers/app/modules/CommandeList/controllers/commande_list_controller.dart';
import 'package:millsellers/app/modules/Fieul/controllers/fieul_controller.dart';
import 'package:millsellers/app/modules/resume/controllers/resume_controller.dart';
import 'package:millsellers/app/modules/vente/controllers/vente_controller.dart';

import '../controllers/index_controller.dart';

class IndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IndexController>(
      () => IndexController(),
    );
    Get.lazyPut<ResumeController>(()=> ResumeController());
    Get.lazyPut<VenteController>(()=> VenteController());
    Get.lazyPut<FieulController>(()=> FieulController());
    Get.lazyPut<CommandeListController>(()=> CommandeListController());
  }
}
