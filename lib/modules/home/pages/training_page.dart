import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ninen/components/custom_container.dart';
import 'package:ninen/models/new_training_model.dart';
import 'package:ninen/theme/app_colors.dart';
import 'package:ninen/theme/app_text_styles.dart';

class TrainingPage extends StatelessWidget {
  const TrainingPage({super.key, required this.newTrainingModel});

  final NewTrainingModel newTrainingModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        surfaceTintColor: AppColors.white,
        backgroundColor: AppColors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset(
            'assets/icons/back_icon.svg',
            height: 24,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          'Training',
          style: AppTextStyles.styleF20WNormal(),
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                newTrainingModel.typeOfTraining,
                style: AppTextStyles.styleF20WNormal(),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Date',
                            style: AppTextStyles.styleF13W400(),
                          ),
                          Text(
                            newTrainingModel.date,
                            style: AppTextStyles.styleF16W400,
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Time',
                            style: AppTextStyles.styleF13W400(),
                          ),
                          Text(
                            newTrainingModel.time,
                            style: AppTextStyles.styleF16W400,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Duration',
                        style: AppTextStyles.styleF13W400(),
                      ),
                      Text(
                        newTrainingModel.duration,
                        style: AppTextStyles.styleF16W400,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Push-up',
                style: AppTextStyles.styleF20WNormal(),
              ),
              const SizedBox(height: 8),
              ListView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: newTrainingModel.newTrainingExerciseModel.length,
                itemBuilder: (context, index) {
                  final item = newTrainingModel.newTrainingExerciseModel[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CustomContainer(
                            title: 'Approach, times',
                            description: item.approach,
                          ),
                          const SizedBox(width: 12),
                          CustomContainer(
                            title: 'Repetitions, times',
                            description: item.repetition,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: CustomContainer(
                          title: 'Comment to exersize',
                          description: '${++index}.${item.name}',
                          subTitle: item.comment,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                },
              ),
              SizedBox(
                width: double.infinity,
                height: 169,
                child: Image.file(
                  newTrainingModel.image,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Comment to training',
                style: AppTextStyles.styleF14WNormal(),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: AppColors.grey,
                ),
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Arm Circles:',
                      style: AppTextStyles.styleF14WNormal(),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      newTrainingModel.comment,
                      style: AppTextStyles.styleF14WNormal(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
