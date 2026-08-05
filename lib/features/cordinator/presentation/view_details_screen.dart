import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewDetailsScreen extends StatefulWidget {
  const ViewDetailsScreen({super.key});

  @override
  State<ViewDetailsScreen> createState() => _ViewDetailsScreenState();
}

class _ViewDetailsScreenState extends State<ViewDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD6F2FB), // Matching light blue background
      body: SafeArea(
        child: Column(
          children: [
            // Custom Header Row with Back Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: const BoxDecoration(
                        color: Color(0xffBCE8F7), // slightly darker blue background
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: const Color(0xff03045E),
                        size: 20.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Text(
                    'View Details',
                    style: TextStyle(
                      color: const Color(0xff03045E),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Scrollable Main Content Card
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Main Title
                      Text(
                        'Genetic predispositions to heart disease',
                        style: TextStyle(
                          color: const Color(0xff03045E),
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      // Author
                      Row(
                        children: [
                          Icon(
                            Icons.person_outline,
                            color: const Color(0xff03045E),
                            size: 18.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Dr. Jhon Smith',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      // Description Section
                      _buildSectionHeader('DESCRIPTION'),
                      SizedBox(height: 8.h),
                      Text(
                        'This longitudinal study aims to identify key genetic markers associated with early-onset coronary artery disease in high-risk populations. By leveraging next-generation sequencing, we intend to map specific alleles that contribute to atherosclerotic plaque instability and cardiac events.',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 14.sp,
                          height: 1.5.h,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      // Research Objectives Section
                      _buildSectionHeader('RESEARCH OBJECTIVES'),
                      SizedBox(height: 8.h),
                      _buildBulletPoint('Determine the correlation between APOE4 variants and vascular inflammation scores.'),
                      SizedBox(height: 8.h),
                      _buildBulletPoint('Establish a predictive risk model for patients under 45 with family history of myocardial infarction.'),
                      SizedBox(height: 8.h),
                      _buildBulletPoint('Evaluate the impact of lifestyle interventions on gene expression within the PCSK9 pathway.'),
                      SizedBox(height: 24.h),
                      // Proposed Methodology Section
                      _buildSectionHeader('PROPOSED METHODOLOGY'),
                      SizedBox(height: 8.h),
                      Text(
                        'The study will recruit 5,000 participants over an 18-month period. Utilizing a double-blind protocol, blood samples will be analyzed for 256 specific heart-related SNPs. Data processing will involve AI-driven pattern recognition to isolate non-obvious multi-gene interactions previously overlooked in smaller cohort studies. All data will be stored on a HIPAA-compliant encrypted server.',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 14.sp,
                          height: 1.5.h,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      // PDF Download Card
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                        decoration: BoxDecoration(
                          color: const Color(0xffD6F2FB),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.picture_as_pdf_outlined,
                              color: const Color(0xff03045E),
                              size: 22.sp,
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Text(
                                'Methodology_Full_Protocol.pdf',
                                style: TextStyle(
                                  color: const Color(0xff03045E),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.file_download_outlined,
                              color: const Color(0xff03045E),
                              size: 22.sp,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),
                      // Timeline Notice Box
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: const Color(0xffF4F9FB),
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(color: const Color(0xffD6F2FB)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: const Color(0xff03045E),
                              size: 22.sp,
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Important Timeline Notice',
                                    style: TextStyle(
                                      color: const Color(0xff03045E),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    'This research proposal is subject to a strict 3-month review and approval deadline ending April 10, 2026.',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 13.sp,
                                      height: 1.4.h,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Bottom Action Buttons
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              color: const Color(0xffD6F2FB),
              child: Row(
                children: [
                  // Decline Button
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 50.h,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xffFDA29B)),
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xffD64545),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.cancel_outlined, size: 18.sp),
                            SizedBox(width: 8.w),
                            Text(
                              'Decline',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  // Approve Button
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff03045E),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check_circle_outline, size: 18.sp),
                            SizedBox(width: 8.w),
                            Text(
                              'Approve Research',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        color: const Color(0xff03045E),
        fontSize: 13.sp,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 6.h),
          child: Container(
            width: 6.w,
            height: 6.w,
            decoration: const BoxDecoration(
              color: Color(0xff03045E),
              shape: BoxShape.circle,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14.sp,
              height: 1.4.h,
            ),
          ),
        ),
      ],
    );
  }
}