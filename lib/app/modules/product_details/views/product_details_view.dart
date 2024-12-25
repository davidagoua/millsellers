import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:millsellers/app/routes/app_pages.dart';
import 'package:millsellers/utils/contants.dart';
import 'package:velocity_x/velocity_x.dart';
import '../controllers/product_details_controller.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  const ProductDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Container(
          
          child: const Icon(Icons.close, color: Vx.green500,)
        ).cornerRadius(7).onTap(Get.back),
        actions: [
          ElevatedButton(
              onPressed: () => { Get.toNamed(Routes.REAPFORM, arguments: {'product_id': controller.product.value?.id, 'product_name': controller.product.value?.name, 'product_price': controller.product.value?.price})}, // Implement add to cart functionality
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 16,
                ),
              ),
              child: const Text(
                '+ Stock',
                style: TextStyle(color: Vx.green700),
              ),
            ),
        ],
        title: const Text('Details Produit'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Title
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${controller.product.value?.name}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    'Quantite : ${controller.product.value?.quantity}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
            ),

            // Product Image Carousel
            SizedBox(
              height: 300,
              child: Stack(
                children: [
                  Obx(() => PageView.builder(
                    onPageChanged: controller.updateImageIndex,
                    itemCount: controller.product.value?.images?.length ?? 0,
                    itemBuilder: (context, index) {
                      final image = controller.product.value?.images?[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            image?['link'] ?? '',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Center(child: Icon(Icons.image, size: 50)),
                          ),
                        ),
                      );
                    },
                  )),
                  // Carousel Indicators
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        controller.product.value?.images?.length ?? 0,
                        (index) => Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: controller.currentImageIndex.value == index
                                ? secondaryColor
                                : Colors.grey.withOpacity(0.5),
                          ),
                        ),
                      ),
                    )),
                  ),
                ],
              ),
            ),
            /*
            // Store Info
            ListTile(
              leading: controller.product.value!.images!.isNotEmpty ? Image.network(
                controller.product.value?.images?.first['link'] ?? '',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.image),
              ) : const Icon(Icons.image),
              title: Text('${controller.product.value?.name}'),
              subtitle: const Text('view store'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {}, // Implement store navigation
            ),
            */
            // Tabs
            DefaultTabController(

              length: 3,
              child: Column(
                children: [
                  const TabBar(
                    indicatorColor: secondaryColor,
                    labelColor: secondaryColor,
                    tabs: [
                      Tab(text: 'Description'),
                      Tab(text: 'Specification'),
                      Tab(text: 'Avis'),
                    ],
                  ),
                  SizedBox(
                    height: 200,
                    child: TabBarView(
                      
                      children: [
                        // Overview Tab
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            '${controller.product.value?.description}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ).scrollVertical(),
                        // Specification Tab
                        Center(child: VStack([
                          "Cas d'utilisation".text.bold.make(),
                          5.heightBox,
                          "${controller.product.value?.use_case}".text.make(),
                          15.heightBox,

                          "Ingrédients".text.bold.make(),
                          5.heightBox,
                          "${controller.product.value?.incredients}".text.make(),
                          15.heightBox,

                          "Conservation".text.bold.make(),
                          5.heightBox,
                          "${controller.product.value?.storage}".text.make(),
                          15.heightBox,


                        ])).p(16),
                        // Review Tab
                        Center(child: Text('${controller.product.value?.reference}')).p(16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: primaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${(controller.product.value?.price).toString().numCurrency} FCFA',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            ElevatedButton(
              onPressed: () => { Get.toNamed(Routes.NEWSELL, arguments: {'product_id': controller.product.value?.id, 'product_name': controller.product.value?.name})}, // Implement add to cart functionality
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 16,
                ),
              ),
              child: const Text(
                '+ Vente',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}