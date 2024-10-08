import 'dart:io';

import 'package:assignment/controllers/record_get_controller.dart';
import 'package:assignment/controllers/video_controlller.dart';
import 'package:assignment/screens/camera_page.dart';
import 'package:assignment/utils/custom_button_style.dart';
import 'package:assignment/utils/custom_colors.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../utils/customTextStyles.dart';
import '../utils/customTextfieldStyle.dart';

class OnboardingQuestionScreen extends StatefulWidget {
  OnboardingQuestionScreen({super.key});

  @override
  State<OnboardingQuestionScreen> createState() =>
      _OnboardingQuestionScreenState();
}

class _OnboardingQuestionScreenState extends State<OnboardingQuestionScreen> {
  TextEditingController textController = TextEditingController();
  late final RecorderController recorderController;
  final videoController = Get.put(VideoGetControlller());
  PlayerController playerController = PlayerController();
  final recordGetController = Get.put(RecordGetController());

  String? audioPath;
  String? videoPath = "";
  bool isRecordingCompleted = false;
  late Directory appDirectory;

  @override
  void initState() {
    super.initState();
    _getDir();
    _initialiseControllers();
  }

  void _getDir() async {
    appDirectory = await getApplicationDocumentsDirectory();
    audioPath = "${appDirectory.path}/recording.m4a";
    setState(() {});
  }

  void _initialiseControllers() {
    recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 44100;
  }

  @override
  void dispose() {
    recorderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset("assets/images/appbar_line2.svg"),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
              FocusScope.of(context).unfocus();
              Navigator.pop(context);
          },
          child: SvgPicture.asset(
            'assets/images/arrow_left.svg',
            fit: BoxFit.scaleDown,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: SvgPicture.asset(
              'assets/images/cross.svg',
              fit: BoxFit.scaleDown,
            ),
          ),
        ],
      ),
      body: SizedBox(
        height: screenHeight,
        child: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Page number
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("02",
                      style: TextStyle(color: Colors.white.withOpacity(0.16))),
                ),

                // Heading
                Text(
                  "Why do you want to host with us?",
                  style: Customtextstyles.headingH2Bold(),
                ),

                SizedBox(height: 8.h),
                Text(
                  "Tell us about your intent and what motivates you to create experiences.",
                  style: TextStyle(color: Colors.white.withOpacity(0.48)),
                ),
                SizedBox(height: 16.h),
                // textfield
                Column(
                  children: [
                    SizedBox(
                      height: 320.h,
                      child: TextField(
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                        textAlignVertical: TextAlignVertical.top,
                        keyboardType: TextInputType.multiline,
                        maxLength: 600,
                        expands: true,
                        maxLines: null,
                        controller: textController,
                        decoration: CustomTextFieldStyle.decor(
                            hintText: "/ Start typing here"),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Obx(() {
                      return Visibility(
                          visible: recordGetController
                              .isAudioRecordContainerOpened.value,
                          child: audioRecorderWidget());
                    })
                  ],
                ),
                SizedBox(height: 16.h),
                Obx(() {
                  if (videoController.path.value != "") {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      height: 60.h,
                      width: double.infinity,
                      decoration: CustomButtonStyle.buttonStyle1(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Recorded Video",
                                style: TextStyle(color: Colors.white),
                              ),
                              IconButton(
                                  onPressed: () {
                                    HapticFeedback.mediumImpact();
                                    videoController.path("");
                                  },
                                  icon: Icon(
                                    Icons.delete_outline_rounded,
                                    color: CustomColors.primaryAccent,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                }),

                SizedBox(height: 16.h),

                Row(
                  children: [
                    Container(
                      width: 112.w,
                      height: 56.h,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.white.withOpacity(0.08)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          GestureDetector(
                              onTap: () {
                                HapticFeedback.mediumImpact();
                                recordGetController
                                    .toggleAudioRecordContainer();
                                print(recordGetController
                                    .isAudioRecordContainerOpened.value);
                              },
                              child: SvgPicture.asset("assets/images/mic.svg",
                                  width: 25)),
                          SvgPicture.asset("assets/images/vertical_line.svg"),
                          GestureDetector(
                            onTap: () {
                              HapticFeedback.mediumImpact();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CameraPage(videoPath: videoPath)));
                            },
                            child: SvgPicture.asset("assets/images/video.svg",
                                width: 25),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Container(
                        height: 56.h,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFF222222).withOpacity(0.4),
                                const Color(0xFF999999).withOpacity(0.4),
                                const Color(0xFF222222).withOpacity(0.4),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            border: Border.all(
                                color: Colors.white.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Next",
                              style: TextStyle(color: Colors.white),
                            ),
                            SvgPicture.asset(
                              'assets/images/next_button_arrow.svg',
                              fit: BoxFit.scaleDown,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 56.h)
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// This funtion will start and stop audio recording
  void startOrStopRecording() async {
    try {
      if (recordGetController.recordState.value == "recording") {
        audioPath = await recorderController.stop(false);

        playerController.preparePlayer(path: audioPath!);
        if (audioPath != null) {
          isRecordingCompleted = true;
          debugPrint(audioPath);
          debugPrint("Recorded file size: ${File(audioPath!).lengthSync()}");
        }

        recordGetController.stopRecording();
      } else {
        await recorderController.record(path: audioPath);
        recordGetController.startRecording();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {}
  }

  /// Audio recorder container
  Widget audioRecorderWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 130.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF222222).withOpacity(0.4),
            const Color(0xFF999999).withOpacity(0.4),
            const Color(0xFF222222).withOpacity(0.4),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                recordGetController.recordState.value == "initial"
                    ? "Recording Audio..."
                    : "Audio Recorded",
                style: const TextStyle(color: Colors.white),
              ),
              IconButton(
                  onPressed: () {
                    HapticFeedback.mediumImpact();
                    recordGetController.recordState("initial");
                    recorderController.reset();
                    recorderController.stop(false);
                    audioPath = "";
                    playerController.release();
                  },
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    color: CustomColors.primaryAccent,
                  ))
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () async {
                  HapticFeedback.mediumImpact();
                  if (recordGetController.recordState.value != "recorded") {
                    startOrStopRecording();
                  } else {
                    if (playerController.playerState.isPlaying) {
                      await playerController.pausePlayer();
                    } else {
                      await playerController.startPlayer(
                          finishMode: FinishMode.loop);
                    }
                  }
                },
                child: Obx(() {
                  return CircleAvatar(
                    backgroundColor: CustomColors.primaryAccent,
                    child: Icon(
                        recordGetController.recordState.value == "initial"
                            ? Icons.mic_none_outlined
                            : recordGetController.recordState.value ==
                                    "recording"
                                ? Icons.stop
                                : recordGetController.playerState.value ==
                                        "play"
                                    ? Icons.pause
                                    : Icons.play_arrow,
                        color: Colors.white),
                  );
                }),
              ),
              if (recordGetController.recordState.value == "recording")
                AudioWaveforms(
                  enableGesture: true,
                  size: Size(260.w, 100),
                  recorderController: recorderController,
                  waveStyle: const WaveStyle(
                      waveThickness: 7,
                      waveColor: Colors.white,
                      extendWaveform: true,
                      showMiddleLine: false,
                      scaleFactor: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: const EdgeInsets.only(left: 18),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                )
              else
                AudioFileWaveforms(
                  size: Size(260.w, 70),
                  playerController: playerController,
                  playerWaveStyle: const PlayerWaveStyle(
                    liveWaveColor: Colors.white,
                    fixedWaveColor: Colors.white,
                    waveThickness: 6,
                    spacing: 7,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
