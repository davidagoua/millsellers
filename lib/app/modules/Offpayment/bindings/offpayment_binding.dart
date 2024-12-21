import 'package:get/get.dart';
import 'package:millsellers/app/data/providers/register_schema_provider.dart';

import '../controllers/offpayment_controller.dart';

class OffpaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OffpaymentController>(
      () => OffpaymentController(),
    );

    Get.lazyPut<RegisterSchemaProvider>(()=> RegisterSchemaProvider());
  }
}
