import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:millsellers/app/controllers/auth_controller.dart';
import 'package:millsellers/app/data/models/order.dart';
import 'package:millsellers/utils/contants.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class CommandeListController extends GetxController {

  RxList<Order> orders = <Order>[].obs;
  RxList<Order> filteredOrders = <Order>[].obs;
  final loading = false.obs;

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
    loading.value = true;
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
    logger.i(response.statusCode);
    logger.i(response.data);
    if (response.statusCode == 200) {

      orders.value = (response.data['data'] as List).map((data) => Order.fromJson(data)).toList();
    }
    else {
      print(response.statusMessage);
    }
    loading.value = false;
  }
}
