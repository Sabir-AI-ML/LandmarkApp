import 'package:get/get.dart';
import 'package:landmarkapp/Signup/signup_controller.dart';

class SignUpBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(
      () => SignUpController(),
    );
  }
}
