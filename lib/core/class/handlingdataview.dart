import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_training/core/class/statusrequest.dart';
import 'package:smart_training/core/constant/appimageassets.dart';

class HandlingDataView extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  const HandlingDataView({
    super.key,
    required this.statusRequest,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? Center(
            child:
                Lottie.asset(AppImageAssets.loading, width: 250, height: 250),
          )
        : statusRequest == StatusRequest.offlineFailure
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Lottie.asset(AppImageAssets.offline,
                        width: 250, height: 250),
                  ),
                ],
              )
            : widget;
  }
}
