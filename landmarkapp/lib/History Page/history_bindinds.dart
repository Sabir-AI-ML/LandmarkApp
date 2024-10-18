import 'package:get/get.dart';
import 'package:landmarkapp/History%20Page/history_controller.dart';

class HistoryBindinds extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HistoryController());
  }
}
