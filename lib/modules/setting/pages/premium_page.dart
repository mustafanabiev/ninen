import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ninen/modules/home/cubit/home_cubit.dart';
import 'package:ninen/theme/app_colors.dart';
import 'package:ninen/theme/app_text_styles.dart';

class PremiumPage extends StatelessWidget {
  const PremiumPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        surfaceTintColor: AppColors.white,
        backgroundColor: AppColors.white,
        title: Text(
          'Premium',
          style: AppTextStyles.styleF20WNormal(),
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset('assets/icons/close.svg'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/icons/premium.svg',
              width: size.width * 0.8,
            ),
            const SizedBox(height: 36),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '1.',
                  style: AppTextStyles.styleF20WNormal(),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'Unlimited number of workout\nadditions',
                    style: AppTextStyles.styleF20WNormal(),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '2.',
                  style: AppTextStyles.styleF20WNormal(),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'Unlimited number of Purposes',
                    style: AppTextStyles.styleF20WNormal(),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  context.read<HomeCubit>().savePremium(true);
                  Navigator.pop(context);
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
                  style: AppTextStyles.styleF14WNormal(color: AppColors.white),
                  maxLines: 1,
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide()),
                    ),
                    child: Text(
                      'Privacy policy',
                      style: AppTextStyles.styleF14WNormal(),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide()),
                    ),
                    child: Text(
                      'Restore purchases',
                      style: AppTextStyles.styleF14WNormal(),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide()),
                    ),
                    child: Text(
                      'Terms of use',
                      style: AppTextStyles.styleF14WNormal(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
