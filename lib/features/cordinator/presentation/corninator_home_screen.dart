import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/features/cordinator/presentation/chat_screen.dart';
import 'package:ibraheemaltamim_flutter/features/cordinator/presentation/cordinator_profile_screen.dart';
import 'package:ibraheemaltamim_flutter/features/cordinator/widgets/coordinator_bottom_nav_bar.dart';
import 'package:ibraheemaltamim_flutter/features/cordinator/widgets/coordinator_header_widget.dart';
import 'package:ibraheemaltamim_flutter/features/cordinator/widgets/coordinator_pending_review_banner.dart';
import 'package:ibraheemaltamim_flutter/features/cordinator/widgets/coordinator_search_bar_widget.dart';
import 'package:ibraheemaltamim_flutter/features/cordinator/widgets/coordinator_submissions_list_widget.dart';

class CorninatorHomeScreen extends StatefulWidget {
  const CorninatorHomeScreen({super.key});

  @override
  State<CorninatorHomeScreen> createState() => _CorninatorHomeScreenState();
}

class _CorninatorHomeScreenState extends State<CorninatorHomeScreen> {
  int _selectedIndex = 0;
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
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD6F2FB),
      body: SafeArea(
        child: Stack(
          children: [
            IndexedStack(
              index: _selectedIndex,
              children: [
                // Tab 0: Home Dashboard
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.fromLTRB(20.w, 15.h, 20.w, 110.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CoordinatorHeaderWidget(),
                            SizedBox(height: 20.h),
                            CoordinatorSearchBarWidget(
                              controller: _searchController,
                            ),
                            SizedBox(height: 20.h),
                            const CoordinatorPendingReviewBanner(),
                            SizedBox(height: 25.h),
                            CoordinatorSubmissionsListWidget(
                              submissions: _submissions,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // Tab 1: Chat Screen
                const ChatScreen(),
                // Tab 2: Profile Screen
                const CordinatorProfileScreen(),
              ],
            ),
            CoordinatorBottomNavBar(
              selectedIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
