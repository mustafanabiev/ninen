import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninen/components/custom_elevated_btn.dart';
import 'package:ninen/components/traing_widget.dart';
import 'package:ninen/modules/home/cubit/home_cubit.dart';
import 'package:ninen/modules/home/pages/new_training_page.dart';
import 'package:ninen/modules/home/pages/training_page.dart';
import 'package:ninen/theme/app_colors.dart';
import 'package:ninen/theme/app_text_styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        surfaceTintColor: AppColors.white,
        backgroundColor: AppColors.white,
        title: Text(
          'Trainings',
          style: AppTextStyles.styleF20WNormal(),
          textAlign: TextAlign.center,
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.newTraining.isEmpty) {
            return Center(
                child: Text(
              "You haven't added any\nworkouts yet :(",
              textAlign: TextAlign.center,
              style: AppTextStyles.styleF20WNormal(
                color: const Color(0xffBFBFBF),
              ),
            ));
          } else {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              itemCount: state.newTraining.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return TrainingPage(
                            newTrainingModel: state.newTraining[index],
                          );
                        },
                      ),
                    );
                  },
                  child: TraingWidget(
                    image: state.newTraining[index].image,
                    title: state.newTraining[index].typeOfTraining,
                    date: state.newTraining[index].date,
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomElevatedBtn(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const NewTrainingPage();
              },
            ),
          );
        },
        text: 'Add training',
        isProgess: false,
      ),
    );
  }
}
