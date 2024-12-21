import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:millsellers/app/controllers/auth_controller.dart';
import 'package:millsellers/utils/contants.dart';

class ReapformController extends GetxController {

  final formKey = GlobalKey<FormState>();
  var shopSizeCtrl = TextEditingController();
  var nameCtrl = TextEditingController();
  var phoneCTrl = TextEditingController();
  var villeCtrl = TextEditingController();
  var addressCtrl = TextEditingController();
  var countryCtrl = TextEditingController();
  var quantityCtrl = TextEditingController();

  final loading = false.obs;
  Rx<int> unite = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void submit() async {
    loading.value = true;
    if(formKey.currentState!.validate()){
      AuthController authController = Get.find();

      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${authController.getToken()}"
      };
      var data = json.encode({
        "quantity": unite.value,
        "person": {
          "name": nameCtrl.text,
          "phone": phoneCTrl.text,
          "place": {
            "country": countryCtrl.text,
            "city": villeCtrl.text,
            "address": addressCtrl.text
          }
        }
      });
      var dio = Dio();
      var response = await dio.request(
        BASE_URL + '/seller/orders',
        options: Options(
          validateStatus: (v)=> true,
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 201) {
        Get.snackbar("Demande de reapprovisionnement envoyée", "Vous serez notifier dans quelques instant", colorText: Colors.white, backgroundColor: Colors.green[500]);
      }
      else {
        print(response.statusCode);
      }
    }
    loading.value = false;
  }

}
