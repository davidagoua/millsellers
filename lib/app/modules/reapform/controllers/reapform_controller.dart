import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:millsellers/app/controllers/auth_controller.dart';
import 'package:millsellers/app/modules/resume/controllers/resume_controller.dart';
import 'package:millsellers/utils/contants.dart';
import '../views/success_view.dart';



class ReapformController extends GetxController {
  final log = Logger();
  final formKey = GlobalKey<FormState>();
  var shopSizeCtrl = TextEditingController();
  var nameCtrl = TextEditingController();
  var phoneCTrl = TextEditingController();
  var villeCtrl = TextEditingController();
  var addressCtrl = TextEditingController();
  var countryCtrl = TextEditingController();
  var quantityCtrl = TextEditingController(text: "1");
  var price = 0.obs;
  final product_name = "".obs;

  final loading = false.obs;
  Rx<int> unite = 1.obs;

  @override
  void onInit() {
    super.onInit();
    price.value = Get.arguments?['product_price'] as int;
    product_name.value = Get.arguments?['product_name'] as String;
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
        "product_id": Get.arguments?['product_id'],
        "quantity": quantityCtrl.value.text,
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

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar("Demande de reapprovisionnement envoyée", "Vous serez notifier dans quelques instant", colorText: Colors.green[500], backgroundColor: Colors.green[100]);
        final ResumeController rs = Get.find();
        await rs.refresh();
        Get.back();
        Get.to(() => const ReapformSuccessView());
      }
      else {
        log.e(response.statusMessage);
        Get.snackbar("Désolé !", response.data['message'], colorText: Colors.white, backgroundColor: Colors.red[500]);
      }
    }
    loading.value = false;
  }

}
