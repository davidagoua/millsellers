import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:slide_switcher/slide_switcher.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../routes/app_pages.dart';
import '../controllers/first_product_controller.dart';

class FirstProductView extends GetView<FirstProductController> {
  const FirstProductView({super.key});
  @override
  Widget build(BuildContext context) {

    return Obx((){
      if(controller.packs.isEmpty && !controller.packsLoading.value){
        return SafeArea(
          child: Container(
            color: const Color.fromRGBO(246, 251, 248, 1),
            child:  Center(
              child:  SizedBox(
                height: Get.height / 10 *3,
                width: double.maxFinite,
                child: Container(

                  child: "Aucun pack disponible".text.size(25).make().centered()
                ).card.make()
              ),
            ),
          ),
        );
      }else if(controller.packs.isEmpty && controller.packsLoading.value){
        return SafeArea(
          child: Container(
            color: const Color.fromRGBO(246, 251, 248, 1),
            child: const Center(
              child: CircularProgressIndicator(color: Vx.green700,),
            ),
          ),
        );
      }else{
        var revendeur = controller.packs[0];
        var agree = controller.packs[1];
        return Scaffold(
          backgroundColor: const Color.fromRGBO(246, 251, 248, 1),
          body: SafeArea(
            child: VStack([
              FadeInUp(child: VStack([
                HStack([
                  Container(
                      padding: const EdgeInsets.all(5),
                      color: Colors.white,
                          child: const FaIcon(Icons.close, color: Vx.gray700,)
                  ).cornerRadius(7).onTap(Get.back),
                ], alignment: MainAxisAlignment.start,).pSymmetric(h: 10).w(double.maxFinite),
                7.heightBox,
                Container(
                  color: Colors.white,
                  child: VStack([
                    10.heightBox,
                    SlideSwitcher(
                      onSelect: (index) {
                        if(index == 0){
                          controller.isRevendor(true);
                        }else if(index == 1){
                          controller.isRevendor(false);
                        }
                      },
                      containerHeight: 30,
                      containerWight: 300,
                      containerColor: Vx.gray100,

                      slidersColors: const [Color.fromRGBO(222, 239, 224, 1)],
                      children: [
                        Text('Particulier', style: TextStyle(color: Colors.green[800]),),
                        Text('Boutique', style: TextStyle(color: Colors.green[800])),
                      ],
                    ),
                    10.heightBox,
                    Image.asset("assets/images/firstproduit.jpg", height: 200,)
                  ], crossAlignment: CrossAxisAlignment.center,),
                ).cornerRadius(15).p(15).w(double.maxFinite),
                3.heightBox,
                Obx(()=> controller.isRevendor() ? VStack([
                  "${revendeur?.overview}".text.make(),
                  "${revendeur?.price} XOF".text.size(22).make(),
                ]).px(15)
                    : VStack([
                  "${agree?.overview}".text.make(),
                  "${agree?.price} XOF".text.size(22).make(),
                ]).px(15),
                )
              ]).p(10).h(Get.height / 10 * 6.2)),

              FadeInDown(child: Obx(()=>
              controller.isRevendor.value
                  ? VStack([
                SlideSwitcher(
                  onSelect: (index) {
                    if(index == 0){
                      controller.showDescription(true);
                    }else{
                      controller.showDescription(false);
                    }
                  },
                  containerHeight: 30,
                  containerWight: 300,
                  containerColor: Vx.gray100,
                  slidersColors: const [Color.fromRGBO(222, 239, 224, 1)],
                  children: [
                    Text('Description', style: TextStyle(color: Colors.green[800]),),
                    Text("Kit d'adhésion", style: TextStyle(color: Colors.green[800])),
                  ],
                ),
                10.heightBox,
                controller.showDescription.value
                    ? "${revendeur?.description}".text.make()
                    : "${revendeur?.contents}".text.make(),

                15.heightBox,
                GFButton(
                  size: GFSize.LARGE,
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  onPressed: (){
                    Get.toNamed(Routes.INSCRIPTION_FORM);
                  },
                  blockButton: true,
                  shape: GFButtonShape.pills,
                  color: const Color.fromRGBO(255, 118, 26, 1),
                  child: HStack([
                    const FaIcon(FontAwesomeIcons.moneyBill  , color: Colors.white,),
                    15.widthBox,
                    "J'intègre les 1000 Vendeurs".text.make(),
                  ], alignment: MainAxisAlignment.center,).w(double.maxFinite),
                )
              ]).p(23).backgroundColor(Vx.white).w(double.maxFinite)
                  : VStack([
                SlideSwitcher(
                  onSelect: (index) {
                    if(index == 0){
                      controller.showDescription(true);
                    }else{
                      controller.showDescription(false);
                    }
                  },
                  containerHeight: 30,
                  containerWight: 300,
                  containerColor: Vx.gray100,
                  slidersColors: const [Color.fromRGBO(222, 239, 224, 1)],
                  children: [
                    Text('Description', style: TextStyle(color: Colors.green[800]),),
                    Text("Kit d'adhésion", style: TextStyle(color: Colors.green[800])),
                  ],
                ),
                10.heightBox,
                controller.showDescription.value
                    ? "${agree?.description}".text.make()
                    : "${agree?.contents}".text.make(),

                15.heightBox,
                GFButton(
                  size: GFSize.LARGE,
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  onPressed: (){
                    Get.toNamed(Routes.INSCRIPTION_FORM, arguments: controller.isRevendor.value ? revendeur?.id : agree?.id);
                  },
                  blockButton: true,
                  shape: GFButtonShape.pills,
                  color: const Color.fromRGBO(255, 118, 26, 1),
                  child: HStack([
                    const FaIcon(FontAwesomeIcons.moneyBill  , color: Colors.white,),
                    15.widthBox,
                    "J'intègre les 1000 Vendeurs".text.make(),
                  ], alignment: MainAxisAlignment.center,).w(double.maxFinite),
                )
              ]).p(23).backgroundColor(Vx.white).w(double.maxFinite)
              ))
            ]).scrollVertical(),
          ),
        );
      }
    });
  }
}
