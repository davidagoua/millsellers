import 'package:get/get.dart';
import 'package:millsellers/app/controllers/auth_controller.dart';
import 'package:millsellers/app/routes/app_pages.dart';

class ProfileController extends GetxController {
  final RxString username = ''.obs;
  final RxString email = ''.obs;
  final RxInt scans = 0.obs;
  final RxInt users = 0.obs;
  final RxInt codes = 0.obs;
  final AuthController authController = Get.find();
  

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void loadUserData() {
    final user = Get.find<AuthController>().user;
    if (user != null) {
      username.value = user.seller?.name ?? '@User';
      email.value = user.seller?.email ?? '';
      // These values should come from your actual data
      scans.value = 126;
      users.value = 1;
      codes.value = 893;
    }
  }

  void logout() {
    Get.find<AuthController>().logOut();
    Get.offNamed(Routes.HOME);
  }
}
