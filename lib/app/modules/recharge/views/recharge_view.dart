import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:millsellers/app/views/views/input_wrapper_view.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/recharge_controller.dart';

class RechargeView extends GetView<RechargeController> {
  const RechargeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 251, 248, 1),
      body: Builder(
          builder: (context)=>SafeArea(
              child: Form(
                key: controller.formKey,
                child: VStack([
                  HStack([
                    Container(
                        color: Colors.white,
                        child: const Icon(Icons.close, color: Vx.gray700,)
                    ).cornerRadius(7).onTap(Get.back),
                  ], alignment: MainAxisAlignment.start,).pSymmetric(h: 10).w(double.maxFinite),
                  10.heightBox,
                  "Demande de rechargement".text.color(const Color.fromRGBO(41, 156, 22, 1)).size(22).make(),
                  "Veuillez remplir les champ ci-dessous puis soumettre".text.size(10).align(TextAlign.center).color(Vx.gray700).make(),
                  30.heightBox,
                  VStack([
                    "Montant de rehargement".text.make(),
                    5.heightBox,
                    InputWrapperView(
                      child: TextFormField(
                        controller: controller.uniteCtrl,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    10.heightBox,
                    "Référence de paiement".text.make(),
                    5.heightBox,
                    InputWrapperView(child: TextFormField(
                      controller: controller.referenceCtrl,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          fillColor:  Color.fromRGBO(243, 243, 243, 1)
                      ),
                    )),
                    10.heightBox,
                    "Preuve de paiement".text.make(),
                    5.heightBox,
                    Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.symmetric(horizontal: 3,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromRGBO(243, 243, 243, 1),
                      ),
                      child: HStack([
                        Obx(()=>(controller.file.value ?? 'Joindre la preuve').text.make().expand()),
                        GFButton(
                          onPressed: () async{
                            FilePickerResult? result = await FilePicker.platform.pickFiles();

                            if (result != null) {
                              File file = File(result.files.single.path!);
                              controller.file.value = file.path;
                              print(controller.file.value);
                            } else {

                            }
                          },
                          text: "Parcourir",
                          color: Vx.white,
                          textColor: Vx.black,
                          padding: EdgeInsets.zero,
                        )
                      ]),
                    ),

                  ], crossAlignment: CrossAxisAlignment.start,),
                  10.heightBox,
                  Expanded(flex: 1,child: Container(),),
                  GFButton(
                    size: GFSize.LARGE,
                    type: GFButtonType.outline,
                    hoverElevation: 0,
                    onPressed: controller.submit,
                    blockButton: true,
                    icon: Obx(()=> controller.loading() ? const CircularProgressIndicator(color: Color.fromRGBO(35, 135, 19, 1),strokeWidth: 2,).p(5) : const SizedBox()),
                    shape: GFButtonShape.pills,
                    color: const Color.fromRGBO(35, 135, 19, 1),
                    child: HStack([
                      "Soumettre le paiement".text.make()
                    ]),
                  )
                ], crossAlignment: CrossAxisAlignment.center,).p(23),
              )
          )
      ),
    );
  }
}
