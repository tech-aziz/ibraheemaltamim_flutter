import 'package:flutter/material.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/helpers/all_routes.dart';
import 'package:ibraheemaltamim_flutter/helpers/navigation_service.dart';
import 'package:ibraheemaltamim_flutter/helpers/toast.dart';
import 'package:ibraheemaltamim_flutter/networks/api_acess.dart';

class SetNewPasswordScreen extends StatefulWidget {
  final String email;
  final String token;
  const SetNewPasswordScreen({
    super.key,
    required this.email,
    required this.token,
  });

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  // ------------ Variables start------------
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // ------------ Variables end------------

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }


  String? _passwordValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Password is required";
    }

    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }

    return null;
  }

  String? _confirmPasswordValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Confirmation is required";
    }

    if (value != _passwordController.text) {
      return "Passwords do not match";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      resizeToAvoidBottomInset: true,
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
                            'Set New Password',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: AppColor.textColor,
                            ),
                          ),

                          const SizedBox(height: 48),

                          // ------------ Password field start------------
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'New Password',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF14304A),
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                validator: _passwordValidator,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _passwordController,
                                obscureText: _obscurePassword,
                                cursorRadius: const Radius.circular(12),
                                cursorColor: AppColor.textColor,
                                decoration: InputDecoration(
                                  hintText: 'Enter Your New Password',
                                  hintStyle: TextStyle(
                                    color: AppColor.hintColor.withOpacity(0.5),
                                    fontSize: 14,
                                  ),
                                  fillColor: const Color(0xFFCAF0F8),
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
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: Colors.grey[600],
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // ------------ Password field end------------
                          const SizedBox(height: 20),

                          // ------------ Confirm Password field start------------
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Confirm New Password',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF14304A),
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                validator: _confirmPasswordValidator,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _confirmPasswordController,
                                obscureText: _obscureConfirmPassword,
                                cursorRadius: const Radius.circular(12),
                                cursorColor: AppColor.textColor,
                                decoration: InputDecoration(
                                  hintText: 'Confirm Your New Password',
                                  hintStyle: TextStyle(
                                    color: AppColor.hintColor.withOpacity(0.5),
                                    fontSize: 14,
                                  ),
                                  fillColor: const Color(0xFFCAF0F8),
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
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscureConfirmPassword
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: Colors.grey[600],
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscureConfirmPassword =
                                            !_obscureConfirmPassword;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),

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

                                    final result = await resetPasswordRxObj
                                        .resetPasswordRx(
                                          email: widget.email,
                                          token: widget.token,
                                          password: _passwordController.text,
                                          passwordConfirmation:
                                              _confirmPasswordController.text,
                                        );

                                    setState(() {
                                      _isLoading = false;
                                    });

                                    if (result) {
                                      NavigationService.navigateToReplacement(
                                        Routes.loginScreen,
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
                                  ? const SizedBox(
                                      child: CircularProgressIndicator(
                                        color: AppColor.bgColor,
                                        // strokeWidth: 2,
                                      ),
                                    )
                                  : const Text(
                                      'Continue',
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
