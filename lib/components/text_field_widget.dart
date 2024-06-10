import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninen/modules/home/cubit/home_cubit.dart';
import 'package:ninen/theme/app_colors.dart';
import 'package:ninen/theme/app_text_styles.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.text,
    required this.hintText,
    this.labelText,
    this.keyboardType,
    this.onChanged,
    this.isDuration = false,
    this.isExercise = false,
    this.isComment = false,
  });

  final TextEditingController controller;
  final String text;
  final String hintText;
  final String? labelText;
  final bool isDuration;
  final bool isExercise;
  final bool isComment;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  final List<String> items = [
    'mins',
    'secs',
  ];

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        !widget.isExercise
            ? Text(
                widget.text,
                style: const TextStyle(
                  fontFamily: 'Alata',
                  color: AppColors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                ),
              )
            : const SizedBox(),
        SizedBox(height: !widget.isExercise ? 8 : 0),
        Container(
          height: widget.labelText != null
              ? 62
              : widget.isComment
                  ? 62
                  : 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: const Color(0xffF1F1F1),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: widget.isDuration
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: widget.onChanged,
                        controller: widget.controller,
                        keyboardType: widget.keyboardType,
                        style: AppTextStyles.styleF14WNormal(),
                        maxLines: widget.isComment ? 3 : 1,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: widget.labelText != null ? 4 : 10,
                          ),
                          border: InputBorder.none,
                          hintText: widget.hintText,
                          hintStyle: AppTextStyles.styleF14WNormal(),
                          labelText: widget.labelText,
                          labelStyle: AppTextStyles.styleF14WNormal(
                            color: const Color(0xff818181),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.white,
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          style: AppTextStyles.styleF14WNormal(),
                          isExpanded: true,
                          hint: Text(
                            'Min',
                            style: AppTextStyles.styleF14WNormal(),
                          ),
                          items: items
                              .map((String item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: AppTextStyles.styleF14WNormal(),
                                    ),
                                  ))
                              .toList(),
                          value: selectedValue,
                          onChanged: (String? value) {
                            if (value != null) {
                              context.read<HomeCubit>().saveDuration(value);
                            }
                            setState(() {
                              selectedValue = value;
                            });
                          },
                          iconStyleData: const IconStyleData(
                            icon: Icon(Icons.keyboard_arrow_down),
                          ),
                          buttonStyleData: const ButtonStyleData(
                            height: 40,
                            width: 65,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: TextField(
                    onChanged: widget.onChanged,
                    controller: widget.controller,
                    keyboardType: widget.keyboardType,
                    style: AppTextStyles.styleF14WNormal(),
                    maxLines: widget.isComment ? 3 : 1,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: widget.labelText != null ? 4 : 10,
                      ),
                      border: InputBorder.none,
                      hintText: widget.hintText,
                      hintStyle: AppTextStyles.styleF14WNormal(),
                      labelText: widget.labelText,
                      labelStyle: AppTextStyles.styleF14WNormal(
                        color: const Color(0xff818181),
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
