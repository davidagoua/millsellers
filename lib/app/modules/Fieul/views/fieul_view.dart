import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/fieul_controller.dart';

class FieulView extends GetView<FieulController> {
  const FieulView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Builder(builder: (BuildContext context)=>VStack([
        HStack(
          [
            Image.asset("assets/images/m.png", height: 18, width: 20,)
                .p(10)
                .card
                .elevation(0)
                .color(const Color.fromRGBO(236, 249, 242, 1))
                .make()
                .onTap(Scaffold.of(context).openDrawer),
            "Mes Fieuls".text.align(TextAlign.center).size(18).color(Color.fromRGBO(25, 158, 70, 1)).make().expand(flex: 1)
          ],
          alignment: MainAxisAlignment.spaceBetween,
          crossAlignment: CrossAxisAlignment.center,
        ).w(double.maxFinite),
        10.heightBox,
      ]).p(15),),
    );
  }
}
