// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtons extends StatelessWidget {
  CustomButtons({
    super.key,
    required this.name,
    required this.bgColor,
    this.textColor,
    required this.callback,
    this.borderColor,
    this.textStyle,
  });
  final String name;
  final Color bgColor;
  final Color? textColor;
  final VoidCallback callback;
  final Color? borderColor;
  TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.r),
            color: bgColor,
            border:
                Border.all(width: 1, color: borderColor ?? Colors.transparent)),
        child: Center(
          child: Text(name, style: textStyle),
        ),
      ),
    );
  }
}
