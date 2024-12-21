import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:millsellers/app/controllers/auth_controller.dart';

class RechargeController extends GetxController {
  final canalCtrl = TextEditingController();
  final Rx<String> file = "".obs;

  final formKey = GlobalKey<FormState>();

  final referenceCtrl = TextEditingController();

  final loading = false.obs;

  final count = 0.obs;

  var uniteCtrl = TextEditingController();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  void submit() async {

    AuthController authController = Get.find();

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${authController.getToken()}'
    };
    var data = FormData.fromMap({
      'files': [await MultipartFile.fromFile(file.value)],
      'amount': uniteCtrl.text,
      'payment[reference]': referenceCtrl.text
    });

    var dio = Dio();
    var response = await dio.request(
      'https://api.1000vendeurs.academy/api/seller/recharges',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 201) {
      Get.snackbar("Demande de rechargement soumise !", "Vous serez notifier d'ici peu !", colorText: Colors.white, backgroundColor: Colors.green[500]);
    }
    else {
      print(response.statusMessage);
    }
  }
}
