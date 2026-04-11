import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_icons.dart';
import 'package:ibraheemaltamim_flutter/helpers/all_routes.dart';
import 'package:ibraheemaltamim_flutter/helpers/navigation_service.dart';
import 'package:ibraheemaltamim_flutter/helpers/toast.dart';
import 'package:ibraheemaltamim_flutter/networks/api_acess.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  // ------------ Variables start------------
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // ------------ Variables end------------

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  String? _emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email address";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: AppColor.bgColor,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            NavigationService.goBack;
          },
          icon: SvgPicture.asset(
            AppIcons.arrow_back,
            // color: AppColor.c333334,
            width: 15.w,
            height: 15.h,
            fit: BoxFit.contain,
          ),
        ),
        title: Text(
          'Forget Password',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: AppColor.textColor,
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 60),
                          Text(
                            'Enter your Email',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: AppColor.textColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'we‘ll send you a verification code',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: AppColor.textColor1,
                            ),
                          ),
                          const SizedBox(height: 48),

                          // ------------ Email Address field start------------
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Email Address',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF14304A),
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                validator: _emailValidator,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                cursorRadius: const Radius.circular(12),
                                cursorColor: AppColor.textColor,
                                controller: _emailController,
                                decoration: InputDecoration(
                                  hintText: 'Enter Your Email',
                                  hintStyle: TextStyle(
                                    color: AppColor.hintColor.withOpacity(0.5),
                                    fontSize: 14,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColor.hintColor.withOpacity(
                                        .06,
                                      ),
                                      width: 2.0,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColor.textColor.withOpacity(
                                        0.2,
                                      ),
                                      width: 2.0,
                                    ),
                                  ),
                                  errorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 2.0,
                                    ),
                                  ),
                                  focusedErrorBorder:
                                      const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 2.0,
                                    ),
                                  ),
                                  fillColor: const Color(0xFFCAF0F8),
                                ),
                              ),
                            ],
                          ),

                          // ------------ Email Address field end ------------
                          const SizedBox(height: 32),

                          // ------------ Login button start------------
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: () async {
                                FocusScope.of(context).unfocus();
                                if (_formKey.currentState!.validate()) {
                                  if (!_isLoading) {
                                    setState(() {
                                      _isLoading = true;
                                    });

                                    final result = await forgetPasswordRxObj
                                        .forgetPasswordRx(
                                      email: _emailController.text.trim(),
                                    );

                                    setState(() {
                                      _isLoading = false;
                                    });

                                    if (result) {
                                      NavigationService.navigateToWithArgs(
                                        Routes.setNewPasswordScreen,
                                        {"email": _emailController.text.trim()},
                                      );
                                    }
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.buttonColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                elevation: 0,
                              ),
                              child: _isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text(
                                      'Send Code',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),

                          // ------------ Login button end------------
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
