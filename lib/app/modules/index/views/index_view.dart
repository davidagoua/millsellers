import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:millsellers/app/controllers/auth_controller.dart';
import 'package:millsellers/app/modules/CommandeList/views/commande_list_view.dart';
import 'package:millsellers/app/modules/Fieul/views/fieul_view.dart';
import 'package:millsellers/app/modules/resume/views/resume_view.dart';
import 'package:millsellers/app/modules/vente/views/vente_view.dart';
import 'package:millsellers/app/routes/app_pages.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:url_launcher/url_launcher.dart';

import '../controllers/index_controller.dart';

class IndexView extends GetView<IndexController> {
  const IndexView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.index.value == 0) {
          return true; // Allow the back action
        } else {
          controller.index.value = 0;
          return false; // Prevent the back action
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: Drawer(
          backgroundColor: Colors.transparent,
          child: Builder(
            builder: (context) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: VStack([
                20.heightBox,
                HStack(
                  [
                    Container(
                            padding: const EdgeInsets.all(3),
                            color: Colors.grey[200],
                            child: const FaIcon(
                              Icons.close,
                              color: Vx.gray700,
                            ))
                        .cornerRadius(7)
                        .onTap(() => Scaffold.of(context).closeDrawer()),
                  ],
                  alignment: MainAxisAlignment.start,
                ).pSymmetric(h: 10).w(double.maxFinite),
                VStack(
                  [
                    ListTile(
                      hoverColor: Colors.grey[400],
                      selectedColor: Colors.green[200],
                      leading: const Icon(
                        FontAwesomeIcons.house,
                        size: 15,
                        color: Color.fromRGBO(25, 158, 70, 1),
                      ),
                      title: "Acceuil"
                          .text
                          .color(const Color.fromRGBO(25, 158, 70, 1))
                          .make(),
                    ),
                    ListTile(
                      hoverColor: Colors.grey[400],
                      selectedColor: Colors.green[200],
                      leading: const Icon(
                        FontAwesomeIcons.book,
                        size: 15,
                        color: Color.fromRGBO(25, 158, 70, 1),
                      ),
                      title: "Nos Formations"
                          .text
                          .color(const Color.fromRGBO(25, 158, 70, 1))
                          .make()
                          .onTap(()=> launchUrl(Uri.parse("https://1000vendeurs.academy/"))),
                    ),
                    const Spacer(),
                    ListTile(
                      onTap: () {
                        final authManager = Get.find<AuthController>();
                        authManager.logOut();
                        Get.toNamed(Routes.HOME);
                      },
                      hoverColor: Colors.red[200],
                      selectedColor: Colors.grey[400],
                      leading: const Icon(
                        FontAwesomeIcons.arrowRightFromBracket,
                        size: 15,
                        color: Colors.red,
                      ),
                      title: "Se déconnecter".text.color(Colors.red).make(),
                    ).card.elevation(0).red100.roundedSM.make().px(5),
                  ],
                  alignment: MainAxisAlignment.spaceBetween,
                ).h(Get.height / 10 * 8.5)
              ]).box.color(Vx.white).rounded.make(),
            ),
          ),
        ),
        body: SafeArea(
          child: Obx(() => IndexedStack(
              index: controller.index.value,
              children: [
                ResumeView(),
                VenteView(),
                CommandeListView(),
                FieulView()
              ],
            )),
        ),
        floatingActionButton: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              tileMode: TileMode.decal,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(24, 214, 62, 1),
                Color.fromRGBO(10, 103, 7, 1),
              ],
            ),
            shape: BoxShape.circle,
          ),
          child: FloatingActionButton(
            shape: const CircleBorder(),
            onPressed: () => {Get.toNamed(Routes.PRODUCT_LIST)},
            backgroundColor: Colors.transparent,
            child: const Icon(
              Ionicons.bag_outline,
              color: Colors.white,
            ),
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        bottomNavigationBar: BottomAppBar(
            color: Colors.white,
            elevation: 7,
            shadowColor: Vx.gray500,
            height: MediaQuery.of(context).size.height / 10 * 1,
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            shape: const CircularNotchedRectangle(),
            child: Obx(() => HStack(
                  [
                    IconButton(
                      icon: Icon(
                        controller.index.value == 0
                            ? Ionicons.home
                            : Ionicons.home_outline,
                        fill: controller.index.value == 0 ? 1 : 0,
                      ),
                      onPressed: () => controller.index.value = 0,
                    ),
                    IconButton(
                      icon: FaIcon(
                        controller.index.value == 1
                            ? Ionicons.cart
                            : Ionicons.cart_outline,
                      ),
                      onPressed: () => controller.index.value = 1,
                    ),
                    IconButton(
                      icon: Icon(
                        controller.index.value == 2
                            ? Ionicons.archive
                            : Ionicons.archive_outline,
                      ),
                      onPressed: () => controller.index.value = 2,
                    ),
                    IconButton(
                      icon: FaIcon(
                        controller.index.value == 3
                            ? Ionicons.git_network
                            : Ionicons.git_network_outline,
                      ),
                      onPressed: () => controller.index.value = 3,
                    ),
                  ],
                  alignment: MainAxisAlignment.spaceAround,
                ))),
      ),
    );
  }
}
