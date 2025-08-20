import 'package:get/get.dart';
import 'package:myamco/App/%20modules/Dashboad/dashboard_view.dart';
import 'package:myamco/App/%20modules/Dashboad/dashboardbinding.dart';
import 'package:myamco/App/%20modules/Profile/profile_binding.dart';
import 'package:myamco/App/%20modules/Profile/profile_view.dart';
import 'package:myamco/App/%20modules/Union%20Update/unionupadate_details.dart';
import 'package:myamco/App/%20modules/Union%20Update/unionupdate_view.dart';
import 'package:myamco/App/%20modules/login/login_binding.dart';
import 'package:myamco/App/%20modules/login/login_view.dart';
import 'package:myamco/App/%20modules/splash/splash_view.dart';

import '../ modules/Profile/Editprofile.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => const SplashScreen(),


    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ), GetPage(
      name: AppRoutes.UnionUpdatePage,
      page: () =>  UnionUpdatePage(),

    ),
    GetPage(
      name: AppRoutes.UnionUpdateDetailPage,
      page: () => const UnionUpdateDetailPage(title: '', description: '', imageUrl: '',),

    ),
    GetPage(
      name: AppRoutes.ProfilePage,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.EditProfilePage,
      page: () => const EditProfilePage(),


    ),


  ];
}
