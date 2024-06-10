import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ninen/components/custom_elevated_btn.dart';
import 'package:ninen/components/custom_progress_card.dart';
import 'package:ninen/modules/progress/cubit/progress_cubit.dart';
import 'package:ninen/theme/app_colors.dart';
import 'package:ninen/theme/app_text_styles.dart';

class BeforeAndAfterPage extends StatefulWidget {
  const BeforeAndAfterPage({super.key});

  @override
  State<BeforeAndAfterPage> createState() => _BeforeAndAfterPageState();
}

class _BeforeAndAfterPageState extends State<BeforeAndAfterPage> {
  final beforeWeightCtl = TextEditingController();
  final afterWeightCtl = TextEditingController();
  bool isCompare = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        surfaceTintColor: AppColors.white,
        backgroundColor: AppColors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            context.read<ProgressCubit>().clear();
          },
          icon: SvgPicture.asset(
            'assets/icons/back_icon.svg',
            height: 24,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          'Before and after',
          style: AppTextStyles.styleF20WNormal(),
          textAlign: TextAlign.center,
        ),
        actions: [
          isCompare
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isCompare = false;
                    });
                  },
                  icon: SvgPicture.asset('assets/icons/edit.svg'),
                  color: Colors.red,
                )
              : const SizedBox(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 30),
          child: BlocBuilder<ProgressCubit, ProgressState>(
            builder: (context, state) {
              if (isCompare && state.beforeAfterModel != null) {
                return Column(
                  children: [
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.file(
                            state.beforeAfterModel!.beforeImage,
                            width: double.infinity,
                            height: 226,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Before',
                              style: AppTextStyles.styleF20WNormal(),
                            ),
                            Text(
                              '${state.beforeAfterModel!.beforeWeight} kg',
                              style: AppTextStyles.styleF20WNormal(),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.file(
                            state.beforeAfterModel!.afterImage,
                            width: double.infinity,
                            height: 226,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'After',
                              style: AppTextStyles.styleF20WNormal(),
                            ),
                            Text(
                              '${state.beforeAfterModel!.afterWeight} kg',
                              style: AppTextStyles.styleF20WNormal(),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    weightResult(
                      int.parse(state.beforeAfterModel!.beforeWeight),
                      int.parse(state.beforeAfterModel!.afterWeight),
                    ),
                  ],
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Before",
                      style: AppTextStyles.styleF20WNormal(),
                    ),
                    const SizedBox(height: 20),
                    CustomProgressCard(
                      controller: beforeWeightCtl,
                      title: 'Weight',
                      name: 'kg',
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Add photo ',
                      style: AppTextStyles.styleF14WNormal(),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        context
                            .read<ProgressCubit>()
                            .takePhoto(PhotoType.before);
                      },
                      child: BlocBuilder<ProgressCubit, ProgressState>(
                        builder: (context, state) {
                          return Container(
                            width: double.infinity,
                            height: 135,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: const Color(0xffF1F1F1),
                            ),
                            child: state.beforeImage == null
                                ? Center(
                                    child: SvgPicture.asset(
                                      'assets/icons/camera.svg',
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: Image.file(
                                      state.beforeImage!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      "After",
                      style: AppTextStyles.styleF20WNormal(),
                    ),
                    const SizedBox(height: 20),
                    CustomProgressCard(
                      controller: afterWeightCtl,
                      title: 'Weight',
                      name: 'kg',
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Add photo ',
                      style: AppTextStyles.styleF14WNormal(),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        context
                            .read<ProgressCubit>()
                            .takePhoto(PhotoType.after);
                      },
                      child: BlocBuilder<ProgressCubit, ProgressState>(
                        builder: (context, state) {
                          return Container(
                            width: double.infinity,
                            height: 135,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: const Color(0xffF1F1F1),
                            ),
                            child: state.afterImage == null
                                ? Center(
                                    child: SvgPicture.asset(
                                      'assets/icons/camera.svg',
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: Image.file(
                                      state.afterImage!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 18),
                    Center(
                      child: BlocBuilder<ProgressCubit, ProgressState>(
                        builder: (context, state) {
                          return CustomElevatedBtn(
                            onPressed: () {
                              if (beforeWeightCtl.text.isNotEmpty &&
                                  afterWeightCtl.text.isNotEmpty &&
                                  state.afterImage != null &&
                                  state.beforeImage != null) {
                                context.read<ProgressCubit>().compare(
                                      BeforeAfterModel(
                                        beforeImage: state.beforeImage!,
                                        beforeWeight: beforeWeightCtl.text,
                                        afterImage: state.afterImage!,
                                        afterWeight: afterWeightCtl.text,
                                      ),
                                    );
                                setState(() {
                                  isCompare = true;
                                });
                              }
                            },
                            text: 'Compare',
                            isProgess: true,
                          );
                        },
                      ),
                    )
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Column weightResult(
    int beforeWeight,
    int afterWeight,
  ) {
    String message;

    if (beforeWeight > afterWeight) {
      int weightLoss = beforeWeight - afterWeight;
      message = 'Your progress is -${weightLoss.toStringAsFixed(0)} kg!';
    } else if (beforeWeight < afterWeight) {
      int weightGain = afterWeight - beforeWeight;
      message = 'You gained ${weightGain.toStringAsFixed(0)} kg!';
    } else {
      message =
          'You did not lose or gain weight, keep maintaining your health.';
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'That\'s cool!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 32,
            fontWeight: FontWeight.w700,
            height: 43.58 / 32,
          ),
        ),
        Text(
          message,
          textAlign: TextAlign.center,
          style: AppTextStyles.styleF20WNormal(),
        ),
      ],
    );
  }
}

class BeforeAfterModel {
  const BeforeAfterModel({
    required this.beforeImage,
    required this.beforeWeight,
    required this.afterImage,
    required this.afterWeight,
  });

  final File beforeImage;
  final String beforeWeight;
  final File afterImage;
  final String afterWeight;
}
