import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_training/controller/settings_controller.dart';
import 'package:smart_training/core/constant/Appsize.dart';
import 'package:smart_training/view/widget/customtitletext.dart';
import 'package:smart_training/view/widget/postssettings/customheader.dart';
import 'package:url_launcher/url_launcher.dart';

class PostsSettings extends StatelessWidget {
  const PostsSettings({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsController settingsController = Get.put(SettingsController());
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomHeaderSettings(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: AppSize.fullWidth * 0.2),
                child: ListView(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: CustomTitleText(
                              title: settingsController.username),
                        ),
                        ListTile(
                          onTap: () {},
                          title: const Text(
                            "My blogs",
                          ),
                          leading: const Icon(Icons.public),
                        ),
                        ListTile(
                          onTap: () {},
                          title: const Text(
                            "Change password",
                          ),
                          leading: const Icon(Icons.password_outlined),
                        ),
                        ListTile(
                          onTap: () {},
                          title: const Text(
                            "Notifications",
                          ),
                          leading:
                              const Icon(Icons.circle_notifications_outlined),
                          subtitle: const Text("Off"),
                        ),
                        ListTile(
                          onTap: () async {
                            await launchUrl(Uri.parse("tel:+22249744757"));
                          },
                          title: const Text(
                            "Contact us",
                          ),
                          leading: const Icon(Icons.contact_support_outlined),
                        ),
                        ListTile(
                          onTap: () {
                            settingsController.exitToApp();
                          },
                          title: const Text(
                            "logout",
                          ),
                          leading: const Icon(Icons.exit_to_app),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
