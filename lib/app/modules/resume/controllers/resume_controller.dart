import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:millsellers/app/controllers/auth_controller.dart';
import 'package:millsellers/app/data/models/seller_resource_model.dart';
import 'package:millsellers/app/routes/app_pages.dart';

class ResumeController extends GetxController {

  Rx<SellerResource> resource = SellerResource().obs;
  final pullKey = GlobalKey();
  final authManager = Get.find<AuthController>();

  Future<void> refresh() async{
    await resource.value.setSolde();
    await resource.value.setVentes();
    await resource.value.setStock();
  }

  @override
  void onInit() async {
    final box = GetStorage();
    if(box.read("user") != null){
      resource.value = SellerResource.fromJson(box.read("user"));
      await resource.value.setVentes();
      await resource.value.setStock();
      await resource.value.setSolde();
      await box.write('user', resource.toJson());
    }else{
      Get.toNamed(Routes.HOME);
    }
    super.onInit();

  }


}
