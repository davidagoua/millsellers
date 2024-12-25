import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:millsellers/utils/contants.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:millsellers/app/controllers/auth_controller.dart';
import 'package:millsellers/app/data/models/product_model.dart';
import 'package:millsellers/app/data/models/seller_resource_model.dart';
import 'package:millsellers/app/routes/app_pages.dart';
import 'package:url_launcher/url_launcher.dart';

class ResumeController extends GetxController {

  final log = Logger();
  final products = <Product>[].obs;
  Rx<SellerResource> resource = SellerResource().obs;
  SellerResource get iresource => resource.value;
  final Rx<int?> balance = 0.obs;
  final pullKey = GlobalKey();
  final authManager = Get.find<AuthController>();
  final productLoading = false.obs;

  Future<void> refresh() async{
    balance.value =  await resource.value.setSolde();
    
    await resource.value.setVentes();
    await fetchProduct();
    resource.value.stock = await resource.value.setStock();
  }

  Future<void> launchWavePayment({
    required double amount,
    String? currency = 'XOF',
  }) async {
    // Format Wave URL avec le montant
    final Uri waveUrl = Uri.parse('wave://payment?amount=$amount&currency=$currency');
    
    try {
      if (await canLaunchUrl(waveUrl)) {
        await launchUrl(waveUrl);
      } else {
        // Si Wave n'est pas installé, on peut rediriger vers le Play Store
        final Uri playStoreUrl = Uri.parse(
          'https://play.google.com/store/apps/details?id=com.wave.personal',
        );
        if (await canLaunchUrl(playStoreUrl)) {
          await launchUrl(playStoreUrl);
        }
        Get.snackbar(
          'Erreur',
          'Veuillez installer Wave pour effectuer le paiement',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Impossible de lancer Wave',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onReady() async {
    super.onReady();
    await refresh();
  }

  @override
  void onInit() async {
    final box = GetStorage();
    if(box.read("user") != null){
      resource.value = SellerResource.fromJson(box.read("user"));
      await refresh();
      
      await box.write('user', resource.toJson());
    }else{
      Get.toNamed(Routes.HOME);
    }
    super.onInit();

  }


  Future<void> fetchProduct() async {
    try {
      productLoading.value = true;

      // Configuration de l'en-tête avec le token d'authentification
      final options = Options(
        validateStatus: (v) => true,
        headers: {
          'Authorization': 'Bearer ${authManager.getToken()}',
          'Accept': 'application/json',
        },
      );

      // Appel API pour récupérer les produits
      final response = await Dio().get(
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
      
      productLoading.value = false;
    }
  }

  // Méthode pour rafraîchir la liste des produits
  Future<void> refreshProducts() async {
    await fetchProduct();
  }

}
