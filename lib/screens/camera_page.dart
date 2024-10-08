import 'dart:developer';

import 'package:assignment/controllers/video_controlller.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CameraPage extends StatefulWidget {
  String? videoPath;
  CameraPage({super.key, required this.videoPath});
  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController cameraController;
  late List<CameraDescription> cameras;
  final controller = Get.put(VideoGetControlller());
  XFile? videoFile;
  int direction = 0;
  bool isRecording = false;
  bool isLoading = true;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
    startCamera();
    super.initState();
  }

  void startCamera() async {
    cameras = await availableCameras();

    cameraController = CameraController(
      cameras[direction],
      ResolutionPreset.high,
      enableAudio: false,
    );

    await cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {}); // to refresh widget
    }).catchError((e) {
      log(e.toString());
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.black.withOpacity(0.7),
        colorText: Colors.white,
      );

      throw Exception(e);
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  void startStopRecording() async {
    if (!isRecording) {
      try {
        await cameraController.startVideoRecording().then((value) {
          setState(() {
            isRecording = true;
          });
        }).catchError((e) {
          log(e.toString());
          Get.snackbar(
            "Error",
            e.toString(),
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.black.withOpacity(0.7),
            colorText: Colors.white,
          );

          throw Exception(e);
        });
      } catch (e) {
        log(e.toString());
        Get.snackbar(
          "Error",
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.black.withOpacity(0.7),
          colorText: Colors.white,
        );

        throw Exception(e);
      }
    } else {
      try {
        await cameraController.stopVideoRecording().then((file) {
          if (mounted) {
            if (file != null) {
              setState(() {
                videoFile = file;
                controller.path(videoFile!.path);
                widget.videoPath = videoFile!.path;
                isRecording = false;
              });
              Navigator.pop(context);
            }
          }
        }).catchError((e) {
          log(e.toString());
          Get.snackbar(
            "Error",
            e.toString(),
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.black.withOpacity(0.7),
            colorText: Colors.white,
          );

          throw Exception(e);
        });
      } catch (e) {
        log(e.toString());
        Get.snackbar(
          "Error",
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.black.withOpacity(0.7),
          colorText: Colors.white,
        );

        throw Exception(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: !isLoading
            ? Stack(
                children: [
                  CameraPreview(cameraController),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        direction = direction == 1 ? 0 : 1;
                        startCamera();
                      });
                    },
                    child: button(
                      icon: const Icon(
                        Icons.flip_camera_ios_outlined,
                        color: Colors.black,
                      ),
                      alignment: Alignment.bottomLeft,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      startStopRecording();
                    },
                    child: button(
                      icon: Icon(
                        isRecording ? Icons.stop : Icons.video_call,
                        color: Colors.black,
                      ),
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                ],
              )
            : const SizedBox(
                child: Center(
                  child: SpinKitCircle(
                    color: Colors.white,
                  ),
                ),
              ));
  }
}

Widget button({required Icon icon, required Alignment alignment}) {
  return Align(
    alignment: alignment,
    child: Container(
      height: 50.h,
      width: 50.w,
      margin: EdgeInsets.only(left: 20.w, bottom: 20.h),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: Offset(2, 2),
            color: Colors.black26,
          ),
        ],
      ),
      child: icon,
    ),
  );
}
