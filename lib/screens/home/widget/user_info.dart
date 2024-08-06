import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gainz/resource/auth/auth_view_model.dart';
import 'package:get/get.dart';

class UserInfo extends StatelessWidget {
  final AuthViewModel controller = Get.find();
  UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoggedIn()) {
        return SizedBox(
          height: 80,
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (controller.userPhotoUrl.isNotEmpty)
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(controller.userPhotoUrl.value),
                          radius: 30,
                        ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Hello ${controller.userName.value}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const Text(
                            'Welcome back to Gainz',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      } else {
        return Container();
      }
    });
  }
}
