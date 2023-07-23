import 'package:get/get.dart';

import '../controllers/info_sehat_controller.dart';

class InfoSehatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InfoSehatController>(
      () => InfoSehatController(),
    );
  }
}
