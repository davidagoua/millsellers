import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:millsellers/utils/contants.dart';

import '../models/pack_model.dart';

final logger = Logger();

class PackProvider extends GetConnect {
  @override
  void onInit() {

    //httpClient.baseUrl = BASE_URL;
  }

  Future<List<Pack?>> getPackList() async {
    List<Pack?> data = [];
    final response = await get('https://api.1000vendeurs.academy/api/packs');
    logger.d(response.request?.url);

    if(response.statusCode! == 200){
      data = (response.body! as List<dynamic>).map(( entry){
        return Pack.fromJson(entry);
      }).toList();
      return data;
    }else{
      logger.e(response.statusCode!);
    }
    return data;
  }

  Future<Pack?> getPack(int id) async {
    final response = await get('/packs/$id');
    return response.body;
  }

  Future<Response<Pack>> postPack(Pack pack) async => await post('pack', pack);
  Future<Response> deletePack(int id) async => await delete('pack/$id');
}
