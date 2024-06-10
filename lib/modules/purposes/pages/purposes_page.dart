import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ninen/components/custom_elevated_btn.dart';
import 'package:ninen/components/purpose_card_widget.dart';
import 'package:ninen/components/text_field_widget.dart';
import 'package:ninen/components/traing_detail_widget.dart';
import 'package:ninen/models/purpose_model.dart';
import 'package:ninen/modules/purposes/cubit/purposes_cubit.dart';
import 'package:ninen/theme/app_colors.dart';
import 'package:ninen/theme/app_text_styles.dart';

class PurposesPage extends StatefulWidget {
  const PurposesPage({super.key});

  @override
  State<PurposesPage> createState() => _PurposesPageState();
}

class _PurposesPageState extends State<PurposesPage> {
  final purpose = TextEditingController();
  final description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        surfaceTintColor: AppColors.white,
        backgroundColor: AppColors.white,
        title: Text(
          'Purposes',
          style: AppTextStyles.styleF20WNormal(),
          textAlign: TextAlign.center,
        ),
      ),
      body: BlocBuilder<PurposesCubit, PurposesState>(
        builder: (context, state) {
          if (state.purposes.isEmpty) {
            return Center(
              child: Text(
                "You haven't added any\npurpose yet :(",
                style: AppTextStyles.styleF20WNormal(
                  color: const Color(0xffBFBFBF),
                ),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.purposes.length,
              itemBuilder: (context, index) {
                return PurposeCardWidget(
                  purpose: state.purposes[index],
                  index: index,
                );
              },
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomElevatedBtn(
        onPressed: () {
          DateTime date = DateTime(2016, 10, 26);
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                insetPadding: const EdgeInsets.symmetric(horizontal: 16),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(17),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x1A000000),
                            offset: Offset(0, 4),
                            blurRadius: 20.8,
                          ),
                        ],
                      ),
                      width: constraints.maxWidth,
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: Text(
                              'New purpose',
                              style: AppTextStyles.styleF20WNormal(),
                            ),
                          ),
                          const SizedBox(height: 24),
                          GestureDetector(
                            onTap: () {
                              showCupertinoModalPopup<void>(
                                context: context,
                                builder: (BuildContext context) => Container(
                                  height: 216,
                                  padding: const EdgeInsets.only(top: 6.0),
                                  margin: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom,
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
                                            DateFormat('dd.MM.yyyy')
                                                .format(newDate);
                                        context.read<PurposesCubit>().saveDate(
                                            TypeDateTime.date, formattedDate);
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: BlocBuilder<PurposesCubit, PurposesState>(
                              builder: (context, state) {
                                return NewTraingDetailWidget(
                                  title: 'Deadline',
                                  date: state.date ??
                                      DateFormat('dd.MM.yyyy')
                                          .format(DateTime.now()),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFieldWidget(
                            controller: purpose,
                            text: 'Purpose',
                            hintText: 'Improve stamina',
                          ),
                          const SizedBox(height: 20),
                          TextFieldWidget(
                            controller: description,
                            text: 'Description',
                            hintText: 'Improve stamina',
                            isComment: true,
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                final date =
                                    context.read<PurposesCubit>().state.date;
                                if (purpose.text.isNotEmpty &&
                                    description.text.isNotEmpty) {
                                  context.read<PurposesCubit>().addPurpose(
                                        context,
                                        PurposeModel(
                                          deadline: date ??
                                              DateFormat('dd.MM.yyyy')
                                                  .format(DateTime.now()),
                                          purpose: purpose.text,
                                          description: description.text,
                                          isCheck: false,
                                        ),
                                      );
                                  context.read<PurposesCubit>().saveDate(
                                        TypeDateTime.date,
                                        DateFormat('dd.MM.yyyy').format(
                                          DateTime.now(),
                                        ),
                                      );
                                  purpose.clear();
                                  description.clear();
                                  Navigator.pop(context);
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
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
        text: 'Add purpose',
        isProgess: false,
      ),
    );
  }
}
