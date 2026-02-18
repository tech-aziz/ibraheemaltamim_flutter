// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {

//   // ----------------- TextEditingController for phone number input -----------------
//   TextEditingController numberController = TextEditingController();

//   // ----------------- Form key for validation -----------------
//   final _formKey = GlobalKey<FormState>();

//   // ----------------- Error message variable (optional, not currently used) -----------------
//   String? phoneError;

//   // ----------------- Loading state to prevent double taps -----------------
//   bool _isLoading = false;

//   @override
//   void dispose() {
//     // ----------------- Dispose controller when widget is removed -----------------
//     numberController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors
//           .white, // ----------------- Screen background color -----------------
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//               horizontal: 16
//                   .w), // ----------------- Horizontal padding -----------------
//           child: Form(
//             key:
//                 _formKey, // ----------------- Attach form key for validation -----------------
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: SingleChildScrollView(
//                     physics:
//                         const BouncingScrollPhysics(), // ----------------- Scroll behavior -----------------
//                     child: Column(
//                       children: [
//                         UIHelper.verticalSpace(110
//                             .h), // ----------------- Top spacing -----------------
//                         const CustomLogoWidget(), // ----------------- App logo -----------------
//                         UIHelper.verticalSpace(79
//                             .h), // ----------------- Spacing after logo -----------------
//                         customTextWidget(
//                           name: 'Welcome to Porichalok'
//                               .tr, // ----------------- Welcome text -----------------
//                           alignment: Alignment.center,
//                           style: TextFontStyle.textStyle13PoppinsW500.copyWith(
//                             fontWeight: FontWeight.w600,
//                             color: AppColor.c333334,
//                             fontSize: 24.sp,
//                             height: 1.2,
//                           ),
//                         ),
//                         UIHelper.verticalSpace(32
//                             .h), // ----------------- Spacing before mobile number label -----------------
//                         customTextWidget(
//                             name: 'Mobile number'.tr,
//                             alignment: Alignment
//                                 .centerLeft), // ----------------- Mobile number label -----------------
//                         UIHelper.verticalSpace(8.h),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // ----------------- Phone number input field -----------------
//                             CustomTextfieldWidget(
//                               hintText: 'Enter your phone number'.tr,
//                               controller: numberController,
//                               showError: false,
//                               keyboardType: TextInputType.phone,
//                               validator: (value) {
//                                 String? error;
//                                 // ----------------- Check if empty -----------------
//                                 if (value == null || value.isEmpty) {
//                                   error = 'Please enter your phone number'.tr;
//                                 } else {
//                                   // ----------------- Remove whitespace -----------------
//                                   String cleanedValue =
//                                       value.replaceAll(RegExp(r'\s+'), '');

//                                   // ----------------- Check exact length (Remaining digits for 11 digits) -----------------
//                                   if (cleanedValue.length != 11) {
//                                     error = 'Phone number must be 11 digits'.tr;
//                                   } else if (!RegExp(r'^[0-9]+$')
//                                       .hasMatch(cleanedValue)) {
//                                     // ----------------- Check digits only -----------------
//                                     error =
//                                         'Phone number must contain only digits'
//                                             .tr;
//                                   }
//                                 }

//                                 if (error != phoneError) {
//                                   WidgetsBinding.instance
//                                       .addPostFrameCallback((_) {
//                                     if (mounted) {
//                                       setState(() {
//                                         phoneError = error;
//                                       });
//                                     }
//                                   });
//                                 }

//                                 return error; // ----------------- Validation passed or failed -----------------
//                               },
//                             ),
//                             if (phoneError != null)
//                               Text(
//                                 phoneError!,
//                                 style: TextFontStyle.textStyle13PoppinsW500
//                                     .copyWith(
//                                   fontSize: 12.sp,
//                                   color: AppColor.cE01F44,
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Column(
//                   children: [
//                     UIHelper.verticalSpace(20.h),
//                     // ----------------- Register button -----------------
//                     CustomButton(
//                       backgroundColor: AppColor.primaryColor,
//                       text: 'Register'.tr,
//                       onPressed: () async {
//                         // ----------------- Prevent double taps -----------------
//                         if (_isLoading) return;

//                         // ----------------- Validate form fields -----------------
//                         if (!_formKey.currentState!.validate()) {
//                           return;
//                         }

//                         // ----------------- Set loading state -----------------
//                         setState(() {
//                           _isLoading = true;
//                         });

//                         try {
//                           // ----------------- Format phone number for API -----------------
//                           String number = numberController.text.trim();
//                           // Prepend '01' as it's fixed in the UI
//                           final formattedPhone = '$number';
//                           // ------------- Log the provided phone number -------------
//                           print('Provided phone number: $formattedPhone');

//                           // ----------------- Get user role from local storage -----------------
//                           final role = appData.read(kKeyUserRole).toString();
//                           print('selected role: $role');

//                           // ----------------- Call API for registration -----------------
//                           final success = await registerRxObj
//                               .registerRx(
//                                 phone: formattedPhone,
//                                 role: role,
//                               )
//                               .waitingForFuture();

//                           // ----------------- Navigate to OTP verification screen if successful -----------------
//                           if (success && mounted) {
//                             NavigationService.navigateToWithArgs(
//                               Routes.registerOtpVerificationScreen,
//                               {
//                                 "phoneNumber": number,
//                               },
//                             );
//                           }
//                         } catch (error) {
//                           // ----------------- Errors handled inside Rx class -----------------
//                         } finally {
//                           // ----------------- Reset loading state -----------------
//                           if (mounted) {
//                             setState(() {
//                               _isLoading = false;
//                             });
//                           }
//                         }
//                       },
//                     ),
//                     UIHelper.verticalSpace(15.h),
//                     // ----------------- Link to login screen -----------------
//                     Center(
//                       child: Text.rich(
//                         TextSpan(
//                           children: [
//                             TextSpan(
//                               text: 'Have an account?'.tr,
//                               style:
//                                   TextFontStyle.textStyle13PoppinsW500.copyWith(
//                                 fontWeight: FontWeight.w400,
//                                 color: AppColor.c797A7C,
//                                 fontSize: 12.sp,
//                                 height: 1.2,
//                               ),
//                             ),
//                             TextSpan(
//                               text: ' Log In'.tr,
//                               style:
//                                   TextFontStyle.textStyle13PoppinsW500.copyWith(
//                                 fontWeight: FontWeight.w500,
//                                 color: AppColor.primaryColor,
//                                 fontSize: 12.sp,
//                                 height: 1.2,
//                               ),
//                               recognizer: TapGestureRecognizer()
//                                 ..onTap = () {
//                                   NavigationService.navigateTo(Routes
//                                       .loginScreen); // ----------------- Navigate to login screen -----------------
//                                 },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     UIHelper.verticalSpace(34.h),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
