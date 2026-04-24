import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/helpers/all_routes.dart';
import 'package:ibraheemaltamim_flutter/helpers/navigation_service.dart';
import 'package:ibraheemaltamim_flutter/networks/api_acess.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _nameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Name is required";
    }
    return null;
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
      return "Confirm password is required";
    }
    if (value != _passwordController.text) {
      return "Passwords do not match";
    }
    return null;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _birthdayController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      resizeToAvoidBottomInset: true,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60),

                // Title
                Text(
                  'Create Account',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                    color: AppColor.textColor,
                  ),
                ),
                const SizedBox(height: 10),

                // Subtitle
                Text(
                  'Fill your information below or register\nwith your social account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blueGrey.shade400,
                    fontSize: 13.5,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 36),

                // Name Field
                _buildInputField(
                  label: 'Name',
                  hint: 'Your Name',
                  controller: _nameController,
                  validator: _nameValidator,
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 24.h),

                // Email Field
                _buildInputField(
                  label: 'Email',
                  hint: 'Enter Your Email',
                  controller: _emailController,
                  validator: _emailValidator,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 24.h),

                // Password Field
                _buildInputField(
                  label: 'Password',
                  hint: 'Enter Your Password',
                  controller: _passwordController,
                  validator: _passwordValidator,
                  obscureText: _obscurePassword,
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
                SizedBox(height: 24.h),

                // Confirm Password Field
                _buildInputField(
                  label: 'Confirm Password',
                  hint: 'Confirm Your Password',
                  controller: _confirmPasswordController,
                  validator: _confirmPasswordValidator,
                  obscureText: _obscureConfirmPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.grey[600],
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),
                SizedBox(height: 32.h),

                // Next Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_isLoading) return;
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _isLoading = true;
                        });

                        final result = await registerRxObj.registerRx(
                          name: _nameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                          passwordConfirmation: _confirmPasswordController.text,
                        );

                        setState(() {
                          _isLoading = false;
                        });

                        if (result != null) {
                          NavigationService.navigateToWithArgs(
                            Routes.registerOtpVerificationScreen,
                            {"email": _emailController.text},
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.darkNavy,
                      // foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            child: CircularProgressIndicator(
                              color: AppColor.bgColor,
                              // strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Next',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 16),

                // Terms & Privacy Policy row
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Text(
                      'By creating an account, you agree to our ',
                      style: TextStyle(
                        color: Colors.blueGrey.shade400,
                        fontSize: 12.sp,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        NavigationService.navigateTo(
                          Routes.termsAndConditionScreen,
                        );
                      },
                      child: Text(
                        'Terms & Conditions',
                        style: TextStyle(
                          color: AppColor.darkNavy,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      ' and ',
                      style: TextStyle(
                        color: Colors.blueGrey.shade400,
                        fontSize: 12.sp,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        NavigationService.navigateTo(Routes.privacyScreen);
                      },
                      child: Text(
                        'Privacy Policy',
                        style: TextStyle(
                          color: AppColor.darkNavy,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // Log In row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account ? ',
                      style: TextStyle(
                        color: Colors.blueGrey.shade400,
                        fontSize: 13.5,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        NavigationService.navigateTo(Routes.loginScreen);
                      },
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          color: AppColor.darkNavy,
                          fontSize: 13.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    bool obscureText = false,
    bool readOnly = false,
    VoidCallback? onTap,
    Widget? suffixIcon,
  }) {
    return FormField<String>(
      validator: (_) => validator?.call(controller.text),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.bgColor,
                    borderRadius: BorderRadius.circular(100.r),
                    border: Border.all(
                      color: state.hasError
                          ? Colors.red
                          : Colors.blueGrey.shade400,
                      width: state.hasError ? 1.0 : .5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueGrey.withOpacity(0.06),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: controller,
                    obscureText: obscureText,
                    keyboardType: keyboardType,
                    readOnly: readOnly,
                    onTap: onTap,
                    onChanged: (value) {
                      state.didChange(value);
                    },
                    cursorRadius: const Radius.circular(12),
                    cursorColor: AppColor.textColor,
                    style: TextStyle(
                      color: AppColor.darkNavy.withOpacity(0.85),
                      fontSize: 15,
                    ),
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: TextStyle(
                        color: Colors.blueGrey.shade400,
                        fontSize: 15,
                      ),
                      suffixIcon: suffixIcon,
                      contentPadding: const EdgeInsets.fromLTRB(22, 20, 16, 20),
                      border: InputBorder.none,
                      errorStyle: const TextStyle(height: 0, fontSize: 0),
                    ),
                  ),
                ),
                Positioned(
                  top: -10,
                  left: 20,
                  child: Container(
                    color: AppColor.bgColor,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: state.hasError ? Colors.red : AppColor.textColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 4),
                child: Text(
                  state.errorText ?? '',
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }
}
