import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_call/app/routes/app_pages.dart';

import '../../../services/videocall_services.dart';

class HomeController extends GetxController {
  final channelTextController = TextEditingController();

  Future<void> joinChannel() async {
    try {
      if (channelTextController.text.isEmpty) {
        Get.snackbar('Error', 'Please enter channle name');
        return;
      }

      final uid = Random.secure().nextInt(1000000);

      final token = await VideocallServices().getToken(
        channelName: channelTextController.text,
        uid: uid,
      );

      if (token == null) {
        Get.snackbar('Error', 'Failed to get token');
        return;
      }

      final grantedPermissions = await requestPermission();

      if (!grantedPermissions) {
        Get.snackbar('Error', 'Failed to get permission');
        return;
      }

      Get.toNamed(Routes.CALL_SCREEN, arguments: {
        'token': token,
        'channel': channelTextController.text,
        'uid': uid,
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to get token');
    }
  }

  Future<bool> requestPermission() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    return cameraPermission.isGranted && micPermission.isGranted;
  }
}
