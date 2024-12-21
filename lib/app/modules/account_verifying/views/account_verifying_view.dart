import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/account_verifying_controller.dart';

class AccountVerifyingView extends GetView<AccountVerifyingController> {
  const AccountVerifyingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AccountVerifyingView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AccountVerifyingView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
