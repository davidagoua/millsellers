import 'package:animate_do/animate_do.dart';
import 'package:extended_phone_number_input/consts/enums.dart';
import 'package:extended_phone_number_input/phone_number_input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('homeScafold'),
      backgroundColor: const Color.fromRGBO(246, 251, 248, 1),
      drawer: showDrawer(context),
      body: Builder(
        builder: (context) =>
            SafeArea(
              child: VStack([
                /* 
                HStack([
                  Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 30,
                    child: Image.asset(
                      "assets/images/m.png", height: 18, width: 20,),
                  ).box
                      .color(const Color.fromRGBO(236, 249, 242, 1))
                      .rounded
                      .p4
                      .make()
                      .onTap(() => Scaffold.of(context).openDrawer()),
                  Container().expand(flex: 1),
                  Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 30,
                    child: const FaIcon(FontAwesomeIcons.user, size: 15,
                      color: Color.fromRGBO(25, 158, 70, 1),),
                  ).box
                      .color(const Color.fromRGBO(236, 249, 242, 1))
                      .roundedSM
                      .p4
                      .make()
                      .onTap(() => showBottomSheet(context))
                ], alignment: MainAxisAlignment.spaceBetween,).p(5),
                
                */
                
                
                VStack([

                  Image.asset("assets/images/logo.png",),

                  FadeIn(
                      child: Container(
                        alignment: Alignment.center,
                        child: const Image(
                          image: AssetImage("assets/images/familly.png",),
                          height: 250,
                          width: 400,),
                      )
                  ),
                  FadeInUp(child: ZStack([
                    const SizedBox(height: 220, width: 300,).box
                        .color(const Color.fromRGBO(226, 236, 229, 1))
                        .roundedLg
                        .make(),
                    Positioned(top: 10, child: const SizedBox(
                      height: 220, width: 300,).box
                        .color(const Color.fromRGBO(226, 226, 226, 1))
                        .roundedLg
                        .make()),
                    Positioned(top: 20, child: Container(
                        height: 220, width: 300,
                        padding: const EdgeInsets.all(15),
                        child: VStack([
                          "La communauté 1000 Vendeurs".text.fontWeight(
                              FontWeight.bold).make(),
                          5.heightBox,
                          "1000 VENDEURS est une communauté d'entrepreneur mise en place pour aider, former et accompagner les personnes qui souhaitent lancer un Business ou avoir une seconde source de revenus avec un petit budget.Elle est présente dans 17 pays et comptes plus de 1 000 MEMBRES.".text.size(12).make()
                        ], crossAlignment: CrossAxisAlignment.center)).box
                        .color(Colors.white)
                        .roundedLg
                        .make()),
                  ])),
                  30.heightBox,
                  FadeInUp(child: GFButton(
                    size: GFSize.LARGE,
                    onPressed: () {
                      Get.toNamed(Routes.FIRST_PRODUCT);
                    },
                    blockButton: true,
                    shape: GFButtonShape.pills,
                    color: const Color.fromRGBO(255, 118, 26, 1),
                    child: "Rejoindre la communauté".text.make(),
                  )),
                  10.heightBox,
                  FadeInUp(child: GFButton(
                    size: GFSize.LARGE,
                    onPressed: () => showBottomSheet(context),
                    blockButton: true,
                    shape: GFButtonShape.pills,
                    color: const Color.fromRGBO(41, 156, 22, 1),
                    child: "Se connecter".text.make(),
                  )),
                  5.heightBox,
                  "Termes et conditions".text
                      .color(const Color.fromRGBO(25, 158, 70, 1))
                      .underline
                      .textStyle(const TextStyle(decorationColor: Colors.green))
                      .make(),
                      //.onTap(() => Share)
                  20.heightBox,
                ], alignment: MainAxisAlignment.end,
                  crossAlignment: CrossAxisAlignment.center,)
              ]),
            ).scrollVertical(),
      ),
    );
  }

  void showBottomSheet(BuildContext context) {
    var controller = Get.find<HomeController>();

    Get.bottomSheet(VStack([
      HStack([
        Container(
            padding: const EdgeInsets.all(3),
            color: Colors.white,
            child: const FaIcon(Icons.close, color: Vx.gray700,)
        ).cornerRadius(7).onTap(Get.back),

      ], alignment: MainAxisAlignment.end,).pSymmetric(h: 10).w(
          double.maxFinite),
      10.heightBox,
      Container(
        color: Colors.white,
        child: VStack([
          "Se connecter".text.bold.size(18).make(),
          "Veuillez remplir les champs ci-dessous".text.size(12).make(),
          20.heightBox,

          15.heightBox,
          Form(
            key: controller.formKey,
            child: VStack([
            VStack([
                "Email".text.make(),
                7.heightBox,
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  color: const Color.fromRGBO(243, 243, 243, 1),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Ce champ est obligatoire";
                      } else if (!value.isEmail) {
                        return "L'email est invalide";
                      }
                      return null;
                    },
                    controller: controller.contactCtrl,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(FontAwesomeIcons.at, size: 13,),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ).cornerRadius(15)
              ]),
              15.heightBox,
              VStack([
                "Mot de passe".text.make(),
                7.heightBox,
                Obx(() =>
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      color: const Color.fromRGBO(243, 243, 243, 1),
                      child: TextFormField(
                        controller: controller.password,
                        obscureText: controller.showPassword(),
                        obscuringCharacter: '*',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Ce champ est obligatoire";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: const Icon(
                            FontAwesomeIcons.lock, size: 15,),
                          suffixIcon: InkWell(child: const Icon(
                            Icons.remove_red_eye, size: 15,
                            color: Colors.green,),
                            onTap: () => controller.showPassword.toggle(),),
                        ),
                      ),
                    )).cornerRadius(15),

              ]),
              15.heightBox,
              GFButton(
                
                size: GFSize.LARGE,
                onPressed: () {
                  controller.submit();
                },
                icon: Obx(() =>
                controller.loading()
                    ? const CircularProgressIndicator(
                  color: Vx.white, strokeWidth: 2,).p(3)
                    : const SizedBox()),
                blockButton: true,
                shape: GFButtonShape.pills,
                color: const Color.fromRGBO(41, 156, 22, 1),
                child: HStack([
                  "Se connecter".text.make(),
                  10.widthBox,
                  const FaIcon(
                    FontAwesomeIcons.arrowRight, color: Colors.white,)
                ], alignment: MainAxisAlignment.spaceBetween,),
              )
            ], crossAlignment: CrossAxisAlignment.center,),
          )
        ]).p(15),
      )
          .cornerRadius(10)
          .box
          .customRounded(
          const BorderRadiusDirectional.vertical(top: Radius.circular(30)))
          .make()
          .w(double.maxFinite)
    ]).scrollVertical());
  }

  Widget showDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      child: Builder(
        builder: (context) =>
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: VStack([
                20.heightBox,
                HStack([
                  Container(
                      padding: const EdgeInsets.all(3),
                      color: Colors.grey[100],
                      child: const FaIcon(Icons.close, color: Vx.gray700,)
                  ).cornerRadius(7).onTap(() =>
                      Scaffold.of(context)
                          .closeDrawer()),

                ], alignment: MainAxisAlignment.start,).pSymmetric(h: 10).w(
                    double.maxFinite),
                VStack([
                  ListTile(
                    onTap: () => showBottomSheet(context),
                    hoverColor: Colors.grey[400],
                    selectedColor: Colors.green[200],
                    leading: const Icon(
                      FontAwesomeIcons.user, size: 15, color: Color.fromRGBO(25, 158, 70, 1),),
                    title: "Se connecter".text.color(Color.fromRGBO(25, 158, 70, 1)).make(),
                  ),
                  ListTile(
                    hoverColor: Colors.grey[400],
                    selectedColor: Colors.green[200],
                    leading: const Icon(
                      FontAwesomeIcons.bell, size: 15, color: Color.fromRGBO(25, 158, 70, 1),),
                    title: "informations".text.color(Color.fromRGBO(25, 158, 70, 1)).make(),
                  ),
                ]),
                const Spacer(),
                ListTile(
                  hoverColor: Colors.grey[400],
                  selectedColor: Colors.green[200],
                  leading: const Icon(
                    FontAwesomeIcons.bell, size: 15, color: Color.fromRGBO(25, 158, 70, 1),),
                  title: "informations".text.color(Color.fromRGBO(25, 158, 70, 1)).make(),
                ),
              ]).box
                  .color(Vx.white)
                  .rounded
                  .make(),
            ),
      ),
    );
  }
}
