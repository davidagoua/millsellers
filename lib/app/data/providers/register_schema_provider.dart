import 'package:get/get.dart';
import 'package:millsellers/utils/contants.dart';
import '../models/register_schema_model.dart';

class RegisterSchemaProvider extends GetConnect {

  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return RegisterSchema.fromJson(map);
      if (map is List) {
        return map.map((item) => RegisterSchema.fromJson(item)).toList();
      }
    };
    httpClient.baseUrl = BASE_URL;
  }

  Future<RegisterSchema?> getRegisterSchema(int id) async {
    final response = await get('register/$id');
    return response.body;
  }

  Future<Response<RegisterSchema>> postRegisterSchema(
          RegisterSchema registerschema) async =>
      await post('https://api.1000vendeurs.academy/api/register', registerschema);
  Future<Response> deleteRegisterSchema(int id) async =>
      await delete('register/$id');
}
