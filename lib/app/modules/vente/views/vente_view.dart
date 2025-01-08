import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:get/get.dart';
import 'package:millsellers/app/data/models/sale_model.dart';
import 'package:millsellers/utils/contants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:ionicons/ionicons.dart';

import '../controllers/vente_controller.dart';

class VenteView extends GetView<VenteController> {
  const VenteView({Key? key}) : super(key: key);
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
              "Mes ventes"
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

          //searchAndFilterWidget(),
          //20.heightBox,

          Obx(() => controller.sales.isNotEmpty
              ? Expanded(
                  child: LiquidPullToRefresh(
                    onRefresh: controller.getVentes,
                    child: VStack(controller.sales
                            .map((sale) => venteWidget(sale))
                            .toList())
                        .scrollVertical(),
                  ).h(double.maxFinite),
                )
              : VStack(["Aucune vente réalisée".text.make()]).centered())
        ]).p(15),
      ),
    );
  }

  Widget venteWidget(Sale vente) {
    DateTime saleDate = DateTime.parse(vente.created_at!);
    String month = _getMonthName(saleDate.month);
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: VStack([
        // Header Section
        HStack([
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/profile.png"),
            radius: 20,
          ),
          10.widthBox,
          Text(
            '${vente.customer?.name}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Icon(Icons.phone, color: Colors.green).onTap(()=> launchUrl(Uri.parse('tel://${vente.customer?.phone}'))),
          10.widthBox,
          Container(child: Icon(Ionicons.logo_whatsapp, color: Colors.green)
            .onTap(()=> launchUrl(Uri.parse('https://wa.me/${vente.customer?.phone}')))
            ).card.p3.make(),
        ]).p12().color(primaryColor),

        

        // Package Information
        Container(
          child: VStack([
            HStack([
              Text(
                vente.product?.name ?? '',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              Text(
                ' x ${vente.quantity}',
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
                      'Date de vente',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    Spacer(),
                    Text(
                      '${DateTime.parse(vente.created_at!).day} ${month} ${DateTime.parse(vente.created_at!).year}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ).p12()
              ),
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
                    '${vente.customer?.place?.country}, ${vente.customer?.place?.city}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ],
              ).p12(),
            ]),
          ]),
        ).card.white.make()
      ]),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin',
      'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'
    ];
    return months[month - 1];
  }

  Widget searchAndFilterWidget() {
    return Container(
    );
  }
}
