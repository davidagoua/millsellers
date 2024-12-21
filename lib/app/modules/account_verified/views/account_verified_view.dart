import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/account_verified_controller.dart';

class AccountVerifiedView extends GetView<AccountVerifiedController> {
  const AccountVerifiedView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AccountVerifiedView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AccountVerifiedView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
