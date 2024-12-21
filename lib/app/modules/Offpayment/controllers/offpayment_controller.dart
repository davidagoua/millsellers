import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lottie/lottie.dart';
import 'package:millsellers/app/data/models/register_schema_model.dart';
import 'package:dio/dio.dart';
import 'package:millsellers/app/routes/app_pages.dart';
import 'package:velocity_x/velocity_x.dart';

class OffpaymentController extends GetxController {
  final canalCtrl = TextEditingController();
  final Rx<String> file = "".obs;
  RegisterSchema? registerSchema;

  final formKey = GlobalKey<FormState>();
  final canal = "".obs;
  final referenceCtrl = TextEditingController();

  final loading = false.obs;

  @override
  void onInit() {
    registerSchema = Get.arguments;
    print("arguments $registerSchema");
  }

  void submit() async {
    loading.value = true;
    if (formKey.currentState!.validate()) {
      send();
    }
    loading.value = false;
  }

  void send() async {
    final dio = Dio();
    registerSchema?.paymentFile = file;
    registerSchema?.paymentReference = referenceCtrl.text;
    print(file);
    print(registerSchema?.toJson());

    var data = FormData.fromMap({
      'files': [await MultipartFile.fromFile(file.value)],
      'pack_id':
          registerSchema?.packId ?? '00000000-0000-0000-0000-000000000001',
      'seller': {
        "name": registerSchema?.sellerName,
        "phone": registerSchema?.sellerPhone,
        "gender": registerSchema?.sellerGender,
        "profession": registerSchema?.sellerProfession,
        "tshirt": {
          "delivery_place": "${registerSchema?.sellerTshirtDeleveryPlace}",
          "size": (registerSchema?.sellerTshirtSize as String).toLowerCase()
        },
        "place": {
          "country": registerSchema?.sellerPlaceCountry,
          "city": registerSchema?.sllerPlaceCity,
          "address": registerSchema?.sllerPlaceAddress
        },
        "password": "${registerSchema?.sellerPassword}",
        "email": registerSchema?.sellerEmail,
        "referral_id": registerSchema?.sellerReferalId
      },
      'payment': {
        "reference": referenceCtrl.text,
        "file": await MultipartFile.fromFile(file.value)
      },
      if (registerSchema?.packId != null)
        'shop': {
          "phone": registerSchema?.shopPhone,
          "place": {
            "country": registerSchema?.shopPlaceCountry,
            "city": "${registerSchema?.shopPlaceCity}",
            "address": "${registerSchema?.shopPlaceAddress}"
          }
        },
      'seller.name': registerSchema?.sellerName,
      'seller.phone': registerSchema?.sellerPhone,
      'seller.place.country': registerSchema?.sellerPlaceCountry,
      'seller.place.city': registerSchema?.sllerPlaceCity,
      'seller.place.address': registerSchema?.sllerPlaceAddress ?? "",
      'seller.email': registerSchema?.sellerEmail,
      'seller.gender': registerSchema?.sellerGender,
      'seller.profession': registerSchema?.sellerProfession,
      'seller.tshirt.delivery_place': registerSchema?.sellerTshirtDeleveryPlace,
      'seller.tshirt.size': (registerSchema?.sellerTshirtSize as String).toLowerCase(),
      'seller.password': registerSchema?.sellerPassword ?? 'password'
    });

    try {
      loading.value = true;
      final response = await dio.post(
          "https://api.1000vendeurs.academy/api/seller/registration",
          data: data,
          options: Options(
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              },
              headers: {
                'Content-Type': 'multipart/form-data',
                'Accept': 'application/json'
              }));
      print(" Request path  ${response.requestOptions.path}");
      print(response.statusMessage);
      print(response.data);

      final box = GetStorage();
      await box.write('adhesion_token', response.data["token"]);
      await box.write("isOnboard", true);
    } catch (e) {
      rethrow;
    } finally {
      loading.value = false;
    }

    Get.dialog(Container(
      height: Get.height / 10 * 1,
      padding: const EdgeInsets.all(20),
      child: VStack(
        [
          Lottie.network(
              "https://lottie.host/f8318bb0-a076-4adb-b2d5-b08d3e86984c/VbyuTssOV6.json",
              height: 200,
              width: 200),
          10.heightBox,
          "Votre compte est en cours de validation ..."
              .text
              .align(TextAlign.center)
              .make(),
          "Vous serez notifier à l'activation du compte"
              .text
              .size(13)
              .align(TextAlign.center)
              .color(Vx.gray500)
              .make(),
          20.heightBox,
          GFButton(
            shape: GFButtonShape.pills,
            color: Vx.green700,
            textColor: Vx.white,
            fullWidthButton: true,
            onPressed: () => {Get.offAllNamed(Routes.HOME)},
            text: "Retour au formulaire de connexion",
          )
        ],
        crossAlignment: CrossAxisAlignment.center,
        alignment: MainAxisAlignment.center,
      ),
    ).card.white.make().marginAll(20).h(Get.height / 10 * 2));
  }
}
