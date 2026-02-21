import 'package:flutter/material.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/features/auth/forget_password/presentation/forget_password_screen.dart';
import 'package:ibraheemaltamim_flutter/features/navbar.dart';
import 'package:ibraheemaltamim_flutter/helpers/all_routes.dart';
import 'package:ibraheemaltamim_flutter/helpers/navigation_service.dart';
import 'package:ibraheemaltamim_flutter/helpers/toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // ------------ Variables start------------
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // ------------ Variables end------------

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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

  String? _passwordValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Password is required";
    }

    if (value.length < 6) {
      return "Password must be at least 6 characters";
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
                            'Log In',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: AppColor.textColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Hi! Welcome',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 22,
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
                          const SizedBox(height: 20),

                          // ------------ Password field start------------
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Password',
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
                                  hintText: 'Enter Your Password',
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
                          const SizedBox(height: 32),

                          // ------------ Login button start------------
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                if (_formKey.currentState!.validate()) {
                                  print("Form Valid ✅");
                                  NavigationService.navigateToReplacement(
                                    Routes.navbar,
                                  );
                                  ToastUtil.showShortToast(
                                    "Successfully Logged In",
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.buttonColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                'Log In',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          // ------------ Login button end------------
                          const SizedBox(height: 20),

                          // ------------ Forget password start------------
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgetPasswordScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Forgotten your password ?',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF0A1F44),
                              ),
                            ),
                          ),

                          // ------------ Forget password end------------
                          const Spacer(),

                          // ------------ Create account start------------
                          Padding(
                            padding: const EdgeInsets.only(bottom: 32),
                            child: Column(
                              children: [
                                const Text(
                                  "Don't have an account ?",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF1A1A1A),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                TextButton(
                                  onPressed: () {
                                    NavigationService.navigateTo(
                                      Routes.registerScreen,
                                    );
                                  },
                                  child: Text(
                                    'Create an Account',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: AppColor.textColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // ------------ Create account end------------
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
