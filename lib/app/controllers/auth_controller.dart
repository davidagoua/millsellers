import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:millsellers/app/data/models/user.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class AuthController extends GetxController {
  final isLogged = false.obs;
  final box = GetStorage();
  final Rx<User?> _user = Rx<User?>(null);

  User? get user => _user.value;

  void logOut() {
    isLogged.value = false;
    GetStorage().erase();
    removeToken();
  }

  void login(String? token) async {
    isLogged.value = true;

    await saveToken(token);
    logger.w(await GetStorage().read("user"));
    final user = User.fromJson(GetStorage().read("user"));
    this._user.value = user;
  }

  void checkLoginStatus() {
    final token = getToken();
    if (token != null) {
      isLogged.value = true;
    }
  }

  Future<void> removeToken() async {
    box.erase();
  }

  String? getToken() {
    return box.read('auth_token');
  }

  Future<void> saveToken(String? token) async {
    logger.i(token);
    box.write('auth_token', token!);
  }

  bool isOnBoard() {
    print("isOnBoard: ${box.read("isOnBoard")}");
    return box.read("isOnBoard") ?? false;
  }
}
