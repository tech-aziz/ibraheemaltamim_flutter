import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/features/home/model/filter_list_model.dart';
import 'package:ibraheemaltamim_flutter/networks/api_acess.dart';
import 'package:ibraheemaltamim_flutter/features/home/data/rx_opportunity_list/rx.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({super.key});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  String? selectedPlace;
  int? selectedPlaceId;
  String? selectedExperience;
  int? selectedExperienceId;

  String? selectedSpeciality;
  int? selectedSpecialityId;
  String? selectedStudyDesign;
  int? selectedStudyDesignId;
  String? selectedContribution;
  int? selectedContributionId;
  String? selectedUniversity;
  int? selectedUniversityId;
  bool _isApplying = false;

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
  void initState() {
    super.initState();
    filterListRxObj.fetchFilterList('speciality');
    studentDesignListRxObj.fetchFilterList('student_design_type');
    contributionListRxObj.fetchFilterList('contribution_type');
    universityHospitalListRxObj.fetchFilterList('university_hospital');
    placeListRxObj.fetchFilterList('place').then((model) {
      if (model != null && model.data != null && model.data!.isNotEmpty) {
        if (selectedPlaceId == null) {
          setState(() {
            selectedPlace = model.data!.first.name;
            selectedPlaceId = model.data!.first.id;
            if (selectedPlaceId != null) {
              log('Selected Place ID: $selectedPlaceId');
            }
          });
        }
      }
    });
    experienceLevelListRxObj.fetchFilterList('experience_level').then((model) {
      if (model != null && model.data != null && model.data!.isNotEmpty) {
        if (selectedExperienceId == null) {
          setState(() {
            selectedExperience = model.data!.first.name;
            selectedExperienceId = model.data!.first.id;
            if (selectedExperienceId != null) {
              log('Selected Experience Level ID: $selectedExperienceId');
            }
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
      backgroundColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          IgnorePointer(
            ignoring: _isApplying,
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
              ValueListenableBuilder<bool>(
                valueListenable: filterListRxObj.isLoading,
                builder: (context, isLoading, child) {
                  return StreamBuilder<FilterListModel>(
                    stream: filterListRxObj.dataFetcher.stream,
                    builder: (context, snapshot) {
                      List<Datum> items = snapshot.data?.data ?? [];
                      final List<String> options = items.isEmpty
                          ? [selectedSpeciality ?? 'Choose options']
                          : items.map((e) => e.name ?? '').toList();

                      return Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          _buildDropdownField(
                            selectedSpeciality ?? 'Choose options',
                            options,
                            (val) {
                              if (items.isEmpty) return;
                              setState(() {
                                selectedSpeciality = val;
                                final selectedItem = items.firstWhere(
                                  (element) => element.name == val,
                                  orElse: () => Datum(),
                                );
                                selectedSpecialityId = selectedItem.id;
                                if (selectedSpecialityId != null) {
                                  log(
                                    'Selected Speciality ID: $selectedSpecialityId',
                                  );
                                }
                              });
                            },
                            onTap: () {
                              filterListRxObj.fetchFilterList('speciality');
                            },
                          ),
                          if (isLoading)
                            Padding(
                              padding: EdgeInsets.only(right: 40.w),
                              child: SizedBox(
                                width: 15.w,
                                height: 15.w,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 20.h),
              _buildDropdownLabel('Study Design Type'),
              ValueListenableBuilder<bool>(
                valueListenable: studentDesignListRxObj.isLoading,
                builder: (context, isLoading, child) {
                  return StreamBuilder<FilterListModel>(
                    stream: studentDesignListRxObj.dataFetcher.stream,
                    builder: (context, snapshot) {
                      List<Datum> items = snapshot.data?.data ?? [];
                      final List<String> options = items.isEmpty
                          ? [selectedStudyDesign ?? 'Choose options']
                          : items.map((e) => e.name ?? '').toList();

                      return Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          _buildDropdownField(
                            selectedStudyDesign ?? 'Choose options',
                            options,
                            (val) {
                              if (items.isEmpty) return;
                              setState(() {
                                selectedStudyDesign = val;
                                final selectedItem = items.firstWhere(
                                  (element) => element.name == val,
                                  orElse: () => Datum(),
                                );
                                selectedStudyDesignId = selectedItem.id;
                                if (selectedStudyDesignId != null) {
                                  log(
                                    'Selected Study Design ID: $selectedStudyDesignId',
                                  );
                                }
                              });
                            },
                            onTap: () {
                              studentDesignListRxObj.fetchFilterList(
                                'student_design_type',
                              );
                            },
                          ),
                          if (isLoading)
                            Padding(
                              padding: EdgeInsets.only(right: 40.w),
                              child: SizedBox(
                                width: 15.w,
                                height: 15.w,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 20.h),
              _buildDropdownLabel('Contribution Type'),
              ValueListenableBuilder<bool>(
                valueListenable: contributionListRxObj.isLoading,
                builder: (context, isLoading, child) {
                  return StreamBuilder<FilterListModel>(
                    stream: contributionListRxObj.dataFetcher.stream,
                    builder: (context, snapshot) {
                      List<Datum> items = snapshot.data?.data ?? [];
                      final List<String> options = items.isEmpty
                          ? [selectedContribution ?? 'Choose options']
                          : items.map((e) => e.name ?? '').toList();

                      return Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          _buildDropdownField(
                            selectedContribution ?? 'Choose options',
                            options,
                            (val) {
                              if (items.isEmpty) return;
                              setState(() {
                                selectedContribution = val;
                                final selectedItem = items.firstWhere(
                                  (element) => element.name == val,
                                  orElse: () => Datum(),
                                );
                                selectedContributionId = selectedItem.id;
                                if (selectedContributionId != null) {
                                  log(
                                    'Selected Contribution ID: $selectedContributionId',
                                  );
                                }
                              });
                            },
                            onTap: () {
                              contributionListRxObj.fetchFilterList(
                                'contribution_type',
                              );
                            },
                          ),
                          if (isLoading)
                            Padding(
                              padding: EdgeInsets.only(right: 40.w),
                              child: SizedBox(
                                width: 15.w,
                                height: 15.w,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 20.h),
              _buildDropdownLabel('Targeted University / Hospital'),
              ValueListenableBuilder<bool>(
                valueListenable: universityHospitalListRxObj.isLoading,
                builder: (context, isLoading, child) {
                  return StreamBuilder<FilterListModel>(
                    stream: universityHospitalListRxObj.dataFetcher.stream,
                    builder: (context, snapshot) {
                      List<Datum> items = snapshot.data?.data ?? [];
                      final List<String> options = items.isEmpty
                          ? [selectedUniversity ?? 'Choose options']
                          : items.map((e) => e.name ?? '').toList();

                      return Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          _buildDropdownField(
                            selectedUniversity ?? 'Choose options',
                            options,
                            (val) {
                              if (items.isEmpty) return;
                              setState(() {
                                selectedUniversity = val;
                                final selectedItem = items.firstWhere(
                                  (element) => element.name == val,
                                  orElse: () => Datum(),
                                );
                                selectedUniversityId = selectedItem.id;
                                if (selectedUniversityId != null) {
                                  log(
                                    'Selected University ID: $selectedUniversityId',
                                  );
                                }
                              });
                            },
                            onTap: () {
                              universityHospitalListRxObj.fetchFilterList(
                                'university_hospital',
                              );
                            },
                          ),
                          if (isLoading)
                            Padding(
                              padding: EdgeInsets.only(right: 40.w),
                              child: SizedBox(
                                width: 15.w,
                                height: 15.w,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 25.h),
              _buildDropdownLabel('Place'),
              StreamBuilder<FilterListModel>(
                stream: placeListRxObj.dataFetcher.stream,
                builder: (context, snapshot) {
                  List<Datum> items = snapshot.data?.data ?? [];
                  return Container(
                    child: Wrap(
                      spacing: 12.w,
                      runSpacing: 12.h,
                      children: items.map((item) {
                        final isSelected = selectedPlaceId == item.id;
                        return _buildChip(item.name ?? '', isSelected, (val) {
                          setState(() {
                            selectedPlace = item.name;
                            selectedPlaceId = item.id;
                            if (selectedPlaceId != null) {
                              log('Selected Place ID: $selectedPlaceId');
                            }
                          });
                        });
                      }).toList(),
                    ),
                  );
                },
              ),
              SizedBox(height: 25.h),
              _buildDropdownLabel('Experience Level'),
              ValueListenableBuilder<bool>(
                valueListenable: experienceLevelListRxObj.isLoading,
                builder: (context, isLoading, child) {
                  return StreamBuilder<FilterListModel>(
                    stream: experienceLevelListRxObj.dataFetcher.stream,
                    builder: (context, snapshot) {
                      List<Datum> items =
                          snapshot.data?.data ??
                          List.generate(
                            4,
                            (index) => Datum(id: index, name: 'Loading...'),
                          );
                      return Skeletonizer(
                        enabled: isLoading && snapshot.data == null,
                        child: Wrap(
                          spacing: 12.w,
                          runSpacing: 12.h,
                          children: items.map((item) {
                            final isSelected = selectedExperienceId == item.id;
                            return _buildChip(item.name ?? '', isSelected, (
                              val,
                            ) {
                              setState(() {
                                selectedExperience = item.name;
                                selectedExperienceId = item.id;
                                if (selectedExperienceId != null) {
                                  log(
                                    'Selected Experience Level ID: $selectedExperienceId',
                                  );
                                }
                              });
                            });
                          }).toList(),
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 20.h),
              SizedBox(height: 40.h),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    setState(() => _isApplying = true);
                    try {
                      await getOpportunitiesRx.fetchOpportunities(
                        filters: {
                          'speciality_ids[]': selectedSpecialityId,
                          'studydesign_type_ids[]': selectedStudyDesignId,
                          'contribution_type_ids[]': selectedContributionId,
                          'university_hospital_ids[]': selectedUniversityId,
                          'place_ids[]': selectedPlaceId,
                          'experience_level_ids[]': selectedExperienceId,
                        },
                      );
                      if (mounted) {
                        Navigator.pop(context);
                      }
                    } catch (e) {
                      if (mounted) {
                        setState(() => _isApplying = false);
                      }
                    }
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
    ),
      if (_isApplying)
        Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
              ),
            ],
          ),
          child: const CircularProgressIndicator(),
        ),
    ],
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
    Function(String?) onChanged, {
    VoidCallback? onTap,
  }) {
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
          onTap: onTap,
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
