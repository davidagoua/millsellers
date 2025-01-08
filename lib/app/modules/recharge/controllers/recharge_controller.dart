import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:logger/logger.dart';
import 'package:millsellers/app/controllers/auth_controller.dart';
import 'package:millsellers/app/modules/recharge/views/success_view.dart';

class RechargeController extends GetxController {
  final logger = Logger();

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
    loading.value = true;
    logger.i(file.value);

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${authController.getToken()}'
    };
    var data = FormData.fromMap({
      'files': [await MultipartFile.fromFile(file.value)],
      'amount': uniteCtrl.text,
      'payment': {
        'reference': referenceCtrl.text,
        'file': await MultipartFile.fromFile(file.value)
      }
    });

    var dio = Dio();
    var response = await dio.request(
      'https://api.1000vendeurs.academy/api/seller/recharges',
      options: Options(
        validateStatus: (v) => true,
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    logger.e(response.statusCode);
    logger.e(response.statusMessage);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.snackbar("Demande de rechargement soumise !",
          "Vous serez notifier d'ici peu !",
          colorText: Colors.green[700], backgroundColor: Colors.green[100]);
      Get.back();
      Get.to(() => RechargeSuccessView());
    } else {
      Get.snackbar("Erreur", "${response.data['message']}",
          colorText: Colors.red[700], backgroundColor: Colors.red[100]);
      logger.e(response.statusMessage);
    }

    loading.value = false;
  }
}
