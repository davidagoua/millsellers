

import 'package:get/get.dart';
import 'package:millsellers/app/data/models/product_model.dart';
import 'package:logger/logger.dart';

class ProductDetailsController extends GetxController {

  final logger = Logger();

  final RxInt currentImageIndex = 0.obs;
  final RxBool isFavorite = false.obs;
  final Rx<Product?> product = Rx<Product?>(Get.arguments!['product'] as Product);


  @override
  void onInit() {
    super.onInit();
    product.value = Get.arguments!['product'] as Product;
    
  }


  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
    product.value = Get.arguments!['product'] as Product;
    
  }

  void updateImageIndex(int index) {
    currentImageIndex.value = index;
  }
}
