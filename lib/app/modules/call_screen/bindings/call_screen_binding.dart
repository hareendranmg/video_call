import 'package:get/get.dart';

import '../controllers/call_screen_controller.dart';

class CallScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CallScreenController>(
      () => CallScreenController(),
    );
  }
}
