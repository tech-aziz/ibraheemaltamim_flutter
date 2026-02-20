// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/circular_icon_btn.dart';

class CustomAppbar extends StatefulWidget {
  final String title;
  final void Function()? onTap;

  CustomAppbar({super.key, this.onTap, required this.title});

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircularIconBtn(icon: Icons.arrow_back, onTap: widget.onTap ?? () {}),

        SizedBox(width: 12.w),
        Text(
          widget.title,
          style: TextStyle(
            color: AppColor.textColor,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
