import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final isLogged = false.obs;
  final box = GetStorage();

  void logOut() {
    isLogged.value = false;
    removeToken();
  }

  void login(String? token) async {
    isLogged.value = true;
    //Token is cached
    await saveToken(token);
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

  String? getToken(){
    return box.read('auth_token');
  }

  Future<void> saveToken(String? token) async {
    box.write('auth_token', token!);
  }

  bool isOnBoard() {
    print("isOnBoard: ${box.read("isOnBoard")}" );
    return box.read("isOnBoard") ?? false;
  }
}
