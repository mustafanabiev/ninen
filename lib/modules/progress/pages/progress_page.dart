import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninen/components/custom_elevated_btn.dart';
import 'package:ninen/components/custom_progress_card.dart';
import 'package:ninen/modules/progress/cubit/progress_cubit.dart';
import 'package:ninen/modules/progress/pages/before_and_after_page.dart';
import 'package:ninen/modules/progress/pages/chart_page.dart';
import 'package:ninen/theme/app_colors.dart';
import 'package:ninen/theme/app_text_styles.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  bool weight = true;
  bool waist = false;
  bool biceps = false;
  final weightCtl = TextEditingController();
  final waistCtl = TextEditingController();
  final bicepsCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        surfaceTintColor: AppColors.white,
        backgroundColor: AppColors.white,
        title: Text(
          'Progress',
          style: AppTextStyles.styleF20WNormal(),
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Today's figures",
                    style: AppTextStyles.styleF20WNormal(),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (weightCtl.text.isNotEmpty &&
                          waistCtl.text.isNotEmpty &&
                          bicepsCtl.text.isNotEmpty) {
                        context.read<ProgressCubit>().saveProgress(
                              context,
                              int.parse(weightCtl.text),
                              int.parse(waistCtl.text),
                              int.parse(bicepsCtl.text),
                            );
                        weightCtl.clear();
                        waistCtl.clear();
                        bicepsCtl.clear();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(70, 34),
                      backgroundColor: AppColors.red,
                    ),
                    child: Text(
                      'Save',
                      style:
                          AppTextStyles.styleF14WNormal(color: AppColors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CustomProgressCard(
                controller: weightCtl,
                title: 'Weight',
                name: 'kg',
              ),
              const SizedBox(height: 12),
              CustomProgressCard(
                controller: waistCtl,
                title: 'Waist circumference',
                name: 'cm',
              ),
              const SizedBox(height: 12),
              CustomProgressCard(
                controller: bicepsCtl,
                title: 'Biceps circumference',
                name: 'cm',
              ),
              const SizedBox(height: 26),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: AppColors.grey,
                ),
                width: double.infinity,
                height: 4,
              ),
              const SizedBox(height: 26),
              Row(
                children: [
                  ProgressGraficWidget(
                    onTap: () {
                      setState(() {
                        weight = true;
                        waist = false;
                        biceps = false;
                      });
                    },
                    text: 'Weight',
                    isActive: weight,
                  ),
                  const Spacer(),
                  ProgressGraficWidget(
                    onTap: () {
                      setState(() {
                        weight = false;
                        waist = true;
                        biceps = false;
                      });
                    },
                    text: 'Waist\ncircumference',
                    isActive: waist,
                  ),
                  const Spacer(),
                  ProgressGraficWidget(
                    onTap: () {
                      setState(() {
                        weight = false;
                        waist = false;
                        biceps = true;
                      });
                    },
                    text: 'Biceps\ncircumference',
                    isActive: biceps,
                  ),
                ],
              ),
              const SizedBox(height: 26),
              BlocBuilder<ProgressCubit, ProgressState>(
                builder: (context, state) {
                  return SizedBox(
                    child: weight
                        ? LineChartSample2(
                            datas: state.weightList ?? [],
                          )
                        : waist
                            ? LineChartSample2(
                                datas: state.waistList ?? [],
                              )
                            : biceps
                                ? LineChartSample2(
                                    datas: state.bicepsList ?? [],
                                  )
                                : const SizedBox(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomElevatedBtn(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const BeforeAndAfterPage();
              },
            ),
          );
        },
        text: 'Before and after',
        isProgess: true,
      ),
    );
  }
}

class ProgressGraficWidget extends StatelessWidget {
  const ProgressGraficWidget({
    super.key,
    required this.text,
    required this.isActive,
    this.onTap,
  });

  final String text;
  final bool isActive;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 46,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: isActive ? AppColors.red : AppColors.grey,
        ),
        child: Center(
          child: Text(
            text,
            style: AppTextStyles.styleF14WNormal(
              color: isActive ? AppColors.white : AppColors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
