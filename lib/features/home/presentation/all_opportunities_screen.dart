import 'package:flutter/material.dart';
import 'package:ibraheemaltamim_flutter/helpers/ui_helpers.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/custom_appbar.dart';
import 'package:ibraheemaltamim_flutter/provider/opportunity_provider.dart';
import 'package:ibraheemaltamim_flutter/features/home/widgets/opportunity_card_widget.dart';
import 'package:ibraheemaltamim_flutter/helpers/navigation_service.dart';

class AllOpportunitiesScreen extends StatefulWidget {
  const AllOpportunitiesScreen({super.key});

  @override
  State<AllOpportunitiesScreen> createState() => _AllOpportunitiesScreenState();
}

class _AllOpportunitiesScreenState extends State<AllOpportunitiesScreen> {
  @override
  Widget build(BuildContext context) {
    final opportunityProvider = Provider.of<OpportunityProvider>(context);
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
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UIHelper.verticalSpace(10.h),
                        OpportunityCard(
                          opportunities: opportunityProvider.opportunities,
                          onFavoriteCountChanged: (count) {
                            // No longer needed as Provider handles this
                          },
                        ),
                      ],
                    ),
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
