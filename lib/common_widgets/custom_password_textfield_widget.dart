// // ignore_for_file: must_be_immutable

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
// import 'package:ibraheemaltamim_flutter/assets_helper/app_fonts.dart';
// import 'package:ibraheemaltamim_flutter/assets_helper/app_icons.dart';


// class CustomPasswordTextfieldWidget extends StatefulWidget {
//   TextEditingController passwordController;

//   final String hintText;
//   final String? Function(String?)? validator;
//   final bool showError;

//   CustomPasswordTextfieldWidget({
//     Key? key,
//     required this.hintText,
//     required this.passwordController,
//     this.validator,
//     this.showError = true,
//   }) : super(key: key);

//   @override
//   State<CustomPasswordTextfieldWidget> createState() =>
//       _CustomPasswordTextfieldWidgetState();
// }

// class _CustomPasswordTextfieldWidgetState
//     extends State<CustomPasswordTextfieldWidget> {
//   bool _obscureText = true;

//   // at least 8 characters, 1 uppercase, 1 lowercase, 1 number and 1 special character.

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: widget.passwordController,
//       validator: widget.validator,
//       obscureText: _obscureText,
//       keyboardType: TextInputType.text,
//       cursorColor: AppColor.c266FEF,
//       cursorRadius: const Radius.circular(8),
//       autovalidateMode: AutovalidateMode.onUserInteraction,
//       textAlignVertical: TextAlignVertical.center,
//       style: TextFontStyle.textStyle13PoppinsW500.copyWith(
//         fontSize: 14.sp,
//         color: AppColor.c797A7C,
//         fontWeight: FontWeight.w400,
//       ),
//       decoration: InputDecoration(
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12.r),
//           borderSide: BorderSide(
//             width: 1.w,
//             color: AppColor.c797A7C.withOpacity(0.5),
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12.r),
//           borderSide: BorderSide(
//             width: 1.w,
//             color: AppColor.c797A7C.withOpacity(0.5),
//           ),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12.r),
//           borderSide: BorderSide(
//             width: 1.w,
//             color: AppColor.cB91C1C, // error red
//           ),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12.r),
//           borderSide: BorderSide(
//             width: 1.w,
//             color: AppColor.cB91C1C, // same error red
//           ),
//         ),
//         hintText: widget.hintText,
//         isDense: true,
//         contentPadding: EdgeInsets.symmetric(
//           horizontal: 16.w,
//           vertical: 16.h,
//         ),
//         errorStyle:
//             widget.showError ? null : const TextStyle(height: 0, fontSize: 0),
//         suffixIcon: GestureDetector(
//           onTap: () {
//             setState(() {
//               _obscureText = !_obscureText;
//             });
//           },
//           child: Padding(
//             padding: EdgeInsets.all(12.w),
//             child: SvgPicture.asset(
//               _obscureText ? AppIcons.eye_off : AppIcons.eye_open,
//               width: 20.w,
//               height: 20.h,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
