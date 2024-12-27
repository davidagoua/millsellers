import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:get/get.dart';
import 'package:millsellers/app/data/models/sale_model.dart';
import 'package:millsellers/utils/contants.dart';
import 'package:velocity_x/velocity_x.dart';

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

          searchAndFilterWidget(),
          20.heightBox,

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
        color: Colors.white,
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
      child: IntrinsicHeight(
        child: VStack([
          Row(
            children: [
              // Date box
              Container(
                width: 60,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    vente.product?.images?.isNotEmpty ?? false
                    ? Image.network(
                        vente.product!.images!.first['link'] ?? '',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.image),
                      )
                    : const Icon(Icons.image),
                  ],
                ),
              ).p12(),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${vente.product?.name}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          '${DateTime.parse(vente.created_at!).day}-${DateTime.parse(vente.created_at!).month}-${DateTime.parse(vente.created_at!).year}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          '${vente.customer?.place?.address}, ${vente.customer?.place?.city}, ${vente.customer?.place?.country}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              
            ],
          ),

          HStack([
            CircleAvatar(child: Icon(Icons.person, size: 15, color: Colors.white,),backgroundColor: secondaryColor,).h(30).w(30),
            10.widthBox,
            Expanded(
              child: Text('${vente.customer?.name}'),
            ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${(vente.amount! * vente.quantity!).toString().numCurrency} FCFA',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ).p12(),
          ]).p(2)
        ]),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }

  Widget searchAndFilterWidget() {
    return Container(
    );
  }
}
