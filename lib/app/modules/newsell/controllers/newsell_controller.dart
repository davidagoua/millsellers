import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:get_storage/get_storage.dart';
import 'package:millsellers/app/controllers/auth_controller.dart';
import 'package:millsellers/app/data/models/seller_resource_model.dart';
import 'package:millsellers/utils/contants.dart';
import 'package:millsellers/app/modules/vente/controllers/vente_controller.dart';
import 'package:millsellers/app/modules/newsell/views/success_view.dart';



class NewsellController extends GetxController {

  final logger = Logger();

  var countryCtrl = TextEditingController();
  var villeCtrl = TextEditingController();
  var addressCtrl = TextEditingController();
  var nameCtrl = TextEditingController();
  var uniteCtrl = TextEditingController();
  var priceCtrl = TextEditingController();
  var contactCtrl = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var customerId = "";
  var product_id = "".obs;
  var product_name = "".obs;
  final loading = false.obs;


  @override
  void onInit() {
    Map<String, dynamic>? args = Get.arguments;
    if(args?['id'] != null){
      customerId = args?['id']!;
    }
    if(args?['product_id'] != null){
      product_id.value = args?['product_id'];
    }
    if(args?['product_name'] != null){
      product_id.value = args?['product_name'];
    }


  }

  void validate() async {
    if(formKey.currentState!.validate()){

      submit();

    }
  }

  void submit() async {
    loading.value = true;
    var dio = Dio();
    var authManager = Get.find<AuthController>();

    var data = json.encode({
      "customer_id": customerId,
      "person": null,
      "quantity": uniteCtrl.text,
      "amount": priceCtrl.text
    });
    logger.d(Get.arguments?['product_id'] );
    if(customerId.isEmpty){
      data = json.encode({
        "customer_id": customerId,
        "product_id": Get.arguments?['product_id'] ,
        "person": {
          "name": nameCtrl.text,
          "phone": contactCtrl.text,
          "place": {
            "country": countryCtrl.text,
            "city": villeCtrl.text,
            "address": addressCtrl.text
          }
        },
        "quantity":  uniteCtrl.text ,
        "amount": priceCtrl.text
      });
    }

    var response = await dio.post(
      '${BASE_URL}/seller/sales',
      options: Options(
        validateStatus: (value)=> true,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': "Bearer ${authManager.getToken()} ",
        },
      ),
      data: data,
    );
    logger.d(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      logger.d(response.data);
      Get.snackbar("Excellent !", "Votre vente a été enrégistrée", colorText: Colors.white, backgroundColor: Colors.green[500]);
      SellerResource resource = SellerResource.fromJson(GetStorage().read("user"));
      resource.setStock();
      resource.setSolde();
      resource.setVentes();

      // refresh vente on vent controller
      Get.find<VenteController>().getVentes();
      Get.back();
      Get.to(() => const SuccessView());

    }else {
      Get.snackbar("Désolé !", response.data['message'], colorText: Colors.white, backgroundColor: Colors.red[500]);
      print(response.statusMessage);
    }
    loading.value = false;
  }
}
