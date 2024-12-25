import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:millsellers/app/data/models/user.dart';
import 'package:logger/logger.dart';

class AuthController extends GetxController {

  final logger = Logger();

  final isLogged = false.obs;
  final box = GetStorage();
  final Rx<User?> _user = Rx<User?>(null);

  User? get user => _user.value;

  void logOut() {
    isLogged.value = false;
    removeToken();
  }

  void login(String? token) async {
    isLogged.value = true;
    
    await saveToken(token);
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

  String? getToken(){
    return box.read('auth_token');
  }

  Future<void> saveToken(String? token) async {
    logger.i(token);
    box.write('auth_token', token!);
  }

  bool isOnBoard() {
    print("isOnBoard: ${box.read("isOnBoard")}" );
    return box.read("isOnBoard") ?? false;
  }
}
