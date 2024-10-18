import 'package:get/get.dart';
import 'package:landmarkapp/History%20Page/history_bindinds.dart';
import 'package:landmarkapp/History%20Page/history_page.dart';
import 'package:landmarkapp/Home/home_bindings.dart';
import 'package:landmarkapp/Home/home_page.dart';
import 'package:landmarkapp/Login/login_bindings.dart';
import 'package:landmarkapp/Login/login_screen.dart';
import 'package:landmarkapp/Result%20Page/result_binding.dart';
import 'package:landmarkapp/Result%20Page/result_page.dart';
import 'package:landmarkapp/Routes/app_routes.dart';
import 'package:landmarkapp/Scanner%20Page/scanner_binding.dart';
import 'package:landmarkapp/Scanner%20Page/scanner_screen.dart';
import 'package:landmarkapp/Signup/signup_bindings.dart';
import 'package:landmarkapp/Signup/signup_screen.dart';
import 'package:landmarkapp/Splash%20Page/splash_screen.dart';

class AppPages {
  static List<GetPage> pages = [
    GetPage(
      name:
          AppRoutes.splashScreen, // Define the name for the splash screen route
      page: () => const SplashPage(), // Create an instance of SplashPage
    ),
    GetPage(
        name: AppRoutes.homeScreen,
        page: () => const HomeScreen(),
        binding: HomeBindings()),
    GetPage(
        name: AppRoutes.resultScreen,
        page: () => const LandmarkClassifierScreen(),
        binding: ResultBinding()),
    GetPage(
        name: AppRoutes.scannerScreen,
        page: () => const ScannerScreen(),
        binding: ScannerBindings()),
    GetPage(
        name: AppRoutes.historyScreen,
        page: () => const HistoryPage(),
        binding: HistoryBindinds()),
    GetPage(
      name: AppRoutes.loginScreen,
      page: () => LoginPage(),
      binding: LoginBindings(),
    ),
    GetPage(
      name: AppRoutes.registerScreen, // Add the route name for RegisterPage
      page: () => SignUpPage(), // Create an instance of RegisterPage
      binding: SignUpBindings(), // Add the binding for RegisterPage
    ),
  ];
}
