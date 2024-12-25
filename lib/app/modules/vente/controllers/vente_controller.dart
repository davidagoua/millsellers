import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:millsellers/app/controllers/auth_controller.dart';
import 'package:millsellers/app/data/models/sale_model.dart';
import 'package:millsellers/app/data/models/seller_resource_model.dart';
import 'package:millsellers/utils/contants.dart';

class VenteController extends GetxController {


  Rx<SellerResource> resource = SellerResource().obs;
  final loading = false.obs;
  final sales = [].obs;

  @override
  void onInit() async {
    super.onInit();
    resource.value = SellerResource.fromJson(GetStorage().read("user"));
    print("sales ${resource.value.sales}");
    await getVentes();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getVentes() async {
    loading.value = true;
    final authManager = Get.find<AuthController>();

    var headers = {
      "Content-Type":"application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer ${authManager.getToken()}',
    };
    var dio = Dio();
    var response = await dio.request(
      BASE_URL + '/seller/sales',
      options: Options(
          method: 'GET',
          headers: headers,
          validateStatus: (value)=> true
      ),
    );

    print("headers: ${response.requestOptions.headers}");

    if (response.statusCode == 200) {
      
      sales.value = (response.data['data'] as List).map((data) => Sale.fromJson(data)).toList();
    }else {
      print(response.statusMessage);
    }
    loading.value = false;
  }
}
