import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/features/cordinator/widgets/coordinator_search_bar_widget.dart';
import 'package:ibraheemaltamim_flutter/features/cordinator/widgets/coordinator_submission_card.dart';

class AllResearchSubmitionScreen extends StatefulWidget {
  const AllResearchSubmitionScreen({super.key});

  @override
  State<AllResearchSubmitionScreen> createState() =>
      _AllResearchSubmitionScreenState();
}

class _AllResearchSubmitionScreenState
    extends State<AllResearchSubmitionScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _submissions = [
    {
      'title': 'Genetic predispositions to heart disease',
      'description':
          'Explore multi-generational genetic markers identifying early-stage cardiac risks in diverse',
      'author': 'Dr. Jhon Smith',
      'category': 'Neurologist',
      'image':
          'https://images.unsplash.com/photo-1507668077129-56e32842fceb?q=80&w=600&auto=format&fit=crop',
      'status': 'Pending Review',
      'statusColor': const Color(0xff9E77ED),
      'statusBg': const Color(0xffF4F3FF),
      'isFavorite': false,
    },
    {
      'title': 'Genetic predispositions to heart disease',
      'description':
          'Explore multi-generational genetic markers identifying early-stage cardiac risks in diverse',
      'author': 'Dr. Jhon Smith',
      'category': 'Neurologist',
      'image':
          'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?q=80&w=600&auto=format&fit=crop',
      'status': 'Pending Review',
      'statusColor': const Color(0xff9E77ED),
      'statusBg': const Color(0xffF4F3FF),
      'isFavorite': true,
    },
    {
      'title': 'Genetic predispositions to heart disease',
      'description':
          'Explore multi-generational genetic markers identifying early-stage cardiac risks in diverse',
      'author': 'Dr. Jhon Smith',
      'category': 'Neurologist',
      'image':
          'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?q=80&w=600&auto=format&fit=crop',
      'status': 'Approved',
      'statusColor': const Color(0xff12B76A),
      'statusBg': const Color(0xffD1FADF),
      'isFavorite': false,
    },
    {
      'title': 'Genetic predispositions to heart disease',
      'description':
          'Explore multi-generational genetic markers identifying early-stage cardiac risks in diverse',
      'author': 'Dr. Jhon Smith',
      'category': 'Neurologist',
      'image':
          'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?q=80&w=600&auto=format&fit=crop',
      'status': 'Approved',
      'statusColor': const Color(0xff12B76A),
      'statusBg': const Color(0xffD1FADF),
      'isFavorite': false,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xffD6F2FB,
      ), // Matching light blue background
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
                        color: Color(
                          0xffBCE8F7,
                        ), // slightly darker blue background
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
                    'All Research Submissions',
                    style: TextStyle(
                      color: const Color(0xff03045E),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Search Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CoordinatorSearchBarWidget(controller: _searchController),
            ),
            SizedBox(height: 20.h),
            // List of submissions
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
                itemCount: _submissions.length,
                separatorBuilder: (context, index) => SizedBox(height: 20.h),
                itemBuilder: (context, index) {
                  return CoordinatorSubmissionCard(item: _submissions[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
