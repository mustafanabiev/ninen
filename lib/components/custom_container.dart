import 'package:flutter/material.dart';
import 'package:ninen/theme/app_colors.dart';
import 'package:ninen/theme/app_text_styles.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.title,
    required this.description,
    this.subTitle,
  });

  final String title;
  final String description;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: AppColors.grey,
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.styleF13W400(
              color: AppColors.greyText,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: AppTextStyles.styleF14WNormal(),
          ),
          if (subTitle != null)
            Column(
              children: [
                const SizedBox(height: 16),
                Text(
                  subTitle!,
                  style: AppTextStyles.styleF14WNormal(),
                ),
              ],
            )
          else
            const SizedBox(),
        ],
      ),
    );
  }
}
