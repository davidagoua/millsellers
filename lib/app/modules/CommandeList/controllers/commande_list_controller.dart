import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:millsellers/app/controllers/auth_controller.dart';
import 'package:millsellers/utils/contants.dart';

class CommandeListController extends GetxController {

  RxList<Map<String, dynamic>> orders = <Map<String, dynamic>>[].obs;

  @override
  void onInit() async {
    super.onInit();

    await getOrders();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getOrders() async {
    AuthController authManager = Get.find<AuthController>();
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authManager.getToken()}'
    };

    var dio = Dio();
    var response = await dio.get(
      BASE_URL+'/seller/orders',
      options: Options(
        headers: headers,
      ),
    );
    print(response.statusCode);
    print(response.data);
    if (response.statusCode == 200) {

      orders.value = response.data['data'];
    }
    else {
      print(response.statusMessage);
    }
  }
}
