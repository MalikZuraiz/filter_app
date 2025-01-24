import 'package:get/get.dart';

import '../controllers/edit_image_screen_controller.dart';

class EditImageScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditImageScreenController>(
      () => EditImageScreenController(),
    );
  }
}
