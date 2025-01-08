import 'package:dropdown_search/dropdown_search.dart';
import 'package:extended_phone_number_input/consts/enums.dart';
import 'package:extended_phone_number_input/phone_number_input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:millsellers/app/views/views/input_wrapper_view.dart';
import 'package:millsellers/utils/contants.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/inscription_form_controller.dart';

class InscriptionFormView extends GetView<InscriptionFormController> {
  const InscriptionFormView({super.key});
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 251, 248, 1),
      body:  Builder(
        builder: (context)=>SafeArea(child: Form(
          key: controller.formKey,
          child: VStack([
            HStack([
              Container(
                padding: const EdgeInsets.all(5),
                color: Colors.white,
                child: const Icon(Icons.close, color: Vx.gray700,)
              ).cornerRadius(7).onTap(Get.back),
            ], alignment: MainAxisAlignment.start,).pSymmetric(h: 10).w(double.maxFinite),
            10.heightBox,
            "Formulaire d'adhésion".text.color(const Color.fromRGBO(41, 156, 22, 1)).size(22).make(),
            "Inscrivez vous maintenant et changeons le monde ensemble !".text.size(10).align(TextAlign.center).color(Vx.gray700).make(),
            15.heightBox,

            VStack([
              "Nom & prenoms".text.make(),
              7.heightBox,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                color: const Color.fromRGBO(243, 243, 243, 1),
                child: TextFormField(
                  validator: controller.required,
                  controller: controller.nomCtrl,
                 decoration: const InputDecoration(
                   prefixIcon: Icon(FontAwesomeIcons.user, size: 13,),
                   border: InputBorder.none,
                 ),
                ),
              ).cornerRadius(7)
            ]),
            15.heightBox,
            Obx(()=>VStack([
              "Genre".text.make(),
              7.heightBox,
              ListTile(
                title: Text('Homme'),
                leading: Radio(
                  value: 'male',
                  groupValue: controller.gender.value,
                  onChanged: (value) {
                    controller.gender.value = value!;
                  },
                ),
              ),
              ListTile(
                title: Text('Femme'),
                leading: Radio(
                  value: 'female',
                  groupValue: controller.gender.value,
                  onChanged: (value) {
                    controller.gender.value = value!;
                  },
                ),
              ),
            ])),

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
                  validator: controller.required,
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
                  validator: controller.required,
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
              "Profession".text.make(),
              7.heightBox,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                color: const Color.fromRGBO(243, 243, 243, 1),
                child: TextFormField(
                  validator: controller.required,
                  controller: controller.professionCtrl,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(FontAwesomeIcons.briefcase, size: 13,),
                    border: InputBorder.none,
                  ),
                ),
              ).cornerRadius(7)
            ]),
            10.heightBox,

            VStack([
              "Numéro de téléphone".text.make(),
              7.heightBox,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                color: const Color.fromRGBO(243, 243, 243, 1),
                child:  PhoneNumberInput(
                  onChanged: (value)=>{
                    controller.contactCtrl.text = value
                  },
                  pickContactIcon: const SizedBox(),
                  errorText: "Numéro de téléphone incorrecte",
                  border: InputBorder.none,
                  initialCountry: 'CI',
                  countryListMode: CountryListMode.dialog,
                  contactsPickerPosition: ContactsPickerPosition.suffix,
                ),
              ).cornerRadius(15)
            ]),
            10.heightBox,
            VStack([
              "Email".text.make(),
              7.heightBox,

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                color: const Color.fromRGBO(243, 243, 243, 1),
                child: TextFormField(
                  validator: controller.required,
                  controller: controller.emailCtrl,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(FontAwesomeIcons.at, size: 13,),
                    border: InputBorder.none,
                  ),
                ),
              ).cornerRadius(7)
            ]),
            10.heightBox,
            VStack([
              "Mot de passe".text.make(),
              7.heightBox,
              Obx(()=>Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                color: const Color.fromRGBO(243, 243, 243, 1),
                child: TextFormField(
                  validator: controller.required,
                  controller: controller.passwordCtrl,
                  obscureText: controller.showPassword(),
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: const Icon(FontAwesomeIcons.lock, size: 15,),
                    suffixIcon: InkWell(child: const Icon(Icons.remove_red_eye, size: 15, color: Colors.green,), onTap: ()=> controller.showPassword.toggle(),),
                  ),
                ),
              )).cornerRadius(15),
            ]),

            if (controller.pack_id != null)  VStack([
              30.heightBox,
              HStack([
                Container(height: 2, width: 70, color: Vx.gray700,),
                "Informations boutique".text.make().marginSymmetric(horizontal: 15),
                Container(height: 2, width: 70, color: Vx.gray700,),
              ]),

              VStack([
                20.heightBox,
                "Pays".text.align(TextAlign.left).make(),
                5.heightBox,
                InputWrapperView(
                  child: DropdownButtonFormField(
                    isExpanded: false,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    borderRadius: BorderRadius.circular(5),
                    decoration: const InputDecoration(
                        fillColor: Color.fromRGBO(243, 243, 243, 1),
                        border: InputBorder.none
                    ),
                    isDense: true,
                    items: kCountries.valuesList().map((String value)=> DropdownMenuItem(value: value, child: value.text.make(),)).toList(),
                    onChanged: (item)=>{
                      controller.ShopPaysCtrl.text = item ?? "Côte d'ivoire"
                    },

                  ),
                ),

                20.heightBox,
                "Ville".text.make(),
                5.heightBox,
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  color: const Color.fromRGBO(243, 243, 243, 1),
                  child: TextFormField(
                    validator: controller.required,
                    controller: controller.shopVilleCtrl,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(FontAwesomeIcons.building, size: 13,),
                      border: InputBorder.none,
                    ),
                  ),
                ).cornerRadius(7),

                20.heightBox,
                "Adresse".text.make(),
                5.heightBox,
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  color: const Color.fromRGBO(243, 243, 243, 1),
                  child: TextFormField(
                    validator: controller.required,
                    controller: controller.shopAddresseCtrl,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(FontAwesomeIcons.building, size: 13,),
                      border: InputBorder.none,
                    ),
                  ),
                ).cornerRadius(7),


              ]),
            ]),

            30.heightBox,
            VStack([
              HStack([
                Container(height: 2, width: 70, color: Vx.gray700,),
                "Informations de livraison".text.make().marginSymmetric(horizontal: 15),
                Container(height: 2, width: 70, color: Vx.gray700,),
              ]),

              20.heightBox,
              VStack([
                "Taille Tshirt".text.align(TextAlign.left).make(),
                5.heightBox,
                InputWrapperView(
                  child: DropdownButtonFormField(
                    isExpanded: false,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    borderRadius: BorderRadius.circular(5),
                    decoration: const InputDecoration(
                        fillColor: Color.fromRGBO(243, 243, 243, 1),
                        border: InputBorder.none
                    ),
                    isDense: true,
                    items: [
                      "S",
                      "M",
                      "L",
                      "XL",
                      "XXL",
                    ].map((String value)=> DropdownMenuItem(value: value, child: value.text.make(),)).toList(),
                    onChanged: (item)=>{
                      controller.shopSizeCtrl.text = item ?? "Small"
                    },


                  ),
                ),
              ]),

              20.heightBox,
              VStack([
                "Lieu de livraison".text.make(),
                5.heightBox,
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  color: const Color.fromRGBO(243, 243, 243, 1),
                  child: TextFormField(
                    controller: controller.shopDeliverAtCtrl,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(FontAwesomeIcons.locationDot, size: 13,),
                      border: InputBorder.none,
                    ),
                  ),
                ).cornerRadius(7),
              ]),

              20.heightBox,
              VStack([
                "Personne à contacter".text.make(),
                5.heightBox,
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  color: const Color.fromRGBO(243, 243, 243, 1),
                  child: TextFormField(
                    // controller: controller.shopDeliverAtCtrl,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(FontAwesomeIcons.userTie, size: 13,),
                      border: InputBorder.none,
                    ),
                  ),
                ).cornerRadius(7),
              ]),

              20.heightBox,
              VStack([
                "Numero de Personne à contacter".text.make(),
                5.heightBox,
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  color: const Color.fromRGBO(243, 243, 243, 1),
                  child: PhoneNumberInput(
                    onChanged: (value){
                      controller.shopPhoneCtrl.text = value;
                    },
                    pickContactIcon: const SizedBox(),
                    errorText: "Numéro de téléphone incorrecte",
                    border: InputBorder.none,
                    initialCountry: 'CI',
                    countryListMode: CountryListMode.dialog,
                    contactsPickerPosition: ContactsPickerPosition.suffix,
                  ),
                ).cornerRadius(7),
              ]),

              10.heightBox,
              Obx(()=>VStack([
                HStack([
                "J'ai un code de parrainage".text.make(),
                  GFCheckbox(
                    size: GFSize.SMALL,
                    activeBgColor: Vx.green500,
                    onChanged: controller.showReferal.call,
                    value: controller.showReferal(),
                  ),
                ], alignment: MainAxisAlignment.spaceBetween,).w(double.maxFinite),
                10.heightBox,
                if (controller.showReferal.value)  VStack([
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    color: const Color.fromRGBO(243, 243, 243, 1),
                    child: TextFormField(
                      controller: controller.referal_id,
                      decoration: const InputDecoration(
                        hintText: "Code de pairainnage",
                        border: InputBorder.none,
                      ),
                    ),
                  ).cornerRadius(7),
                ]),
              ]))

            ]),

            30.heightBox,
            GFButton(
              size: GFSize.LARGE,
              onPressed: () {
                showBottomSheet(context);
              },
              blockButton: true,
              shape: GFButtonShape.pills,
              color: const Color.fromRGBO(255, 118, 26, 1),
              child: HStack([
                "Payer les frais d'adhésion".text.make(),
                15.widthBox,
                const FaIcon(FontAwesomeIcons.moneyBill  , color: Colors.white,),
              ], alignment: MainAxisAlignment.center,).w(double.maxFinite),
            )
          ], crossAlignment: CrossAxisAlignment.center,).scrollVertical().p(23),
        )),
      ),
    );
  }

  void showBottomSheet(BuildContext context){
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
            onTap: (){
              controller.offlinePayment();
            },
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
