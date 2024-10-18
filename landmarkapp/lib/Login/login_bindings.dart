import 'package:get/get.dart';
import 'package:landmarkapp/Login/login_controller.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
