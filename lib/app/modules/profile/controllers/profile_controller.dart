import 'package:get/get.dart';
import 'package:millsellers/app/controllers/auth_controller.dart';
import 'package:millsellers/app/routes/app_pages.dart';
import 'package:logger/logger.dart';

final loger = Logger();

class ProfileController extends GetxController {
  final RxString username = ''.obs;
  final RxString email = ''.obs;
  final RxInt scans = 0.obs;
  final RxInt users = 0.obs;
  final RxInt codes = 0.obs;
  final RxBool is_premium = false.obs;
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
      
    }
    is_premium.value = authController.box.read('user')['is_premium'] ?? false;
    scans.value = authController.box.read('user')['customers'] ?? 0;
    users.value = authController.box.read('user')['invitees'] ?? 0;
    codes.value = authController.box.read('user')['rank'] ?? 0;
    
  }

  void logout() {
    Get.find<AuthController>().logOut();
    Get.offNamed(Routes.HOME);
  }
}
