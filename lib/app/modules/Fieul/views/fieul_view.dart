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
          FutureBuilder<List<Widget>>(
            future: _fetchFieulExpansionTiles(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  children: snapshot.data!,
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

  Future<List<Widget>> _buildExpansionTiles(List<dynamic> fieuls, {double horizontalPadding = 8}) async {
    List<Widget> tiles = [];
    for (var fieul in fieuls) {
      var children = await controller.fetchFieul(id: fieul['id']);
      tiles.add(ExpansionTile(
        leading: Icon(Icons.fork_right),

        tilePadding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 8),
        title: Text(fieul['name']),
        subtitle: VStack([
          "${fieul['code']} - ${_getGender(fieul['gender'])}".text.gray400.make()
        ]),
        children: children != null ? await _buildExpansionTiles(children, horizontalPadding: horizontalPadding + 16) : [],
      ).card.white.elevation(1).roundedSM.make());
    }
    return tiles;
  }

  String _getGender(String gender) {
    switch (gender) {
      case 'male':
        return "Homme";
      case 'female':
        return "Femme";
      default:
        return "";
    }
  }
}
