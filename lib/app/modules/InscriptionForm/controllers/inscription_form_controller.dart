
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:millsellers/app/data/models/register_schema_model.dart';
import 'package:millsellers/app/routes/app_pages.dart';

class InscriptionFormController extends GetxController {
  //TODO: Implement InscriptionFormController

  final count = 0.obs;
  String? pack_id;
  final showPassword = true.obs;
  final showReferal = false.obs;
  final formKey = GlobalKey<FormState>();
  final nomCtrl = TextEditingController();
  final referal_id = TextEditingController();
  final villeCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final contactCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final professionCtrl = TextEditingController();
  final countryCtrl = TextEditingController();
  final shopDeliverAtCtrl = TextEditingController();
  final shopVilleCtrl = TextEditingController();
  final ShopPaysCtrl = TextEditingController();
  final shopPhoneCtrl = TextEditingController();
  final shopSizeCtrl = TextEditingController();
  final shopAddresseCtrl = TextEditingController();
  final countries = [].obs;

  var  genre = "";

  bool validateForm(){
    if(formKey.currentState!.validate()){
      return true;
    }
    return false;
  }

  String? required(String? value){
    if(value!.isEmpty){
      return "Ce champ est obligatoire";
    }
    return null;
  }

  @override
  void onInit() async {
    super.onInit();

    pack_id = Get.arguments;
    await setCountries();
  }

  void increment() => count.value++;

  void offlinePayment() {
    if(validateForm()){
      RegisterSchema registerSchema =  RegisterSchema(
        packId: pack_id,
        sellerEmail: emailCtrl.text,
        sellerGender: 'male',
        sellerName: nomCtrl.text,
        sellerPassword: passwordCtrl.text,
        sellerPhone: contactCtrl.text,
        sellerPlaceCountry: countryCtrl.text,
        sellerProfession: professionCtrl.text,
        sellerReferalId: referal_id.text,
        sellerTshirtDeleveryPlace: addressCtrl.text,
        sellerTshirtSize: shopSizeCtrl.text.toLowerCase(),
        shopPhone: shopPhoneCtrl.text,
        shopPlaceAddress: addressCtrl.text,
        shopPlaceCity: villeCtrl.text,
        shopPlaceCountry: ShopPaysCtrl.text,
        sllerPlaceAddress: addressCtrl.text,
        sllerPlaceCity: villeCtrl .text,
      );
      Get.offAndToNamed(Routes.OFFPAYMENT, arguments: registerSchema);
    }
  }

  Future<void> setCountries() async {
    final dio = Dio();
    final response = await dio.get("https://restcountries.com/v3.1/all");
    if(response.statusCode == 200){
      print(response.data);
      print(response.data.toString());
      //countries.value = response.data.map((value)=> value['name']['common']);
      // print(" countries ${countries.value}");
    }
  }
}
