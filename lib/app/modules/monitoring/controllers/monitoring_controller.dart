import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MonitoringController extends GetxController {
  //TODO: Implement MonitoringController
  CameraController? cameraController;
  var isCameraInitialized = false.obs;
  var landmarks = <Offset>[].obs;

  @override
  void onInit() {
    super.onInit();
    initializeCamera();
    landmarks.value = [
      Offset(100, 200),
      Offset(150, 250),
      Offset(200, 300),
    ];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final backCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.back,
    );

    cameraController = CameraController(
      backCamera,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await cameraController!.initialize();
    isCameraInitialized.value = true;
  }
}
