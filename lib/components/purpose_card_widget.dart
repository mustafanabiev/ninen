import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninen/models/purpose_model.dart';
import 'package:ninen/modules/purposes/cubit/purposes_cubit.dart';
import 'package:ninen/theme/app_colors.dart';
import 'package:ninen/theme/app_text_styles.dart';

class PurposeCardWidget extends StatefulWidget {
  const PurposeCardWidget({
    super.key,
    required this.purpose,
    required this.index,
  });

  final PurposeModel purpose;
  final int index;

  @override
  State<PurposeCardWidget> createState() => _PurposeCardWidgetState();
}

class _PurposeCardWidgetState extends State<PurposeCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFF1F1F1),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.purpose.purpose,
                  style: AppTextStyles.styleF14WNormal(),
                ),
                Text(
                  widget.purpose.deadline,
                  style: AppTextStyles.styleF13W400(
                    color: AppColors.greyText,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  child: Text(
                    widget.purpose.description,
                    style: AppTextStyles.styleF13W400(),
                  ),
                ),
              ],
            ),
          ),
          Checkbox(
            activeColor: Colors.red,
            checkColor: Colors.white,
            value: widget.purpose.isCheck,
            onChanged: (bool? value) {
              context.read<PurposesCubit>().toggleIsCheck(widget.index);
              setState(() {
                widget.purpose.isCheck = value!;
              });
            },
          ),
        ],
      ),
    );
  }
}
