import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:millsellers/app/modules/ProductList/product_list_controller.dart';
import 'package:millsellers/app/data/models/product_model.dart';
import 'package:millsellers/app/routes/app_pages.dart';



class ProductListView extends GetView<ProductListController> {
  const ProductListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 251, 248, 1),
      body: Column(
        children: [
          Builder(builder: (context)=>StandartHeader(context)).w(double.maxFinite),


          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher un produit...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                // TODO: Implémenter la recherche
              },
            ),
          ),
          // Liste des produits
          Expanded(
            child: Obx(
              () => controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : LiquidPullToRefresh(
                      onRefresh: controller.refreshProducts,
                      showChildOpacityTransition: false,
                      child: ListView.builder(
                        itemCount: controller.products.length,
                        itemBuilder: (context, index) {
                          final Product product = controller.products[index];
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
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Réf: ${product.description ?? 'N/A'}', style: TextStyle(fontSize: 14, color: Vx.gray600),),
                                  
                                ],
                              ),
                              trailing: Text(
                                '${product.price?.numCurrency ?? '0'} FCFA',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onTap: () {
                                Get.toNamed(Routes.NEWSELL, arguments: {"product_d": product.id, "product_name": product.name});
                              },
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }


  Widget StandartHeader(BuildContext context){
    return HStack(
          [
            Container(
                  color: Colors.white,
                  child: const Icon(Icons.close, color: Vx.gray700,)
              ).cornerRadius(7).onTap(Get.back),
            'Liste des Produits'.text.align(TextAlign.center).size(18).color(Color.fromRGBO(25, 158, 70, 1)).make().expand(flex: 1)
          ],
          alignment: MainAxisAlignment.spaceBetween,
          crossAlignment: CrossAxisAlignment.center,
        ).w(double.maxFinite);
  }
}