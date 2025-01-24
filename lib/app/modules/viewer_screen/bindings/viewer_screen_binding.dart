import 'package:get/get.dart';

import '../controllers/viewer_screen_controller.dart';

class ViewerScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewerScreenController>(
      () => ViewerScreenController(),
    );
  }
}
