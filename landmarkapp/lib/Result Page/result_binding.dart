import 'package:get/get.dart';
import 'package:landmarkapp/Result%20Page/result_controller.dart';

class ResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResultController>(() => ResultController());
  }
}
