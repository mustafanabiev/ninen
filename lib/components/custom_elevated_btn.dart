import 'package:flutter/material.dart';
import 'package:ninen/theme/app_colors.dart';

class CustomElevatedBtn extends StatelessWidget {
  const CustomElevatedBtn({
    super.key,
    this.onPressed,
    required this.text,
    this.isTraing = false,
    this.isProgess = false,
  });

  final void Function()? onPressed;
  final String text;
  final bool isTraing;
  final bool isProgess;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: !isProgess
          ? const Icon(
              Icons.add,
              color: AppColors.white,
            )
          : const SizedBox(),
      label: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Alata',
          color: AppColors.white,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: isTraing ? 10 : 16,
        ),
        backgroundColor: AppColors.red,
      ),
    );
  }
}
