import 'package:dropdown_search/dropdown_search.dart';
import 'package:extended_phone_number_input/consts/enums.dart';
import 'package:extended_phone_number_input/phone_number_input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:millsellers/app/routes/app_pages.dart';
import 'package:millsellers/app/views/views/input_wrapper_view.dart';
import 'package:millsellers/utils/contants.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/reapform_controller.dart';

class ReapformView extends GetView<ReapformController> {
  const ReapformView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 251, 248, 1),
      body:  VStack([
        Builder(
          builder: (context)=>SafeArea(child: VStack([
              HStack([
                Container(
                  color: const Color.fromRGBO(236, 249, 242, 1),
                  child: const Icon(Icons.close, color: Vx.green500,)
                ).cornerRadius(7).onTap(Get.back),
            
                Expanded(child: "Réapprovisionnement".text.color(const Color.fromRGBO(41, 156, 22, 1)).size(22).make().centered()),
              ], alignment: MainAxisAlignment.spaceBetween, crossAlignment: CrossAxisAlignment.center).pSymmetric(h: 10).w(double.maxFinite),
              
              
              
            ], crossAlignment: CrossAxisAlignment.center,).scrollVertical().p(15),
          ),
        ),
        10.heightBox,
        Expanded(
          child: Form(
            key: controller.formKey,
            child:VStack([
              "Veuillez remplir les champs ci-dessous".text.size(12).align(TextAlign.center).color(Vx.gray700).make().centered(),
              10.heightBox,  

                VStack([
                  "Nom & prenoms (Personne à contacter)".text.make(),
                  7.heightBox,
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    color: const Color.fromRGBO(243, 243, 243, 1),
                    child: TextFormField(
                      controller: controller.nameCtrl,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(FontAwesomeIcons.user, size: 13,),
                        border: InputBorder.none,
                      ),
                    ),
                  ).cornerRadius(7)
                ]),
                10.heightBox,
                VStack([
                  "Pays".text.align(TextAlign.left).make(),
                  5.heightBox,
                  InputWrapperView(
                    child: DropdownSearch<String>(
                      filterFn: (item, filter) => item.contains(filter),
                      items: (value, leadProps)=> kCountries.valuesList(),
                      onChanged: (item)=>{
                        controller.countryCtrl.text = item ?? "Côte d'Ivoire"
                      },
                      mode: Mode.form,
                      decoratorProps: DropDownDecoratorProps(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                      popupProps: PopupProps.menu(
                        showSelectedItems: true,
                      ),
                    ),
                  ),
                ]),
                10.heightBox,
                VStack([
                  "Ville".text.make(),
                  7.heightBox,
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    color: const Color.fromRGBO(243, 243, 243, 1),
                    child: TextFormField(
                      controller: controller.villeCtrl,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(FontAwesomeIcons.building, size: 13,),
                        border: InputBorder.none,
                      ),
                    ),
                  ).cornerRadius(7)
                ]),
                10.heightBox,
                VStack([
                  "Adresse".text.make(),
                  7.heightBox,
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    color: const Color.fromRGBO(243, 243, 243, 1),
                    child: TextFormField(
                      controller: controller.addressCtrl,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(FontAwesomeIcons.mapLocation, size: 13,),
                        border: InputBorder.none,
                      ),
                    ),
                  ).cornerRadius(7)
                ]),
                10.heightBox,
                VStack([
                  "Numero de téléphone".text.make(),
                  7.heightBox,
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    color: const Color.fromRGBO(243, 243, 243, 1),
                    child:  PhoneNumberInput(
                      onChanged: (value)=>{
                        controller.phoneCTrl.text = value
                      },
                      errorText: "Numéro de téléphone incorrecte",
                      border: InputBorder.none,
                      locale: 'fr',
                      initialCountry: 'CI',
                      countryListMode: CountryListMode.dialog,
                      contactsPickerPosition: ContactsPickerPosition.suffix,
                    ),
                  ).cornerRadius(15)
                ]),
                10.heightBox,
                HStack([
                  VStack([
                    "Quantité".text.make(),
                    InputWrapperView(
                      child: Obx(()=>TextFormField(
                        controller: controller.quantityCtrl,
                        onChanged: (value)=>{
                          controller.unite.value = int.parse(value)
                        },
                        decoration:  InputDecoration(
                          border: InputBorder.none,
                          hintText: "${controller.unite.value}",
                        ),
                        keyboardType: TextInputType.number,
                      )),
                    )
                  ]).w(Get.width / 12  * 3),
                  10.widthBox,
                  VStack([
                    "Coût".text.make(),
                    InputWrapperView(
                      child: Obx(()=>TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "${ (controller.price.value  * controller.unite.value).toString().numCurrency} FCFA",
                        ),
                        keyboardType: TextInputType.number,
                      )),
                    )
                  ]).expand(flex: 1),
                ]),
                40.heightBox,
                GFButton(
                  icon: Obx(()=> controller.loading() ? const CircularProgressIndicator(color: Color.fromRGBO(35, 135, 19, 1),strokeWidth: 2,).p(5) : const SizedBox()),
                  hoverElevation: 0,
                  type: GFButtonType.outline,
                  size: GFSize.LARGE,
                  onPressed: controller.submit,
                  blockButton: true,
                  shape: GFButtonShape.pills,
                  color: const Color.fromRGBO(35, 135, 19, 1),
                  child: "Payer maintenant".text.make(),
                )
            ]).p(15).scrollVertical(),
          )
        )

      ]),
    );
  }

  void showBottomSheet(){

    Get.bottomSheet(VStack([
      HStack([
        Container(
            padding: const EdgeInsets.all(3),
            color: Colors.white,
            child: const FaIcon(Icons.close, color: Vx.gray700,)
        ).cornerRadius(7).onTap(Get.back),

      ], alignment: MainAxisAlignment.end,).pSymmetric(h: 10).w(double.maxFinite),
      10.heightBox,
      Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: HStack([
          InkWell(
            child: Image.asset("assets/images/wave.png", width: 100,).card.make(),
          ),
          15.widthBox,
          InkWell(
            onTap: ()=>{Get.offAndToNamed(Routes.OFFPAYMENT)},
            child: VStack([
              Image.asset("assets/images/offline.png", width: 50,),
              "Paiement hors-ligne".text.size(8).color(Vx.orange500).make()
            ], alignment: MainAxisAlignment.center, crossAlignment: CrossAxisAlignment.center,).p(5)
                .card.make(),
          ),
        ], alignment: MainAxisAlignment.center, crossAlignment: CrossAxisAlignment.center,).p(15),
      ).cornerRadius(10).box.customRounded(const BorderRadiusDirectional.vertical(top: Radius.circular(30))).make().w(double.maxFinite)
    ]));
  }
}
