import 'package:get/get.dart';
import 'package:smart_training/core/class/crud.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(Crud());
  }
}
