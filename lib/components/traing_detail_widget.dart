import 'package:flutter/material.dart';
import 'package:ninen/theme/app_colors.dart';

class NewTraingDetailWidget extends StatelessWidget {
  const NewTraingDetailWidget({
    super.key,
    required this.title,
    required this.date,
  });

  final String title;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Alata',
            color: AppColors.black,
            fontSize: 14.0,
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: const Color(0xffF1F1F1),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          child: Text(
            date,
            style: const TextStyle(
              fontFamily: 'Alata',
              color: AppColors.black,
              fontSize: 14.0,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
