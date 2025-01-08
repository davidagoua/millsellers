import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:millsellers/app/data/models/order.dart';
import 'package:millsellers/app/data/models/sale_model.dart';
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
                          .map((order) => _commandCard(order))
                          .toList())
                      .scrollVertical()
                  : VStack(["Aucune commande en cours".text.make()])
                      .centered()),
            ),
          )
        ]).p(15),
      ),
    );
  }

  Widget _commandCard(Order order) {
    return Container(
      child: VStack([
        HStack([
          Text(
            order.product_name ?? '',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(),
          Text(
            ' x ${order.quantity}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ]).p12().color(Vx.white),

        // Order Process
        VStack([
          Container(
              child: Row(
            children: [
              Icon(Icons.access_time, size: 16, color: Colors.grey),
              10.widthBox,
              Text(
                'Date de commande',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              Spacer(),
              Text(
                '${DateTime.parse(order.created_at!).day} ${ _getMonthName(DateTime.parse(order.created_at!).month) } ${DateTime.parse(order.created_at!).year}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ],
          ).p12()),
          Row(
            children: [
              Icon(Icons.location_on, size: 16, color: Colors.grey),
              10.widthBox,
              Text(
                'Destination',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              Spacer(),
              Text(
                '${order.place?.country}, ${order.place?.city}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ],
          ).p12(),
          "${_getStatusText(order.status!)}".text.white.make().centered().p(1).card.elevation(0).transparent.make().color(_getStatusColor(order.status!)).w(double.maxFinite)
        ]),
      ]),
    ).card.white.make();
  }

  String _getMonthName(int month) {
    const months = [
      'Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin',
      'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'
    ];
    return months[month - 1];
  }


  Color _getStatusColor(String status) {
    switch (status) {
      
      case "pending":
        return Colors.blue[600]!;
      case "delivered":
        return Colors.green[600]!;
      case "canceled":
        return Colors.red[600]!;
      default:
        return Colors.green[600]!;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case "pending":
        return "En cours";
      case "delivered":
        return "Livrée";
      case "canceled":
        return "Annulée";
      default:
        return "En cours";
    }
  } 
}
