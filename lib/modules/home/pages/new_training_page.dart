import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:ninen/components/custom_elevated_btn.dart';
import 'package:ninen/components/text_field_widget.dart';
import 'package:ninen/components/traing_detail_widget.dart';
import 'package:ninen/models/new_training_model.dart';
import 'package:ninen/modules/home/cubit/home_cubit.dart';
import 'package:ninen/modules/purposes/cubit/purposes_cubit.dart';
import 'package:ninen/theme/app_colors.dart';
import 'package:ninen/theme/app_text_styles.dart';

class NewTrainingPage extends StatefulWidget {
  const NewTrainingPage({super.key});

  @override
  State<NewTrainingPage> createState() => _NewTrainingPageState();
}

class _NewTrainingPageState extends State<NewTrainingPage> {
  final typeCtl = TextEditingController();
  final durationCtl = TextEditingController();
  final commentCtl = TextEditingController();
  final nameCtl = TextEditingController();
  final appRoachTimeCtl = TextEditingController();
  final repetitionsTimeCtl = TextEditingController();

  final List<Map<String, TextEditingController>> exerciseControllers = [];

  void _addExercise() {
    setState(() {
      exerciseControllers.add({
        'nameCtl': TextEditingController(),
        'approachCtl': TextEditingController(),
        'repetitionsCtl': TextEditingController(),
        'commentCtl': TextEditingController(),
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            context.read<HomeCubit>().clear();
          },
          icon: SvgPicture.asset(
            'assets/icons/back_icon.svg',
            height: 24,
            fit: BoxFit.cover,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox.shrink(),
            Text(
              'New training',
              style: AppTextStyles.styleF20WNormal(),
              textAlign: TextAlign.center,
            ),
            BlocBuilder<PurposesCubit, PurposesState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    final stateHome = context.read<HomeCubit>().state;
                    if (typeCtl.text.isNotEmpty &&
                        durationCtl.text.isNotEmpty &&
                        commentCtl.text.isNotEmpty) {
                      List<NewTrainingExerciseModel> exercises =
                          exerciseControllers.map((controllers) {
                        return NewTrainingExerciseModel(
                          name: controllers['nameCtl']!.text,
                          approach: controllers['approachCtl']!.text,
                          repetition: controllers['repetitionsCtl']!.text,
                          comment: controllers['commentCtl']!.text,
                        );
                      }).toList();
                      context.read<HomeCubit>().createNewTraining(
                            context,
                            NewTrainingModel(
                              date: state.date ??
                                  DateFormat('dd.MM.yyyy')
                                      .format(DateTime.now()),
                              time: state.time ??
                                  DateFormat('HH:mm').format(DateTime.now()),
                              typeOfTraining: typeCtl.text,
                              duration:
                                  '${durationCtl.text} ${stateHome.durationNewTraining ?? 'mins'}',
                              newTrainingExerciseModel: exercises,
                              comment: commentCtl.text,
                              image: stateHome.image,
                            ),
                          );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          Future.delayed(const Duration(seconds: 1), () {
                            Navigator.of(context).pop(true);
                          });
                          return const AlertDialog(
                            title: Text(
                              'Validation Error',
                              textAlign: TextAlign.center,
                            ),
                            content: Text(
                              'Please fill out all fields.',
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(70, 34),
                    backgroundColor: AppColors.red,
                  ),
                  child: Text(
                    'Save',
                    style: AppTextStyles.styleF14WNormal(
                      color: AppColors.white,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      DateTime date = DateTime.now();
                      showCupertinoModalPopup<void>(
                        context: context,
                        builder: (BuildContext context) => Container(
                          height: 216,
                          padding: const EdgeInsets.only(top: 6.0),
                          margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          color: CupertinoColors.systemBackground
                              .resolveFrom(context),
                          child: SafeArea(
                            top: false,
                            child: CupertinoDatePicker(
                              initialDateTime: date,
                              mode: CupertinoDatePickerMode.date,
                              use24hFormat: true,
                              showDayOfWeek: true,
                              onDateTimeChanged: (DateTime newDate) {
                                String formattedDate =
                                    DateFormat('dd.MM.yyyy').format(newDate);
                                context
                                    .read<PurposesCubit>()
                                    .saveDate(TypeDateTime.date, formattedDate);
                              },
                            ),
                          ),
                        ),
                      );
                    },
                    child: BlocBuilder<PurposesCubit, PurposesState>(
                      builder: (context, state) {
                        return NewTraingDetailWidget(
                          title: 'Date',
                          date: state.date ??
                              DateFormat('dd.MM.yyyy').format(DateTime.now()),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () {
                      DateTime time = DateTime.now();
                      showCupertinoModalPopup<void>(
                        context: context,
                        builder: (BuildContext context) => Container(
                          height: 216,
                          padding: const EdgeInsets.only(top: 6.0),
                          margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          color: CupertinoColors.systemBackground
                              .resolveFrom(context),
                          child: SafeArea(
                            top: false,
                            child: CupertinoDatePicker(
                              initialDateTime: time,
                              mode: CupertinoDatePickerMode.time,
                              use24hFormat: true,
                              showDayOfWeek: true,
                              onDateTimeChanged: (DateTime newDate) {
                                String formattedTime =
                                    DateFormat('HH:mm').format(newDate);
                                context
                                    .read<PurposesCubit>()
                                    .saveDate(TypeDateTime.time, formattedTime);
                              },
                            ),
                          ),
                        ),
                      );
                    },
                    child: BlocBuilder<PurposesCubit, PurposesState>(
                      builder: (context, state) {
                        return NewTraingDetailWidget(
                          title: 'Time',
                          date: state.time ??
                              DateFormat('HH:mm').format(DateTime.now()),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFieldWidget(
                controller: typeCtl,
                text: 'Type of training',
                hintText: 'Type',
              ),
              const SizedBox(height: 16),
              TextFieldWidget(
                controller: durationCtl,
                text: 'Duration',
                hintText: 'Duration',
                keyboardType: TextInputType.number,
                isDuration: true,
              ),
              const SizedBox(height: 16),
              ...exerciseControllers.asMap().entries.map((entry) {
                int index = entry.key;
                var controllers = entry.value;
                return Column(
                  children: [
                    TextFieldWidget(
                      controller: controllers['nameCtl']!,
                      onChanged: (p0) {},
                      text: 'Exercise ${index + 1}',
                      hintText: '',
                      labelText: 'Name of exercise',
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextFieldWidget(
                            controller: controllers['approachCtl']!,
                            text: '',
                            hintText: '',
                            labelText: 'Approach, times',
                            isExercise: true,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFieldWidget(
                            controller: controllers['repetitionsCtl']!,
                            text: '',
                            hintText: '',
                            labelText: 'Repetitions, times',
                            isExercise: true,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFieldWidget(
                      controller: controllers['commentCtl']!,
                      text: '',
                      hintText: 'Comment',
                      labelText: 'Comment',
                      isExercise: true,
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              }),
              Align(
                alignment: Alignment.center,
                child: CustomElevatedBtn(
                  onPressed: _addExercise,
                  text: 'Add exercise',
                  isTraing: true,
                ),
              ),
              const SizedBox(height: 16),
              TextFieldWidget(
                controller: commentCtl,
                text: 'Comment',
                hintText: 'Comment',
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Add photo or video',
                    style: TextStyle(
                      fontFamily: 'Alata',
                      color: AppColors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 8),
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () {
                          context.read<HomeCubit>().takePhoto(context);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 169,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: const Color(0xffF1F1F1),
                          ),
                          child: state.image == null
                              ? Center(
                                  child: SvgPicture.asset(
                                    'assets/icons/camera.svg',
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.file(
                                    state.image!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
