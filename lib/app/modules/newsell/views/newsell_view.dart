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

import '../controllers/newsell_controller.dart';

class NewsellView extends GetView<NewsellController> {
  const NewsellView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 251, 248, 1),
      body:  VStack([
        Builder(
          builder: (context)=>SafeArea(child:VStack([
              HStack([
                Container(
                  color: const Color.fromRGBO(236, 249, 242, 1),
                  child: const Icon(Icons.close, color: Vx.green500,)
                ).cornerRadius(7).onTap(Get.back),
                Expanded(child: "Enregistrer une vente".text.color(const Color.fromRGBO(41, 156, 22, 1)).size(22).make().centered(),)
              ], alignment: MainAxisAlignment.start,).pSymmetric(h: 10).w(double.maxFinite),
              
              
            ], crossAlignment: CrossAxisAlignment.center,).scrollVertical().p(15),
          ),  
        ),
        10.heightBox,
        Expanded(
          child: Form(
            key: controller.formKey,
            child: VStack([
              "Veuillez remplir les champs ci-dessous".text.size(12).align(TextAlign.center).color(Vx.gray700).make(),
                15.heightBox,

                VStack([
                  "Nom & prenoms".text.make(),
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
                      items: (value, leadProps)=> kCountries.valuesList(),
                      onChanged: (item)=>{
                        controller.countryCtrl.text = item ?? "Côte d'Ivoire"
                      },
                      popupProps: PopupProps.menu(
                        showSelectedItems: true,
                        disabledItemFn: (String s) => s.startsWith('I'),
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
                        controller.contactCtrl.text = value
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
                      child: TextFormField(
                        controller: controller.uniteCtrl,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "10",
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    )
                  ]).w(Get.width / 12  * 3),
                  10.widthBox,
                  VStack([
                    "Coût".text.make(),
                    InputWrapperView(
                      child: TextFormField(
                        controller: controller.priceCtrl,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "10",
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    )
                  ]).expand(flex: 1),
                ]),
                40.heightBox,
                GFButton(
                  icon: Obx(()=> controller.loading() ? const CircularProgressIndicator(color: Color.fromRGBO(35, 135, 19, 1),strokeWidth: 2,).p(5) : const SizedBox()),
                  hoverElevation: 0,
                  type: GFButtonType.outline,
                  size: GFSize.LARGE,
                  onPressed: controller.validate,
                  blockButton: true,
                  shape: GFButtonShape.pills,
                  color: const Color.fromRGBO(35, 135, 19, 1),
                  child: "Enregistrer".text.make(),
                )
            ]).p(15).scrollVertical()
          )
        )
      ]),
    );
  }

}
