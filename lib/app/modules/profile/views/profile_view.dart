import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../controllers/profile_controller.dart';
import 'package:millsellers/utils/contants.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Builder(
                  builder: (context)=>SafeArea(child:VStack([
                      HStack([
                        Container(
                          color: const Color.fromRGBO(236, 249, 242, 1),
                          child: const Icon(Icons.close, color: Vx.green500,)
                        ).cornerRadius(7).onTap(Get.back),
                        Expanded(child: "Profile utilisateur".text.color(const Color.fromRGBO(41, 156, 22, 1)).size(22).make().centered(),)
                      ], alignment: MainAxisAlignment.start,).w(double.maxFinite),
                      
                      
                    ], crossAlignment: CrossAxisAlignment.center,).scrollVertical().p(15),
                  ),  
                ),
                // Profile Header
                Center(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey[200],
                            backgroundImage: const AssetImage('assets/images/avatar.png'),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: secondaryColor,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Obx(() => Text(
                        controller.username.value,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                      const SizedBox(height: 4),
                      Obx(() => Text(
                        controller.email.value,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      )),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Stats Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatItem('Ventes', '${controller.scans}/750'),
                    _buildDivider(),
                    _buildStatItem('Fieuls', '${controller.users}/6'),
                    _buildDivider(),
                    _buildStatItem('Codes', '${controller.codes}/2500'),
                  ],
                ),
                const SizedBox(height: 32),

                // Menu Items
                _buildMenuItem(
                  icon: Icons.settings,
                  title: 'Paramètres',
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.credit_card,
                  title: 'Details de paiement',
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.group,
                  title: 'Gestion du compte',
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.info,
                  title: 'Information',
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.logout,
                  title: 'Se deconnecter',
                  onTap: () => controller.logout(),
                  isDestructive: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.grey[300],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDestructive ? Colors.red[50] : primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: isDestructive ? Colors.red : Colors.green[800],
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? Colors.red : Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    ).p(10).card.white.p12.make();
  }
}
