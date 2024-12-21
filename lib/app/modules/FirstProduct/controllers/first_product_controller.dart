import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:millsellers/app/data/models/pack_model.dart';
import 'package:millsellers/app/data/providers/pack_provider.dart';

class FirstProductController extends GetxController {
  final isRevendor = true.obs;
  final showDescription = true.obs;
  final PackProvider _packProvider = Get.find<PackProvider>();
  var packs = <Pack?>[].obs;
  final packsLoading = false.obs;

  @override
  void onInit() async  {
    try{
      packsLoading.toggle();
      packs.value = await _packProvider.getPackList();
    }catch(e){
      Logger().e(e);
    }finally{
      packsLoading.toggle();
    }
  }
}
