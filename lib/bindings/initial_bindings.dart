import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:get/get.dart';

import '../controllers/sendMessageController.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() async {
    await Get.putAsync(() async => await DialogFlowtter.fromFile());
    Get.put(HomePageController(
      dialogFlowtter: Get.find<DialogFlowtter>(),
    ));
  }
}
