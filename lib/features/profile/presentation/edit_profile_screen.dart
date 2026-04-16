import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/custom_appbar.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/profile_avatar.dart';
import 'package:ibraheemaltamim_flutter/features/profile/model/user_info_model.dart';
import 'package:ibraheemaltamim_flutter/helpers/navigation_service.dart';
import 'package:ibraheemaltamim_flutter/helpers/toast.dart';
import 'package:ibraheemaltamim_flutter/networks/api_acess.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  File? _imageFile;
  String? _initialAvatarUrl;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is Data) {
        _nameController.text = args.name ?? '';
        _genderController.text = args.gender ?? '';
        _dobController.text = args.birthdate?.toString() ?? '';
        _initialAvatarUrl = args.avatar;
      }
      _isInitialized = true;
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 50, // Reduces memory usage to prevent OOM crash (white screen)
      );
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      ToastUtil.showShortToast("Error picking image: $e");
    }
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Camera'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 20)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _showGenderPicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: ['male', 'female', 'others'].map((gender) {
            return ListTile(
              title: Text(gender[0].toUpperCase() + gender.substring(1)),
              onTap: () {
                setState(() {
                  _genderController.text = gender;
                });
                Navigator.of(context).pop();
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  Future<void> _handleSave() async {
    if (_nameController.text.trim().isEmpty) {
      ToastUtil.showShortToast("Name is required");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      bool success = await updateProfileRxObj.updateProfile(
        name: _nameController.text.trim(),
        gender: _genderController.text.toLowerCase(),
        birthdate: _dobController.text.trim().isEmpty ? null : _dobController.text.trim(),
        avatar: _imageFile,
      );

      if (success) {
        userInfoRxObj.fetchUserInfo();
        NavigationService.goBack;
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _genderController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  CustomAppbar(
                    title: 'Edit Profile',
                    onTap: () {
                      NavigationService.goBack;
                    },
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Personal Information',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.textColor,
                                ),
                              ),
                              GestureDetector(
                                onTap: _isLoading ? null : _handleSave,
                                child: Text(
                                  _isLoading ? 'Saving...' : 'Save',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xff323280),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 25.h),
                          _buildPhotoUpload(),
                          SizedBox(height: 30.h),
                          _buildTextField(
                            label: 'Name',
                            controller: _nameController,
                            hint: 'Enter your name',
                          ),
                          SizedBox(height: 20.h),
                          _buildTextField(
                            label: 'Gender',
                            controller: _genderController,
                            hint: 'Select gender',
                            readOnly: true,
                            onTap: _showGenderPicker,
                          ),
                          SizedBox(height: 20.h),
                          _buildTextField(
                            label: 'Date of birth',
                            controller: _dobController,
                            hint: 'YYYY-MM-DD',
                            readOnly: true,
                            onTap: () => _selectDate(context),
                          ),
                          SizedBox(height: 10.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoUpload() {
    return Column(
      children: [
        Stack(
          children: [
            ProfileAvatar(
              imageFile: _imageFile,
              imageUrl: _initialAvatarUrl,
              radius: 40,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () => _showImageSourceActionSheet(context),
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: const BoxDecoration(
                    color: Color(0xff323280),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 16.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15.h),
        GestureDetector(
          onTap: () => _showImageSourceActionSheet(context),
          child: Text(
            'Upload Profile Photo',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xff323280),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColor.textColor,
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xffD1F1F9).withOpacity(0.5),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: TextField(
              controller: controller,
              readOnly: readOnly,
              onTap: onTap,
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColor.textColor.withOpacity(0.8),
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  fontSize: 16.sp,
                  color: AppColor.textColor.withOpacity(0.5),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 15.w,
                  vertical: 15.h,
                ),
                border: InputBorder.none,
                enabled: !readOnly || onTap != null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
