// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_fonts.dart';

class CustomTextfieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function()? iconOnTap;
  final bool? enabled;
  final bool isIcon;
  final String? prefixText;
  final bool showError;
  final int maxLines;

  CustomTextfieldWidget({
    Key? key,
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.validator,
    this.isIcon = false,
    this.iconOnTap,
    this.enabled = true,
    this.prefixText,
    this.showError = true,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  State<CustomTextfieldWidget> createState() => _CustomTextfieldWidgetState();
}

class _CustomTextfieldWidgetState extends State<CustomTextfieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      enabled: widget.enabled,
      maxLines: widget.maxLines,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      cursorColor: AppColor.c434344,
      cursorRadius: const Radius.circular(8),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textAlignVertical: TextAlignVertical.center, // ensures vertical centering
      style: TextFontStyle.textStyle13PoppinsW500.copyWith(
        fontSize: 14.sp,
        color: AppColor.c797A7C,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            width: 1.w,
            color: AppColor.c797A7C.withOpacity(0.5),
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            width: 1.w,
            color: AppColor.c797A7C.withOpacity(0.5),
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            width: 1.w,
            color: AppColor.cB91C1C, // error red
          ),
        ),

        // ✅ THIS WAS MISSING
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            width: 1.w,
            color: AppColor.cB91C1C, // same error red
          ),
        ),

        hintText: widget.hintText,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),

        errorStyle:
            widget.showError ? null : const TextStyle(height: 0, fontSize: 0),

        prefixText: widget.prefixText,
        prefixStyle: TextFontStyle.textStyle13PoppinsW500.copyWith(
          fontSize: 14.sp,
          color: AppColor.c797A7C,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
