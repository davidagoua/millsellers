import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:millsellers/app/routes/app_pages.dart';
import '../../data/models/product_model.dart';
import 'package:millsellers/app/controllers/auth_controller.dart';
import 'package:millsellers/utils/contants.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class ProductListController extends GetxController {


  var authManager = Get.find<AuthController>();
  final products = <Product>[].obs;
  final isLoading = false.obs;
  final dio = Dio();
  final next_route = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchProduct();
    next_route.value = Get.arguments?['next_route'] ?? Routes.NEWSELL;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> fetchProduct() async {
    try {
      isLoading.value = true;

      // Configuration de l'en-tête avec le token d'authentification
      final options = Options(
        headers: {
          'Authorization': 'Bearer ${authManager.getToken()}',
          'Accept': 'application/json',
        },
      );

      // Appel API pour récupérer les produits
      final response = await dio.get(
        '${BASE_URL}/seller/products',
        options: options,
      );
      logger.i(response.data);
      if (response.statusCode == 200) {
        products.value = (response.data['data'] as List)
            .map((data) => Product.fromJson(data))
            .toList();
      }
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Impossible de récupérer les produits',
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Méthode pour rafraîchir la liste des produits
  Future<void> refreshProducts() async {
    await fetchProduct();
  }
}
