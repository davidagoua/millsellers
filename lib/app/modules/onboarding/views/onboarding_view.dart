import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onboarding/onboarding.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../routes/app_pages.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: Vx.white,
      body:  ZStack([
        Positioned(
          top: -650,
          left: -150,
          child: Transform.rotate(
            angle: 100,
            child: VxBox(

            ).roundedLg.height(400).width(2600).color(const Color.fromRGBO(231, 245, 236, 1)).make(),
          ),
        ),
        Obx(()=>Onboarding(
          buildFooter: (context, netDragDistance, pagesLength, currentIndex, setIndex, slideDirection){

            return Container(
              padding: const EdgeInsets.only(bottom: 59, left: 40, right: 40),
              child: GFButton(
                size: GFSize.LARGE,
                onPressed: (){
                  if(currentIndex + 1 < pagesLength ){
                    setIndex(currentIndex + 1);
                  }else{
                    Get.offAllNamed(Routes.HOME);
                  }
                },
                blockButton: true,
                shape: GFButtonShape.pills,
                color: const Color.fromRGBO(41, 156, 22, 1),
                child: HStack([
                  "Découvrir 1000 vendeurs".text.make(),
                  10.widthBox,
                  const FaIcon(FontAwesomeIcons.arrowRight, color: Colors.white,)
                ], alignment: MainAxisAlignment.spaceBetween,),
              ),
            );
          },
          startIndex: controller.count(),
          onPageChanges: (a, b, c, slideDirection)=>{
            controller.count(b)
          },
          swipeableBody: [
            getPage(Image.asset("assets/images/oneboarding1.png",), "Rejoignez le réseaux 1000 vendeurs", "Rejoignez notre grande communauté et réinventons ensemble le business en ligne"),
            getPage(Image.asset("assets/images/oneboarding2.png"), "Vendez partout dans le monde", "Rejoignez notre grande communauté et réinventons ensemble le business en ligne"),
            getPage(Image.asset("assets/images/oneboarding3.png"), "Boostez votre chiffre d'affaire", "Rejoignez notre grande communauté et réinventons ensemble le business en ligne")
          ],
        ))
      ]),
    );
  }

  Widget getPage(Widget image, String title, String description){
    return Container(
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.all(52),
      child: FadeInLeft(
        child: VStack([
          Center(child: image,),
          title.text.size(25).fontWeight(FontWeight.bold).fontFamily(GoogleFonts.sourceCodePro.toString()).make(),
          10.heightBox,
          description.text.color(const Color.fromRGBO(121, 122, 116, 1)).size(12).make(),
        ]),
      ),
    );
  }
}



