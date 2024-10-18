import 'package:get/get.dart';
import 'package:landmarkapp/Scanner%20Page/scanner_controller.dart';

class ScannerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScannerController>(() => ScannerController());
  }
}
