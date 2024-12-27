import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:millsellers/utils/contants.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/commande_list_controller.dart';

class CommandeListView extends GetView<CommandeListController> {
  
  
  
  const CommandeListView({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Builder(
        builder: (BuildContext context) => VStack([
          HStack(
            [
              Image.asset(
                "assets/images/m.png",
                height: 18,
                width: 20,
              )
                  .p(10)
                  .card
                  .elevation(0)
                  .color(const Color.fromRGBO(236, 249, 242, 1))
                  .make()
                  .onTap(Scaffold.of(context).openDrawer),
              "Mes commandes"
                  .text
                  .align(TextAlign.center)
                  .size(18)
                  .color(Color.fromRGBO(25, 158, 70, 1))
                  .make()
                  .expand(flex: 1)
            ],
            alignment: MainAxisAlignment.spaceBetween,
            crossAlignment: CrossAxisAlignment.center,
          ).w(double.maxFinite),
          10.heightBox,
          Expanded(
            child: LiquidPullToRefresh(
              onRefresh: () => controller.getOrders(),
              child: Obx(() => controller.orders.isNotEmpty
              ? VStack(controller.orders
                  .map((order) => ListTile(
                        leading: Container(
                          child: const Icon(
                              Icons.shopping_cart_checkout_outlined,
                              color: Vx.green700,
                            ),
                        ).p(5).card.color(primaryColor).elevation(0).make(),
                        title: order.name.toString().text.make(),
                        subtitle: VStack([
                          HStack([
                            Icon(Icons.location_on_outlined),
                            "${order.place?.country}, ${order.place?.city}, ${order.place?.address}".text.make()
                          ]),
                          HStack([
                            Icon(Icons.pin_outlined),
                            "${order.quantity}".text.make()
                          ]),
                        ]),
                        trailing: {
                          'pending':const Icon(
                                Icons.delivery_dining_outlined,
                                color: Vx.yellow300,
                              ),
                          'delivered':const Icon(
                                Icons.check_circle_outline,
                                color: Vx.green700,
                              ),
                        }[order.status],
                      ).card.white.make())
                  .toList())
              : VStack(["Aucune commande en cours".text.make()]).centered()),
            ),
          )
        ]).p(15),
      ),
    );
  }
}
