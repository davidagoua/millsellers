import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:millsellers/app/modules/ProductList/product_list_controller.dart';
import 'package:millsellers/app/data/models/product_model.dart';
import 'package:millsellers/app/routes/app_pages.dart';

import 'package:animate_do/animate_do.dart';


class ProductListView extends GetView<ProductListController> {
  const ProductListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 251, 248, 1),
      body: SafeArea(
        child: Column(
          children: [
            Builder(builder: (context)=>StandartHeader(context)).w(double.maxFinite),


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: HStack([
                TextField(
                  decoration: InputDecoration(
                    
                    hintText: 'Rechercher un produit...',
                    prefixIcon: const Icon(Icons.search),
                    border:InputBorder.none,
                  ),
                  onChanged: (value) {
                    controller.search(value);
                  },
                ).card.color(Vx.gray100).elevation(0)
                    .customRounded(BorderRadius.circular(10)).make().expand(flex: 1),
                10.widthBox,
                Icon(Icons.filter_list,color: Vx.gray700,).onTap((){
                  Get.bottomSheet(
                    Container(
                      height: Get.height / 4,
                      width: Get.width,
                      color: Colors.white,
                      child: Obx(() =>Column(
                        children: [
                          const Text("Filtres"),
                          10.heightBox,
                          HStack([
                            Text("Prix Max"),
                            Spacer(),
                            Slider(
                              secondaryTrackValue: controller.morePrice.value,
                              label: "${controller.lessPrice.value.numCurrency} XOF",
                              activeColor: Vx.green700,
                              divisions: 500,
                              min: 0,
                              max: 100000,
                              value: controller.lessPrice.value,
                              onChanged: (value) {
                                controller.lessPrice.value = value;
                              },
                            ),
                          ]),
                          5.heightBox,
                          HStack([
                            "En stock".text.make(),
                            Spacer(),
                            Switch(
                              activeColor: Vx.green700,
                              activeTrackColor: Vx.green700,
                              value: controller.isInStock.value,
                              onChanged: (value) {
                                controller.isInStock.value = value;
                              },
                            ),
                          ])
                        ],
                      ).p(20)),
                    ),
                    
                    isScrollControlled: true,
                    isDismissible: true,
                    enableDrag: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    backgroundColor: Colors.white,
                  );
                })
              ]),
            ),
            // Liste des produits
            Expanded(
              child: Obx(
                () => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator(color: Vx.green700,))
                    : LiquidPullToRefresh(
                        onRefresh: controller.refreshProducts,
                        showChildOpacityTransition: false,
                        child: ListView.builder(
                          itemCount: controller.productListFiter.length,
                          itemBuilder: (context, index) {
                            final Product product = controller.productListFiter[index];
                            return Card(
                              color: Colors.white,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 4.0,
                              ),
                              child: ListTile(
                                leading: product.images?.isNotEmpty ?? false
                                    ? Image.network(
                                        product.images!.first['link'] ?? '',
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) =>
                                            const Icon(Icons.image),
                                      )
                                    : const Icon(Icons.image),
                                title: Text(product.name ?? 'Sans nom', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                subtitle: Text(
                                  '${product.price?.numCurrency ?? '0'} XOF',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: () {
                                  Get.toNamed(controller.next_route.value, arguments: {"product_id": product.id, "product_name": product.name, "product_price": product.price});
                                },
                              ),
                            );
                          },
                        ),
                      ),
              ),
            ),
          ],
        )
      ),
    );
  }


  Widget StandartHeader(BuildContext context){
    return HStack(
            [
              BounceInLeft(
                child: Container(
                  color: const Color.fromRGBO(236, 249, 242, 1),
                  child: const Icon(Icons.close, color: Vx.green500,)
                ).cornerRadius(7).onTap(Get.back),
              ),
             
              
            ],
            alignment: MainAxisAlignment.spaceBetween,
            crossAlignment: CrossAxisAlignment.center,
          ).w(double.maxFinite).px(15).py(10);
          
  }
}
