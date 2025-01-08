import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:millsellers/app/controllers/auth_controller.dart';

final logger = Logger();

class FieulController extends GetxController {
  final authManager = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    fetchFieul();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<List?> fetchFieul({String? id}) async {
    String paramsId = "";
    if (id == null) {
      paramsId = authManager.box.read("user")['seller']['id'] ?? "";
    } else {
      paramsId = id;
    }

    final dio = Dio();
    final options = Options(
      validateStatus: (v) => true,
      headers: {
        'Authorization': 'Bearer ${authManager.getToken()}',
        'Accept': 'application/json',
      },
    );
    try {
      final response = await dio.get(
          'https://api.1000vendeurs.academy/api/seller/invitees/${paramsId}',
          options: options);
      
      return response.data['data'] as List;
    } catch (e, s) {
      logger.e(e, stackTrace: s);
    }

    return null;
  }
}
