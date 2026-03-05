import 'package:flutter/material.dart';
import 'package:ibraheemaltamim_flutter/features/home/widgets/wishlist_card_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/custom_appbar.dart';
import 'package:ibraheemaltamim_flutter/helpers/navigation_service.dart';
import 'package:ibraheemaltamim_flutter/features/home/model/wishlist_model.dart';
import 'package:ibraheemaltamim_flutter/helpers/ui_helpers.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final List<WishlistModel> wishLists = [
    WishlistModel(
      title: 'Assessing the Efficacy and Safety',
      description:
          'Explore gene therapy approaches for rare genetic diseases with our multidisciplinary team.',
      doctor: 'Dr. Jhon Smith',
      deadline: 'Mar 15, 2026',
      category: 'Neurologist',
      imageUrl: 'assets/images/img1.png',
      isFavorite: true,
    ),
    WishlistModel(
      title: 'Assessing the Efficacy and Safety',
      description:
          'Explore gene therapy approaches for rare genetic diseases with our multidisciplinary team.',
      doctor: 'Dr. Sarah Chen',
      deadline: 'Mar 15, 2026',
      category: 'Neurologist',
      imageUrl: 'assets/images/img2.png',
      isFavorite: true,
    ),
    WishlistModel(
      title: 'Assessing the Efficacy and Safety',
      description:
          'Explore gene therapy approaches for rare genetic diseases with our multidisciplinary team.',
      doctor: 'Dr. Jhon Smith',
      deadline: 'Mar 15, 2026',
      category: 'Neurologist',
      imageUrl: 'assets/images/img1.png',
      isFavorite: true,
    ),
    WishlistModel(
      title: 'Assessing the Efficacy and Safety',
      description:
          'Explore gene therapy approaches for rare genetic diseases with our multidisciplinary team.',
      doctor: 'Dr. Sarah Chen',
      deadline: 'Mar 15, 2026',
      category: 'Neurologist',
      imageUrl: 'assets/images/img2.png',
      isFavorite: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ------------custom appbar start -----------
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UIHelper.verticalSpace(10.h),
                    CustomAppbar(
                      title: 'Wishlist',
                      onTap: () {
                        NavigationService.goBack;
                      },
                    ),
                  ],
                ),
                // ------------custom appbar end-----------

                // ------------opportunity card-----------
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UIHelper.verticalSpace(10.h),
                        WishlistCardWidget(
                          wishLists: wishLists,
                          onFavoriteCountChanged: (count) {
                            // Local handling or ignored
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                // ------------opportunity end-----------
              ],
            ),
          ],
        ),
      ),
    );
  }
}
