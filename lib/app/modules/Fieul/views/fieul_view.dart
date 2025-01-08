import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:millsellers/utils/contants.dart';
import '../controllers/fieul_controller.dart';

class FieulView extends GetView<FieulController> {
  const FieulView({Key? key}) : super(key: key);
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
              "Mon réseau"
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
          FutureBuilder<List<dynamic>?>(
            future: controller.fetchFieul(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  children: snapshot.data!
                      .map((e) => ExpansionTile(
                            backgroundColor: primaryColor,
                            leading: Icon(Icons.person_2_outlined),
                            title: "${e['name']}".text.make(),
                            subtitle: "${_getGender(e['gender'])} - ${e['code']}".text.make(),
                            children: [],
                          ).card.make())
                      .toList(),
                );
              } else {
                return const CircularProgressIndicator(color: Vx.green700).centered();
              }
            },
          ),
        ]).p(15),
      ),
    );
  }

  Future<List<Widget>> _fetchFieulExpansionTiles() async {
    List<dynamic>? initialFieuls = await controller.fetchFieul();
    if (initialFieuls == null) return [];
    return await _buildExpansionTiles(initialFieuls);
  }

  Future<List<Widget>> _buildExpansionTiles(List<dynamic> fieuls) async {
    List<Widget> tiles = [];
    for (var fieul in fieuls) {
      var children = await controller.fetchFieul(id: fieul['id']);
      tiles.add(ExpansionTile(
        title: Text(fieul['name']),
        children: children != null ? await _buildExpansionTiles(children) : [],
      ));
    }
    return tiles;
  }

  String _getGender(String gender) {
    switch (gender) {
      case 'male':
        return "Femme";
      case 'female':
        return "Homme";
      default:
        return "";
    }
  }
}
