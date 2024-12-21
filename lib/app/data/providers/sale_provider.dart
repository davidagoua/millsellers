import 'package:get/get.dart';
import 'package:millsellers/utils/contants.dart';
import '../models/sale_model.dart';

class SaleProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Sale.fromJson(map);
      if (map is List) return map.map((item) => Sale.fromJson(item)).toList();
    };
    httpClient.baseUrl = BASE_URL;
  }

  Future<Sale?> getSale(int id) async {
    final response = await get('sale/$id');
    return response.body;
  }

  Future<Response<Sale>> postSale(Sale sale) async => await post('sale', sale);
  Future<Response> deleteSale(int id) async => await delete('sale/$id');
}
