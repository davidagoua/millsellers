import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:millsellers/app/controllers/auth_controller.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  final AuthController authmanager = Get.put(AuthController());

  String initialPage = AppPages.INITIAL;
  print("${authmanager.isOnBoard()} redirect");
  authmanager.checkLoginStatus();
  if(authmanager.isLogged()){
    initialPage = Routes.INDEX;
  }else if( authmanager.isOnBoard() ){
    initialPage = Routes.HOME;
  }
  else {
    initialPage = Routes.ONBOARDING;
  }

  runApp(
    GetMaterialApp(
      title: "100Vendeurs",
      initialRoute: initialPage,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.varelaTextTheme(),
        primaryColor: const Color.fromRGBO(41, 156, 22, 1),
        primaryTextTheme: GoogleFonts.sourceCodeProTextTheme()
      ),
    ),
  );
}
