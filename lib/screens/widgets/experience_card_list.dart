import 'package:assignment/controllers/experience_list_controlller.dart';
import 'package:assignment/services/api_services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:math' as math;

import 'package:get/get.dart';

class ExperienceCardList extends StatefulWidget {
  ExperienceCardList({super.key});

  @override
  State<ExperienceCardList> createState() => _ExperienceCardListState();
}

class _ExperienceCardListState extends State<ExperienceCardList> {
  final controller = Get.put(ExperienceListControlller());

  final noFilter =
      const ColorFilter.mode(Colors.transparent, BlendMode.multiply);
  final greyFilter = const ColorFilter.matrix(
    <double>[
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ],
  );

  @override
  void initState() {
    ApiServices().getExperiences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isLoading.value
          ? const SpinKitCircle(color: Colors.white)
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.experiences.length,
              itemBuilder: (context, index) {
                int id = controller.experiences[index].id!;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10),
                  child: Transform.rotate(
                    angle: index % 2 == 0 ? -(math.pi / 37) : (math.pi / 50),
                    child: Obx(() {
                      return ColorFiltered(
                        colorFilter: controller.isSelected.contains(id)
                            ? noFilter
                            : greyFilter,
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            HapticFeedback.mediumImpact();
                            if (controller.isSelected.contains(id)) {
                              controller.deSelect(id);
                            } else {
                              controller.select(id);
                            }
                          },
                          child: CachedNetworkImage(
                            fit: BoxFit.contain,
                            imageUrl: controller.experiences[index].imageUrl
                                .toString(),
                            placeholder: (context, url) => const Center(
                                child: SpinKitCubeGrid(
                              color: Colors.white,
                            )),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      );
                    }),
                  ),
                );
              },
            );
    });
  }
}
