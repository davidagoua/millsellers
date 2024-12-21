import 'package:get/get.dart';
import 'package:millsellers/app/data/providers/pack_provider.dart';

import '../controllers/first_product_controller.dart';

class FirstProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FirstProductController>(
      () => FirstProductController(),
    );
    Get.lazyPut<PackProvider>(()=> PackProvider());
  }
}
