import 'package:get/get.dart';

import '../controllers/newsell_controller.dart';

class NewsellBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewsellController>(
      () => NewsellController(),
    );
  }
}
