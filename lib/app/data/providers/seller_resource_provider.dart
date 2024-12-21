import 'package:get/get.dart';

import '../models/seller_resource_model.dart';

class SellerResourceProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return SellerResource.fromJson(map);
      if (map is List) {
        return map.map((item) => SellerResource.fromJson(item)).toList();
      }
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<SellerResource?> getSellerResource(int id) async {
    final response = await get('sellerresource/$id');
    return response.body;
  }

  Future<Response<SellerResource>> postSellerResource(
          SellerResource sellerresource) async =>
      await post('sellerresource', sellerresource);
  Future<Response> deleteSellerResource(int id) async =>
      await delete('sellerresource/$id');
}
