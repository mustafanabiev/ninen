import 'package:flutter/material.dart';
import 'package:ninen/theme/app_colors.dart';
import 'package:ninen/theme/app_text_styles.dart';

class CustomProgressCard extends StatelessWidget {
  const CustomProgressCard({
    super.key,
    required this.title,
    required this.name,
    required this.controller,
  });

  final String title;
  final String name;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: AppTextStyles.styleF14WNormal(),
        ),
        const SizedBox(width: 20),
        Container(
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: AppColors.grey,
          ),
          padding: const EdgeInsets.all(8),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              labelText: name,
              labelStyle: AppTextStyles.styleF13W400(
                color: AppColors.greyText,
              ),
            ),
            style: AppTextStyles.styleF14WNormal(),
          ),
        )
      ],
    );
  }
}
