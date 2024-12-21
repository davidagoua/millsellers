import 'package:get/get.dart';

import '../modules/CommandeList/bindings/commande_list_binding.dart';
import '../modules/CommandeList/views/commande_list_view.dart';
import '../modules/Fieul/bindings/fieul_binding.dart';
import '../modules/Fieul/views/fieul_view.dart';
import '../modules/FirstProduct/bindings/first_product_binding.dart';
import '../modules/FirstProduct/views/first_product_view.dart';
import '../modules/InscriptionForm/bindings/inscription_form_binding.dart';
import '../modules/InscriptionForm/views/inscription_form_view.dart';
import '../modules/Offpayment/bindings/offpayment_binding.dart';
import '../modules/Offpayment/views/offpayment_view.dart';
import '../modules/account_verified/bindings/account_verified_binding.dart';
import '../modules/account_verified/views/account_verified_view.dart';
import '../modules/account_verifying/bindings/account_verifying_binding.dart';
import '../modules/account_verifying/views/account_verifying_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/index/bindings/index_binding.dart';
import '../modules/index/views/index_view.dart';
import '../modules/newsell/bindings/newsell_binding.dart';
import '../modules/newsell/views/newsell_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/reapform/bindings/reapform_binding.dart';
import '../modules/reapform/views/reapform_view.dart';
import '../modules/recharge/bindings/recharge_binding.dart';
import '../modules/recharge/views/recharge_view.dart';
import '../modules/resume/bindings/resume_binding.dart';
import '../modules/resume/views/resume_view.dart';
import '../modules/vente/bindings/vente_binding.dart';
import '../modules/vente/views/vente_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static var INITIAL = Routes.ONBOARDING;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
        name: _Paths.FIRST_PRODUCT,
        page: () => const FirstProductView(),
        binding: FirstProductBinding(),
        transition: Transition.downToUp),
    GetPage(
      name: _Paths.INSCRIPTION_FORM,
      page: () => const InscriptionFormView(),
      binding: InscriptionFormBinding(),
    ),
    GetPage(
      name: _Paths.OFFPAYMENT,
      page: () => const OffpaymentView(),
      binding: OffpaymentBinding(),
    ),
    GetPage(
      name: _Paths.INDEX,
      page: () => const IndexView(),
      binding: IndexBinding(),
    ),
    GetPage(
      name: _Paths.RESUME,
      page: () => const ResumeView(),
      binding: ResumeBinding(),
    ),
    GetPage(
      name: _Paths.REAPFORM,
      page: () => const ReapformView(),
      binding: ReapformBinding(),
    ),
    GetPage(
      name: _Paths.NEWSELL,
      page: () => const NewsellView(),
      binding: NewsellBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT_VERIFIED,
      page: () => const AccountVerifiedView(),
      binding: AccountVerifiedBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT_VERIFYING,
      page: () => const AccountVerifyingView(),
      binding: AccountVerifyingBinding(),
    ),
    GetPage(
      name: _Paths.VENTE,
      page: () => const VenteView(),
      binding: VenteBinding(),
    ),
    GetPage(
      name: _Paths.FIEUL,
      page: () => const FieulView(),
      binding: FieulBinding(),
    ),
    GetPage(
      name: _Paths.COMMANDE_LIST,
      page: () => const CommandeListView(),
      binding: CommandeListBinding(),
    ),
    GetPage(
      name: _Paths.RECHARGE,
      page: () => const RechargeView(),
      binding: RechargeBinding(),
    ),
  ];
}
