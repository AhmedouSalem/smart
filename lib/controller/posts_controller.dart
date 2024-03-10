import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_training/core/class/statusrequest.dart';
import 'package:smart_training/core/constant/approutes.dart';
import 'package:smart_training/core/functions/handlingdata.dart';
import 'package:smart_training/core/services/appservices.dart';
import 'package:smart_training/data/datasource/remote/posts_data.dart';
import 'package:smart_training/data/model/posts_model.dart';

class PostsController extends GetxController {
  List<PostsModel> postsModel = [];
  PostsData postsData = PostsData(Get.find());
  AppServices appServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;

  @override
  void onInit() {
    print(appServices.sharedPreferences.getString("users_name"));
    getPosts();
    super.onInit();
  }

  Future<void> getPosts() async {
    statusRequest = StatusRequest.loading;
    update();
    try {
      statusRequest = StatusRequest.loading;
      var posts = await postsData.getPosts();
      statusRequest = await handlingData(posts);
      print(statusRequest);
      if (StatusRequest.success == statusRequest) {
        List<Map<String, dynamic>> data = posts;
        postsModel.addAll(data.map((e) => PostsModel.fromJson(e)));
        print(posts);
      }
      update();
    } catch (error) {
      print('Error fetching hotels: $error');
      statusRequest = StatusRequest.none;
      update();
    }
  }

  String calculateDate(DateTime dateTime) {
    Duration timeDifference = DateTime.now().difference(dateTime);
    String timeAgo = formatDuration(timeDifference, dateTime);
    return timeAgo;
  }

  String formatDuration(Duration duration, DateTime dateTime) {
    final DateFormat formatter = DateFormat.yMd().add_Hms();

    if (duration.inSeconds < 60) {
      return 'à l\'instant';
    } else if (duration.inMinutes < 60) {
      return '${duration.inMinutes} ${_pluralize(duration.inMinutes, "minute")}';
    } else if (duration.inHours < 24) {
      return '${duration.inHours} ${_pluralize(duration.inHours, "heure")}';
    } else {
      return formatter.format(dateTime);
    }
  }

  String _pluralize(int count, String unit) {
    return count > 1 ? '$unit' + 's' : unit;
  }

  goToPostsDetails(PostsModel postsModel) {
    Get.toNamed(AppRoute.postsDetails, arguments: {
      "posts_model": postsModel,
    });
  }

  goToSettings() {
    Get.toNamed(AppRoute.settings);
  }

  goToAddPosts() {
    Get.toNamed(AppRoute.addPosts);
  }
}
