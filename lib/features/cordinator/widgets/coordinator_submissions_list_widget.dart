import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/features/cordinator/widgets/coordinator_submission_card.dart';
import 'package:ibraheemaltamim_flutter/helpers/all_routes.dart';
import 'package:ibraheemaltamim_flutter/helpers/navigation_service.dart';

class CoordinatorSubmissionsListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> submissions;
  const CoordinatorSubmissionsListWidget({super.key, required this.submissions});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Research Submissions',
              style: TextStyle(
                color: const Color(0xff03045E),
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {
                NavigationService.navigateTo(Routes.allResearchSubmitionScreen);
              },
              child: Text(
                'View all',
                style: TextStyle(
                  color: const Color(0xff03045E),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15.h),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: submissions.length,
          separatorBuilder: (context, index) => SizedBox(height: 20.h),
          itemBuilder: (context, index) {
            final item = submissions[index];
            return CoordinatorSubmissionCard(item: item);
          },
        ),
      ],
    );
  }
}
