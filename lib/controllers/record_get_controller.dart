import 'package:get/get.dart';

class RecordGetController extends GetxController {
  RxBool isAudioRecordContainerOpened = false.obs;
  RxBool isVideoRecordContainerOpened = false.obs;
  RxString recordState = "initial".obs;
  RxString playerState = "pause".obs;

  void toggleAudioRecordContainer() {
    if (!isAudioRecordContainerOpened.value) {
      recordState.value = "initial";
      playerState.value = "pause";
    }
    isAudioRecordContainerOpened(!isAudioRecordContainerOpened.value);
  }

  void toggleVideoRecordContainer() {
    isVideoRecordContainerOpened(!isVideoRecordContainerOpened.value);
  }

  void startRecording() {
    recordState("recording");
  }

  void stopRecording() {
    recordState("recorded");
  }

  void setPlay() {
    playerState("play");
  }

  void setPause() {
    playerState("pause");
  }
}
