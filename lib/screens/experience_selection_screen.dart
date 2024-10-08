import 'package:assignment/screens/onboarding_question_screen.dart';
import 'package:assignment/screens/widgets/experience_card_list.dart';
import 'package:assignment/utils/customTextStyles.dart';
import 'package:assignment/utils/customTextfieldStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/custom_button_style.dart';

// ignore: must_be_immutable
class ExperienceSelectionScreen extends StatelessWidget {
  ExperienceSelectionScreen({super.key});

  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: SvgPicture.asset("assets/images/appbar_line1.svg"),
        centerTitle: true,
        leading: SvgPicture.asset(
          'assets/images/arrow_left.svg',
          fit: BoxFit.scaleDown,
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
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Page number
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("01",
                      style: TextStyle(color: Colors.white.withOpacity(0.16))),
                ),

                // Heading
                Text(
                  "What kind of hotspots do you want to host?",
                  style: Customtextstyles.headingH2Bold(),
                ),
                SizedBox(height: 16.h),
                // experience card list
                Container(height: 100.h, child: ExperienceCardList()),
                SizedBox(height: 16.h),
                // textfield
                SizedBox(
                  height: 200.h,
                  child: TextField(
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    textAlignVertical: TextAlignVertical.top,
                    keyboardType: TextInputType.multiline,
                    maxLength: 250,
                    expands: true,
                    maxLines: null,
                    controller: descriptionController,
                    decoration: CustomTextFieldStyle.decor(
                        hintText: "/ Describe your perfect hotspot"),
                  ),
                ),
                SizedBox(height: 16.h),
                // next button
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    HapticFeedback.mediumImpact();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OnboardingQuestionScreen()));
                  },
                  child: Container(
                    height: 56.h,
                    width: double.infinity,
                    decoration: CustomButtonStyle.buttonStyle1(),
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
                SizedBox(height: 56.h)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
