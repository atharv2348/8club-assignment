import 'dart:developer';

import 'package:assignment/models/experience_model.dart';
import 'package:assignment/controllers/experience_list_controlller.dart';
import 'package:assignment/utils/api_endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApiServices {
  final dio = Dio();
  final controller = Get.put(ExperienceListControlller());
  Future<List<ExperienceModel>> getExperiences() async {
    log("getExperience called");
    try {
      controller.isLoading(true);
      final response = await dio.get(EndPoints.allExperience);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data["data"]["experiences"];
        controller.experiences(
            data.map((json) => ExperienceModel.fromJson(json)).toList());
        controller.isLoading(false);
        return [];
      } else {
        throw Exception("Failed to load experience");
      }
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
