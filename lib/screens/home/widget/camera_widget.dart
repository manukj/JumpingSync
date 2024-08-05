import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gainz/resource/constants/image_path.dart';
import 'package:gainz/screens/home/view_model/camera_view_model.dart';
import 'package:gainz/screens/home/widget/button_widget.dart';
import 'package:gainz/screens/home/widget/stop_wathch.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CameraWidget extends GetView<PoseDetectionViewModel> {
  const CameraWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(() {
          var isInitState =
              controller.workoutStatus.value == WorkoutStatus.init;
          return Align(
            alignment: Alignment.center,
            child: AnimatedContainer(
              duration: const Duration(
                milliseconds: 1500,
              ),
              height: isInitState ? Get.height : Get.height / 2,
              width: Get.width,
              child: CameraPreview(
                controller.controller!,
              ),
            ),
          );
        }),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(() {
                  return StopwatchWidget(
                    start: controller.workoutStatus.value != WorkoutStatus.init,
                  );
                }),
                const WorkoutStatusButton(),
              ],
            ),
          ),
        ),
        _buildCountDownAnimation(),
      ],
    );
  }

  Widget _buildCountDownAnimation() {
    return Obx(
      () {
        if (controller.showCountDown.value) {
          return Center(
            child: Lottie.asset(
              ImagePath.countDownAnimation,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
