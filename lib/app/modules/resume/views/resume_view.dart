import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:millsellers/app/routes/app_pages.dart';
import 'package:millsellers/app/views/views/input_wrapper_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:millsellers/app/data/models/product_model.dart';
import '../controllers/resume_controller.dart';

class ResumeView extends GetView<ResumeController> {
  const ResumeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: VStack([
      Builder(
        builder: (BuildContext context) => VStack([
          HStack(
            [
              BounceInLeft(
                  child: Image.asset(
                "assets/images/m.png",
                height: 18,
                width: 20,
              )
                      .p(10)
                      .card
                      .elevation(0)
                      .color(const Color.fromRGBO(236, 249, 242, 1))
                      .make()
                      .onTap(Scaffold.of(context).openDrawer)),
              BounceInRight(
                  child: Image.asset(
                "assets/images/avatar.png",
                height: 50,
              )).onTap(() {
                
                Get.toNamed(Routes.PROFILE);
              }),
            ],
            alignment: MainAxisAlignment.spaceBetween,
            crossAlignment: CrossAxisAlignment.center,
          ).w(double.maxFinite),
        ]).p(15),
      ),
      Expanded(
        child: LiquidPullToRefresh(
          key: controller.pullKey,
          backgroundColor: const Color.fromRGBO(241, 138, 45, 0.13),
          color: const Color.fromARGB(255, 255, 255, 255),
          onRefresh: controller.refresh,
          child: VStack([
            VStack([
              "${controller.iresource.seller?.name}"
                  .text
                  .size(18)
                  .bold
                  .make(),
              "Bienvenue dans 1000 Vendeurs".text.size(18).gray500.make(),
            ]).px(10),
            10.heightBox,
            FadeIn(
              child: HStack(
                [
                  VStack([
                        "Solde 1000 Vendeurs".text.size(16).make(),
                        "Compte Principale".text.size(12).gray500.make(),
                        5.heightBox,
                        Obx(()=>"${controller.balance.value?.numCurrency} XOF"
                            .text
                            .size(21)
                            .bold
                            .make()),
                      ]),
                  VStack(
                    [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color.fromRGBO(241, 138, 45, 0.13),
                        ),
                        child: "Recharger le wallet"
                            .text
                            .size(12)
                            .color(const Color.fromRGBO(241, 138, 45, 1))
                            .make(),
                      ).onTap(showBottomSheet),
                      5.heightBox,
                      Image.asset(
                        "assets/images/wallet_icon.png",
                        height: 67,
                      )
                    ],
                    alignment: MainAxisAlignment.spaceBetween,
                    crossAlignment: CrossAxisAlignment.center,
                  )
                ],
                crossAlignment: CrossAxisAlignment.start,
                alignment: MainAxisAlignment.spaceBetween,
              )
                  .p(15)
                  .card
                  .elevation(0)
                  .customRounded(BorderRadius.circular(7))
                  .color(const Color.fromRGBO(234, 170, 115, 0.20))
                  .make()
                  .w(double.maxFinite),
            ),
            10.heightBox,
            InputWrapperView(
              child: DropdownButtonFormField(
                isExpanded: false,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                borderRadius: BorderRadius.circular(5),
                decoration: const InputDecoration(
                    fillColor: Color.fromRGBO(243, 243, 243, 1),
                    border: InputBorder.none),
                style: const TextStyle(color: Vx.gray500),
                value: "Ce mois-ci",
                items: [
                  "Aujourd'hui",
                  "Cette semaine",
                  "Ce mois-ci",
                  "Cette année",
                ]
                    .map((String value) => DropdownMenuItem(
                          value: value,
                          child: value.text.make(),
                        ))
                    .toList(),
                onChanged: (item) => {},
              ),
            ),
            10.heightBox,
            HStack(
              [
                Container(
                  padding: const EdgeInsets.all(10),
                  width: Get.width / 12 * 5.2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: const Color.fromRGBO(249, 249, 249, 1)),
                  child: HStack(
                    [
                      Image.asset(
                        "assets/images/metric_icon.png",
                        height: 50,
                      ),
                      15.widthBox,
                      Obx(() => VStack([
                            "${controller.resource.value.stock ?? 0}"
                                .text
                                .size(18)
                                .make(),
                            "En stock".text.size(12).make()
                          ]))
                    ],
                    crossAlignment: CrossAxisAlignment.center,
                  ),
                ).onTap(() => controller.resource.value.setStock()),
                Container(
                  padding: const EdgeInsets.all(10),
                  width: Get.width / 12 * 5.2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: const Color.fromRGBO(249, 249, 249, 1)),
                  child: HStack(
                    [
                      Image.asset(
                        "assets/images/metric_icon.png",
                        height: 50,
                      ),
                      15.widthBox,
                      Obx(() => VStack([
                            "${controller.resource.value.ventes ?? 0}"
                                .text
                                .size(18)
                                .make(),
                            "Ventes".text.size(12).make()
                          ]))
                    ],
                    crossAlignment: CrossAxisAlignment.center,
                  ),
                ).onTap(() => controller.resource.value.setVentes())
              ],
              alignment: MainAxisAlignment.spaceBetween,
            ).w(double.maxFinite),
            15.heightBox,
            InkWell(
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: const Color.fromRGBO(236, 249, 242, 1)),
                child: HStack(
                  [
                    Image.asset(
                      "assets/images/parrain.png",
                      height: 19,
                    ),
                    "Réapprovisionner mon stock".text.size(14).make(),
                    const Icon(
                      Icons.arrow_right_alt_rounded,
                      color: Vx.green700,
                    )
                  ],
                  alignment: MainAxisAlignment.spaceBetween,
                ),
              ),
              onTap: () => Get.toNamed(Routes.PRODUCT_LIST,
                  arguments: {'next_route': Routes.REAPFORM}),
            ),
            7.heightBox,
            InkWell(
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: const Color.fromRGBO(236, 249, 242, 1)),
                child: HStack(
                  [
                    Image.asset(
                      "assets/images/reap.png",
                      height: 19,
                    ),
                    "Parrainer un nouveau vendeur".text.size(14).make(),
                    const Icon(
                      Icons.arrow_right_alt_rounded,
                      color: Vx.green700,
                    )
                  ],
                  alignment: MainAxisAlignment.spaceBetween,
                ),
              ),
            
                onTap: () async => await Share.share(
                    "Debuter plus facilement ave l'application 100 vendeurs en vous inscrivant avec le code de parrainage suivant ${controller.resource?.value.referral}",
                    
                    subject:
                    'Debuter plus facilement ave l\'application 100 vendeurs https://example.com',
                    ),
                    
            ),
            7.heightBox,
            InkWell(
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: const Color.fromRGBO(236, 249, 242, 1)),
                child: HStack(
                  [
                    Image.asset(
                      "assets/images/reap.png",
                      height: 19,
                    ),
                    "Devenir premium".text.size(14).make(),
                    const Icon(
                      Icons.arrow_right_alt_rounded,
                      color: Vx.green700,
                    )
                  ],
                  alignment: MainAxisAlignment.spaceBetween,
                ),
              ),
            
                onTap: () => {},
                    
            ),
            20.heightBox,
            getProductsWidget(context),
            20.heightBox,
            getChallengeWidget(context),
          ]).scrollVertical(),
        ).p(15),
      )
    ]));
  }

  void showBottomSheet() {
    Get.bottomSheet(VStack([
      HStack(
        [
          Container(
              padding: const EdgeInsets.all(3),
              color: Colors.white,
              child: const FaIcon(
                Icons.close,
                color: Vx.gray700,
              )).cornerRadius(7).onTap(Get.back),
        ],
        alignment: MainAxisAlignment.end,
      ).pSymmetric(h: 10).w(double.maxFinite),
      10.heightBox,
      Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: HStack(
          [
            InkWell(
              child: Image.asset(
                "assets/images/wave.png",
                width: 100,
              )
                  .card
                  .make()
                  .onTap(() => controller.launchWavePayment(amount: 100)),
            ),
            15.widthBox,
            InkWell(
              onTap: () => {Get.offAndToNamed(Routes.RECHARGE)},
              child: VStack(
                [
                  Image.asset(
                    "assets/images/offline.png",
                    width: 50,
                  ),
                  "Paiement hors-ligne".text.size(8).color(Vx.orange500).make()
                ],
                alignment: MainAxisAlignment.center,
                crossAlignment: CrossAxisAlignment.center,
              ).p(5).card.make(),
            ),
          ],
          alignment: MainAxisAlignment.center,
          crossAlignment: CrossAxisAlignment.center,
        ).p(15),
      )
          .cornerRadius(10)
          .box
          .customRounded(
              const BorderRadiusDirectional.vertical(top: Radius.circular(30)))
          .make()
          .w(double.maxFinite)
    ]));
  }

  Widget getChallengeWidget(BuildContext context) {
    return VStack([
      "Challenges en cours".text.bold.size(17).make(),
      10.heightBox,
      HStack([
        SizedBox(
          width: Get.width / 12 * 5,
          height: 200,
          child: VStack([]).card.white.elevation(0).make(),
        ).card.color(const Color.fromRGBO(236, 249, 242, 1)).make()
      ]).scrollHorizontal(),
    ]).p(10);
  }

  Widget getProductsWidget(BuildContext context) {
    return VStack([
      "Principals produits".text.bold.size(17).make(),
      10.heightBox,
      Obx(() => controller.products.isEmpty
          ? const CircularProgressIndicator(color: Vx.green700)
                          .centered()
          : HStack(
              controller.productLoading.value
                  ? [
                      const CircularProgressIndicator(color: Vx.green700)
                          .centered()
                    ]
                  : controller.products
                      .map((product) => productWidget(product))
                      .toList(),
            ).scrollHorizontal())
    ]).p(10);
  }

  Widget productWidget(Product product) {
    return InkWell(
      child: SizedBox(
        width: Get.width / 12 * 5,
        height: 200,
        child: VStack([
          product.images?.isNotEmpty ?? false
            ? Image.network(
                product.images!.first['link'] ?? '',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image),
              )
            : const Icon(Icons.image),
          "${product.name}".text.bold.make(),
          "${product.quantity}".text.make(),
        ], alignment: MainAxisAlignment.center, crossAlignment: CrossAxisAlignment.center,),
      ).card.white.make(),
     onTap: () => Get.toNamed(Routes.PRODUCT_DETAILS, arguments: {'product': product}),
    );
  }
}
