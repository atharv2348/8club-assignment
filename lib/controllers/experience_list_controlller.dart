import 'package:assignment/models/experience_model.dart';
import 'package:get/get.dart';

class ExperienceListControlller extends GetxController {
  RxList<ExperienceModel> experiences = <ExperienceModel>[].obs;
  RxList<int> isSelected = <int>[].obs;
  RxBool isLoading = true.obs;

  void pushExperience(ExperienceModel ex) {
    experiences.add(ex);
  }

  void select(int id) {
    isSelected.add(id);
  }

  void deSelect(int id) {
    isSelected.remove(id);
  }
}
