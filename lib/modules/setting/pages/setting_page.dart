import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninen/components/setting_card_widget.dart';
import 'package:ninen/modules/home/cubit/home_cubit.dart';
import 'package:ninen/modules/setting/pages/premium_page.dart';
import 'package:ninen/theme/app_colors.dart';
import 'package:ninen/theme/app_text_styles.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        surfaceTintColor: AppColors.white,
        backgroundColor: AppColors.white,
        title: Text(
          'Settings',
          style: AppTextStyles.styleF20WNormal(),
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
        child: Column(
          children: [
            SettingCardWidget(
              onTap: () {},
              text: 'Privacy policy',
            ),
            SettingCardWidget(
              onTap: () {},
              text: 'Terms of use',
            ),
            SettingCardWidget(
              onTap: () {},
              text: 'Support',
            ),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state.premium != null && state.premium == true) {
                  return const SizedBox();
                } else {
                  return Column(
                    children: [
                      SettingCardWidget(
                        onTap: () {},
                        text: 'Restore purchases',
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PremiumPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            backgroundColor: AppColors.red,
                          ),
                          child: Text(
                            'Buy premium for 0,99\$',
                            style: AppTextStyles.styleF14WNormal(
                                color: AppColors.white),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
