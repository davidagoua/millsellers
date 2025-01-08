import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:velocity_x/velocity_x.dart';
import '../controllers/recharge_controller.dart';
import 'package:millsellers/app/routes/app_pages.dart';

class RechargeSuccessView extends GetView<RechargeController> {
  const RechargeSuccessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                // Success Icon
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: const Color(0xFF199E46),
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Money Icon
                      Transform.translate(
                        offset: const Offset(0, 10),
                        child: Image.asset(
                          'assets/images/money2.png',
                          width: 60,
                          height: 40,
                          color: Colors.green[100],
                        ),
                      ),
                      // Checkmark Icon
                      const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 60,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                // Success Text
                const Text(
                  'Demande de Rechargement Envoyée!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF199E46),
                  ),
                ),
                const SizedBox(height: 20),
                // Success Message
                const Text(
                  'Votre demande de recharge a été envoyée avec succès.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 40),
                // Transaction Details
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      _buildTransactionDetail('Montant', '${controller.uniteCtrl.text.numCurrency} FCFA'),
                      const SizedBox(height: 15),
                      _buildTransactionDetail('Date', DateTime.now().toString().substring(0, 16)),
                      const SizedBox(height: 15),
                      _buildTransactionDetail('Status', 'En cours'),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                // Return to Home Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF199E46),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => Get.offAllNamed(Routes.INDEX),
                    child: const Text(
                      'Retour à l\'accueil',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionDetail(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
