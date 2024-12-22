import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../../data/models/product_model.dart';
import 'package:millsellers/app/controllers/auth_controller.dart';
import 'package:millsellers/utils/contants.dart';


class ProductListController extends GetxController {
  var authManager = Get.find<AuthController>();
  final products = <Product>[].obs;
  final isLoading = false.obs;
  final dio = Dio();

  @override
  void onInit() {
    super.onInit();
    fetchProduct();
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
        '${BASE_URL}/products',
        options: options,
      );

      if (response.statusCode == 200) {
        final List<dynamic> productsJson = response.data['data'];
        
        // Conversion des données JSON en objets Product
        products.value = productsJson
            .map((json) => Product.fromJson(json))
            .toList();
      }
    } catch (e, t) {
      print('Erreur lors de la récupération des produits: $t');
      print('Erreur lors de la récupération des produits: $e');
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
