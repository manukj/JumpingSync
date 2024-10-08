import 'package:Vyayama/common_widget/common_error_view.dart';
import 'package:Vyayama/common_widget/common_loader.dart';
import 'package:Vyayama/resource/toast/toast_manager.dart';
import 'package:Vyayama/screens/workout/model/workout_list.dart';
import 'package:Vyayama/screens/workout/view_model/workout_detector_view_model.dart';
import 'package:Vyayama/screens/workout/widget/camera_widget.dart';
import 'package:Vyayama/screens/workout/widget/user_info_workout_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkoutPage extends StatelessWidget {
  final Workout workout;
  final WorkoutDetectorViewModel poseViewModel =
      Get.put(WorkoutDetectorViewModel());

  WorkoutPage({super.key, required this.workout});

  Future<void> _initializeCamera() async {
    await poseViewModel.init(workout);
    return poseViewModel.initializeControllerFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeCamera(),
        builder: (context, snapshot) {
          return Stack(
            children: [
              _buildCameraWidget(snapshot),
              UserInfoAndWorkoutName(
                workout: workout,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCameraWidget(AsyncSnapshot<void> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CommonLoader();
    } else {
      if (snapshot.hasError) {
        ToastManager.showError(
            "Camera Initialization Failed ${snapshot.error.toString()}");
        return const CommonErrorView(
          title: "Camera Initialization Failed",
        );
      } else {
        if (poseViewModel.controller != null) {
          return const CameraWidget();
        } else {
          return const CommonLoader();
        }
      }
    }
  }
}
