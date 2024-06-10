import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ninen/theme/app_text_styles.dart';

class TraingWidget extends StatelessWidget {
  const TraingWidget({
    super.key,
    required this.image,
    required this.title,
    required this.date,
  });

  final File image;
  final String title;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      height: 190,
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                child: Image.file(
                  image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              color: const Color(0xffF1F1F1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.styleF14WNormal(),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    date,
                    style: AppTextStyles.styleF14WNormal(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
