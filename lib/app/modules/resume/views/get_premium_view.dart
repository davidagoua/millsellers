import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../controllers/resume_controller.dart';

class GetPremiumView extends GetView<ResumeController> {
  const GetPremiumView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Get.back(),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Image.asset(
                    "assets/images/crown.png",
                    width: 200,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child:
                      "Forfait Premium 1 000 Vendeurs : Boostez Vos Revenus !"
                          .text
                          .size(24)
                          .bold
                          .make(),
                ),
                const SizedBox(height: 10),
                Center(
                  child:
                      "Rejoignez une communauté dynamique et maximisez vos gains."
                          .text
                          .size(16)
                          .gray500
                          .center
                          .make(),
                ),
                const SizedBox(height: 40),
                _buildFeatureItem(
                  icon: Icons.diamond_outlined,
                  title: "Adhésion Premium",
                  description:
                      "Payez 100 000 FCFA par an pour devenir membre premium. Accédez à un système de primes évolutif et à des formations.  ",
                ),
                const SizedBox(height: 20),
                _buildFeatureItem(
                  icon: Icons.notifications_active_outlined,
                  title: "Système de Primes",
                  description:
                      "Recevez des primes directes et indirectes sur 3 générations. Gagnez aussi un pourcentage sur les ventes des filleules.",
                ),
                const SizedBox(height: 20),
                _buildFeatureItem(
                  icon: Icons.support_agent_outlined,
                  title: "Conditions pour les Primes",
                  description:
                      "Réalisez 10 adhésions et vendez 4 cartons par mois. Vos ventes doivent dépasser celles de vos filleules.  ",
                ),
                const SizedBox(height: 20),
                _buildFeatureItem(
                  icon: Icons.star_border_rounded,
                  title: "Avantages Supplémentaires",
                  description:
                      "Profitez d'une adhésion prolongée en cas de suspension. Accédez bientôt à une application pour simplifier vos activités.",
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.getPremium();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: "Payer maintenant 50 000 FCFA"
                        .text
                        .white
                        .size(16)
                        .make(),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () => Get.back(),
                    child: "Passer".text.gray500.make(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 24,
          color: Get.theme.primaryColor,
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title.text.bold.size(16).make(),
              const SizedBox(height: 4),
              description.text.gray500.size(14).make(),
            ],
          ),
        ),
      ],
    );
  }
}
