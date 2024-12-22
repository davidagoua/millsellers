import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:millsellers/app/controllers/auth_controller.dart';
import 'package:millsellers/app/data/models/seller_resource_model.dart';
import 'package:millsellers/utils/contants.dart';

class NewsellController extends GetxController {


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
    Map<String, dynamic>? args = Get.parameters;
    if(args['id'] != null){
      customerId = args['id']!;
    }
    if(args['product_id'] != null){
      product_id.value = args['product_id'];
    }
    if(args['product_name'] != null){
      product_id.value = args['product_name'];
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

    if(customerId.isEmpty){
      data = json.encode({
        "customer_id": customerId,
        "product_id": product_id.value,
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
    print(response.data);
    if (response.statusCode == 200) {
      print(json.encode(response.data));
      Get.snackbar("Excellent !", "Votre vente a été enrégistrée", colorText: Colors.white, backgroundColor: Colors.green[500]);
      SellerResource resource = SellerResource.fromJson(GetStorage().read("user"));
      resource.setStock();
      resource.setSolde();
      resource.setVentes();

    }else {
      Get.snackbar("Désolé !", "Une erreur est survenu lors de l'enregistrement de votre commande.", colorText: Colors.white, backgroundColor: Colors.red[500]);
      print(response.statusMessage);
    }
    loading.value = false;
  }
}
