import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/custom_appbar.dart';
import 'package:ibraheemaltamim_flutter/helpers/all_routes.dart';
import 'package:ibraheemaltamim_flutter/helpers/navigation_service.dart';
import 'package:ibraheemaltamim_flutter/helpers/whatsapp_helper.dart';
import 'package:ibraheemaltamim_flutter/features/service/data/rx.dart';
import 'package:ibraheemaltamim_flutter/features/service/model/service_model.dart';
import 'package:ibraheemaltamim_flutter/features/service/widgets/service_card_widget.dart';
import 'package:ibraheemaltamim_flutter/networks/api_acess.dart';


class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  int? expandedIndex;

  final List<IconData> _icons = [
    Icons.bar_chart,
    Icons.find_in_page_outlined,
    Icons.draw_outlined,
    Icons.fact_check_outlined,
    Icons.track_changes,
    Icons.biotech,
  ];

  final List<Color> _iconColors = [
    const Color(0xFF20C997),
    const Color(0xFF9B51E0),
    const Color(0xFFE0519B),
    const Color(0xFFF43F5E),
    const Color(0xFFF97316),
    const Color(0xFF10B981),
  ];

  @override
  void initState() {
    super.initState();
    getServicesRx.fetchServices();
    whatsAppCallRxObj.fetchWhatsAppCall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                CustomAppbar(
                  title: 'Service',
                  onTap: () {
                    NavigationService.navigateToWithArgs(Routes.navbar, {
                      "pageNum": 0,
                    });
                  },
                ),
                Expanded(
                  child: StreamBuilder<ServiceModel>(
                    stream: getServicesRx.getFileData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting ||
                          snapshot.data?.data == null) {
                        return ListView.separated(
                          padding: EdgeInsets.only(
                            top: 10.h,
                            left: 20.w,
                            right: 20.w,
                            bottom: 100.h,
                          ),
                          itemCount: 6,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 16.h),
                          itemBuilder: (context, index) {
                            return ServiceCard(
                              service: Datum(
                                title: 'Loading Service Name...',
                                overview:
                                    'This is a placeholder for the service overview description.',
                                startingPrice: '000',
                              ),
                              isExpanded: false,
                              onTap: () {},
                              serviceIcon: _icons[index % _icons.length],
                              serviceColor:
                                  _iconColors[index % _iconColors.length],
                              isLoading: true,
                            );
                          },
                        );
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      final servicesList = snapshot.data?.data ?? [];
                      if (servicesList.isEmpty) {
                        return const Center(
                          child: Text('No services available.'),
                        );
                      }
                      return ListView.separated(
                        padding: EdgeInsets.only(
                          top: 10.h,
                          left: 20.w,
                          right: 20.w,
                          bottom: 100.h,
                        ),
                        itemCount: servicesList.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 16.h),
                        itemBuilder: (context, index) {
                          return ServiceCard(
                            service: servicesList[index],
                            isExpanded: expandedIndex == index,
                            onTap: () {
                              setState(() {
                                if (expandedIndex == index) {
                                  expandedIndex = null;
                                } else {
                                  expandedIndex = index;
                                }
                              });
                            },
                            serviceIcon: _icons[index % _icons.length],
                            serviceColor:
                                _iconColors[index % _iconColors.length],
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),

            // WhatsApp Button
            Positioned(
              right: 20.w,
              bottom: 105.h,
              child: GestureDetector(
                onTap: () => launchWhatsApp(context: context),
                child: Container(
                  width: 60.w,
                  height: 60.w,
                  decoration: BoxDecoration(
                    color: const Color(0xff000066),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/whatapp_icon.png',
                      width: 30.w,
                      height: 30.w,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
