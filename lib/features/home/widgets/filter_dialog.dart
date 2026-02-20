import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({super.key});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  String selectedPlace = 'Online';
  String selectedExperience = 'Beginner';

  String? selectedSpeciality;
  String? selectedStudyDesign;
  String? selectedContribution;
  String? selectedUniversity;

  final List<String> specialities = [
    'Neurologist',
    'Cardiologist',
    'Pediatrician',
    'General Surgeon',
    'Dermatologist',
  ];

  final List<String> studyDesigns = [
    'Systematic Review',
    'Meta-Analysis',
    'Original Research',
    'Case Study',
  ];

  final List<String> contributionTypes = [
    'Author',
    'Co-Author',
    'Reviewer',
    'Researcher',
  ];

  final List<String> universities = [
    'Harvard University',
    'Mayo Clinic',
    'Johns Hopkins',
    'Stanford Medical',
    'Oxford University',
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.bgColor,
          borderRadius: BorderRadius.circular(30.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filter Options',
                    style: TextStyle(
                      color: AppColor.textColor,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      color: AppColor.textColor,
                      size: 24.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25.h),
              _buildDropdownLabel('Speciality'),
              _buildDropdownField(
                selectedSpeciality ?? 'Choose options',
                specialities,
                (val) => setState(() => selectedSpeciality = val),
              ),
              SizedBox(height: 20.h),
              _buildDropdownLabel('Study Design Type'),
              _buildDropdownField(
                selectedStudyDesign ?? 'Choose options',
                studyDesigns,
                (val) => setState(() => selectedStudyDesign = val),
              ),
              SizedBox(height: 20.h),
              _buildDropdownLabel('Contribution Type'),
              _buildDropdownField(
                selectedContribution ?? 'Choose options',
                contributionTypes,
                (val) => setState(() => selectedContribution = val),
              ),
              SizedBox(height: 20.h),
              _buildDropdownLabel('Targeted University / Hospital'),
              _buildDropdownField(
                selectedUniversity ?? 'Choose options',
                universities,
                (val) => setState(() => selectedUniversity = val),
              ),
              SizedBox(height: 25.h),
              _buildDropdownLabel('Place'),
              Row(
                children: [
                  _buildChip('Online', selectedPlace == 'Online', (val) {
                    setState(() => selectedPlace = 'Online');
                  }),
                  SizedBox(width: 12.w),
                  _buildChip('On Campus', selectedPlace == 'On Campus', (val) {
                    setState(() => selectedPlace = 'On Campus');
                  }),
                ],
              ),
              SizedBox(height: 25.h),
              _buildDropdownLabel('Experience Level'),
              Wrap(
                spacing: 12.w,
                runSpacing: 12.h,
                children: [
                  _buildChip('Beginner', selectedExperience == 'Beginner', (
                    val,
                  ) {
                    setState(() => selectedExperience = 'Beginner');
                  }),
                  _buildChip(
                    'Intermediate',
                    selectedExperience == 'Intermediate',
                    (val) {
                      setState(() => selectedExperience = 'Intermediate');
                    },
                  ),
                  _buildChip('Advanced', selectedExperience == 'Advanced', (
                    val,
                  ) {
                    setState(() => selectedExperience = 'Advanced');
                  }),
                  _buildChip('Any', selectedExperience == 'Any', (val) {
                    setState(() => selectedExperience = 'Any');
                  }),
                ],
              ),
              SizedBox(height: 40.h),
              Center(
                child: GestureDetector(
                  onTap: () {
                    // TODO: Pass filter values back to HomeScreen
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: AppColor.buttonColor,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Center(
                      child: Text(
                        'Apply Filters',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Text(
        label,
        style: TextStyle(
          color: AppColor.textColor1,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildDropdownField(
    String selectedValue,
    List<String> options,
    Function(String?) onChanged,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: options.contains(selectedValue) ? selectedValue : null,
          hint: Text(
            selectedValue,
            style: TextStyle(color: Colors.black26, fontSize: 16.sp),
          ),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.black45,
            size: 24.sp,
          ),
          isExpanded: true,
          items: options.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(color: AppColor.textColor, fontSize: 16.sp),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildChip(String label, bool isSelected, Function(bool) onSelected) {
    return GestureDetector(
      onTap: () => onSelected(!isSelected),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFBDE0FE)
              : const Color(0xFFCAF0F8).withOpacity(0.5),
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.black12,
            width: 0.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: const Color(0xFF0077B6),
            fontSize: 14.sp,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
