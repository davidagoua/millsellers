import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide FormData;
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:millsellers/app/controllers/auth_controller.dart';
import 'package:millsellers/app/data/models/seller_resource_model.dart';
import 'package:millsellers/app/routes/app_pages.dart';
import 'package:millsellers/utils/contants.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeController extends GetxController {

  final Logger logger = Logger();

  final formKey = GlobalKey<FormState>();
  final contactCtrl = TextEditingController(text:"sikirou@1000vendeurs.academy");
  final password = TextEditingController(text:"azerty123");
  final showError = false.obs;
  final showPassword = true.obs;
  final loading = false.obs;

  void submit() async{

    loading(true);
    if(formKey.currentState!.validate()){
      final dio = Dio();

      final response = await dio.post("https://api.1000vendeurs.academy/api/seller/login",
          data:  json.encode({
            "email": contactCtrl.text,
            "password": password.text
          }),
          options: Options(
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              },
              headers: {"Content-Type":"application/json","Accept":"application/json"}
          )
      );

      if(response.statusCode == 422){
        showError.value = true;
        Get.snackbar("Impossible de se connecter", "Email  ou mot de passe incorrect !",
          duration: const Duration(seconds: 5), shouldIconPulse: true, backgroundColor: Vx.red500, colorText: Vx.white,
        ) ;
      }else if(response.statusCode == 200){
        final box = GetStorage();

        final authManager = Get.find<AuthController>();
        authManager.login(response.data['token']);
        

        final meResponse = await dio.get('$BASE_URL/seller/me', options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
          headers: {
            "Content-Type":"application/json",
            "Accept":"application/json",
            "Authorization":"Bearer ${response.data['token']}"
            }
        ));
        
        if(meResponse.statusCode == 200){
          print(meResponse.data['data']);
          final resource = SellerResource.fromJson(meResponse.data['data']);
          await resource.setSolde();
          await resource.setVentes();
          await resource.setStock();
          await box.write('user', resource.toJson());
          Get.offAllNamed(Routes.INDEX);
        }


      }
    }

    loading(false);
  }

}
