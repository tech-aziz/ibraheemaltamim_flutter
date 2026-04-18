import 'package:flutter/material.dart';
import 'package:ibraheemaltamim_flutter/features/home/widgets/wishlist_card_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/custom_appbar.dart';
import 'package:ibraheemaltamim_flutter/helpers/navigation_service.dart';
import 'package:ibraheemaltamim_flutter/features/home/model/wish_list_model.dart';
import 'package:ibraheemaltamim_flutter/features/home/data/rx_wishlist/rx.dart';
import 'package:ibraheemaltamim_flutter/helpers/ui_helpers.dart';
import 'package:shimmer/shimmer.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}
class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    super.initState();
    getWishlistRx.fetchWishlist();
  }

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
                  child: StreamBuilder<WishListModel>(
                    stream: getWishlistRx.getFileData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting ||
                          snapshot.data?.data == null) {
                        return const WishlistCardWidget(
                          wishLists: [],
                          isLoading: true,
                        );
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      
                      final dataList = snapshot.data?.data ?? [];
                      if (dataList.isEmpty) {
                        return const Center(child: Text('No favorites found.'));
                      }

                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            UIHelper.verticalSpace(10.h),
                            WishlistCardWidget(
                              wishLists: dataList,
                              onFavoriteCountChanged: (count) {
                                // Local handling or ignored
                              },
                            ),
                          ],
                        ),
                      );
                    },
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
