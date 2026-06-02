import 'package:flutter/material.dart';
import 'package:ibraheemaltamim_flutter/helpers/ui_helpers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/custom_appbar.dart';
import 'package:ibraheemaltamim_flutter/features/home/widgets/opportunity_card_widget.dart';
import 'package:ibraheemaltamim_flutter/helpers/navigation_service.dart';
import 'package:ibraheemaltamim_flutter/features/home/model/opportunity_list_model.dart';
import 'package:ibraheemaltamim_flutter/features/home/data/rx_opportunity_list/rx.dart';

class AllOpportunitiesScreen extends StatefulWidget {
  const AllOpportunitiesScreen({super.key});

  @override
  State<AllOpportunitiesScreen> createState() => _AllOpportunitiesScreenState();
}

class _AllOpportunitiesScreenState extends State<AllOpportunitiesScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getOpportunitiesRx.fetchOpportunities(isRefresh: true);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      if (getOpportunitiesRx.hasMoreData) {
        getOpportunitiesRx.fetchOpportunities(isRefresh: false);
      }
    }
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    CustomAppbar(
                      title: 'All Opportunities',
                      onTap: () {
                        NavigationService.goBack;
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: StreamBuilder<OpportunityListModel>(
                    stream: getOpportunitiesRx.getFileData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting ||
                          snapshot.data?.data == null) {
                        return const SingleChildScrollView(
                          child: OpportunityCard(
                            opportunities: [],
                            isLoading: true,
                          ),
                        );
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      
                      final list = snapshot.data?.data ?? [];
                      if (list.isEmpty) {
                        return const Center(child: Text('No opportunities available.'));
                      }

                      return SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            UIHelper.verticalSpace(10.h),
                            OpportunityCard(
                              opportunities: list,
                              onFavoriteCountChanged: (count) {
                                // Handled via API/Rx eventually
                              },
                            ),
                            if (getOpportunitiesRx.hasMoreData)
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 20.h),
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
