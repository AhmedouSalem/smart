import 'package:get/get.dart';
import 'package:smart_training/data/model/posts_model.dart';

class PostsDetailsController extends GetxController {
  late PostsModel postsModel;
  @override
  void onInit() {
    postsModel = Get.arguments["posts_model"];
    super.onInit();
  }
}
