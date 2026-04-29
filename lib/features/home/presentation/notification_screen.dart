import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/custom_appbar.dart';
import 'package:ibraheemaltamim_flutter/features/home/model/get_all_notification_list_model.dart';
import 'package:ibraheemaltamim_flutter/helpers/all_routes.dart';
import 'package:ibraheemaltamim_flutter/helpers/navigation_service.dart';
import 'package:ibraheemaltamim_flutter/helpers/toast.dart';
import 'package:ibraheemaltamim_flutter/networks/api_acess.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool _isSelectionMode = false;
  String? _deletedMessage;

  @override
  void initState() {
    super.initState();
    getAllNotificationListRxObj.fetchNotifications();
  }

  void _showDeleteAllDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Text(
          'Delete All Notifications',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColor.textColor,
          ),
        ),
        content: Text(
          'Are you sure you want to delete all notifications?',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              setState(() {
                _isSelectionMode = false;
              });
            },
            child: Text(
              'No',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey[500],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              setState(() {
                _isSelectionMode = false;
              });
              final result = await deleteAllNotificationsRxObj.deleteAll();
              if (result != null && result.status == true) {
                // Clear local list immediately
                getAllNotificationListRxObj.clearAll();
                setState(() {
                  _deletedMessage =
                      result.message ?? 'All notifications deleted.';
                });
              }
            },
            child: Text(
              'Yes',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppbar(
              title: _isSelectionMode ? 'All Selected' : 'Notifications',
              onTap: () {
                if (_isSelectionMode) {
                  setState(() {
                    _isSelectionMode = false;
                  });
                } else {
                  NavigationService.goBack;
                }
              },
              trailing: _isSelectionMode
                  ? GestureDetector(
                      onTap: () => _showDeleteAllDialog(context),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          'Delete All',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  : StreamBuilder<GetAllNotificationListModel>(
                      stream: getAllNotificationListRxObj.getFileData,
                      builder: (context, snapshot) {
                        return GestureDetector(
                          onTap: () {
                            final notifications = snapshot.data?.data ?? [];
                            final unreadIds = notifications
                                .where((n) => n.readAt == null)
                                .map((n) => n.id!)
                                .toList();

                            if (unreadIds.isNotEmpty) {
                              markAsReadRxObj.markAsRead(unreadIds);
                              getAllNotificationListRxObj.markAsReadLocally(
                                unreadIds,
                              );
                            } else {
                              ToastUtil.showShortToast(
                                'No unread notifications',
                              );
                            }
                          },
                          child: Text(
                            'Mark all read',
                            style: TextStyle(
                              color: const Color(0xFF0077B6),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Expanded(
              child: StreamBuilder<GetAllNotificationListModel>(
                stream: getAllNotificationListRxObj.getFileData,
                builder: (context, snapshot) {
                  bool isLoading =
                      snapshot.connectionState == ConnectionState.waiting ||
                      !snapshot.hasData;

                  if (snapshot.hasError) {
                    return Center(child: Text('Error loading notifications'));
                  }

                  List<Datum> notifications = snapshot.data?.data ?? [];

                  // Show API message after delete all
                  if (_deletedMessage != null) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.notifications_off_outlined,
                            size: 64.sp,
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            _deletedMessage!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  if (!isLoading && notifications.isEmpty) {
                    return Center(child: Text('No notifications found'));
                  }

                  return Skeletonizer(
                    enabled: isLoading,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 10.h,
                      ),
                      itemCount: isLoading ? 5 : notifications.length,
                      itemBuilder: (context, index) {
                        if (isLoading) {
                          return _buildNotificationCard(
                            Datum(
                              data: DatumData(
                                title: 'Loading Notification Title',
                                message:
                                    'Loading notification description and message detail',
                                type: 'Category',
                                timestamp: DateTime.now(),
                              ),
                              readAt: null,
                            ),
                          );
                        }
                        return _buildNotificationCard(notifications[index]);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard(Datum datum) {
    bool isUnread = datum.readAt == null;
    final notificationData = datum.data;

    String title = notificationData?.title ?? 'No Title';
    String description = notificationData?.message ?? 'No Description';
    String category = notificationData?.type ?? 'General';
    String time = notificationData?.timestamp != null
        ? DateFormat('EEE MMM d h:mma').format(notificationData!.timestamp!)
        : (datum.createdAt != null
              ? DateFormat('EEE MMM d h:mma').format(datum.createdAt!)
              : '');

    IconData icon = Icons.notifications_none_rounded;
    Color iconBg = const Color(0xFFE7F5FF);
    Color iconColor = const Color(0xFF339AF0);

    if (category.toLowerCase().contains('deadline')) {
      icon = Icons.access_time_rounded;
      iconBg = const Color(0xFFFFE3E3);
      iconColor = Colors.red;
    } else if (category.toLowerCase().contains('submission')) {
      icon = Icons.check_circle_outline_rounded;
      iconBg = const Color(0xFFE3FAF3);
      iconColor = const Color(0xFF20C997);
    }

    return Dismissible(
      key: Key(datum.id.toString()),
      direction: _isSelectionMode
          ? DismissDirection.none
          : DismissDirection.endToStart,
      onDismissed: (direction) {
        if (datum.id != null) {
          final deletedId = datum.id!;
          getAllNotificationListRxObj.deleteNotificationLocally(deletedId);
          deleteSingleNotificationRxObj.deleteNotification(deletedId);
        }
      },
      background: Container(
        margin: EdgeInsets.only(bottom: 15.h),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(20.r),
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Icon(Icons.delete, color: Colors.white, size: 28.sp),
      ),
      child: GestureDetector(
        onLongPress: () {
          setState(() {
            _isSelectionMode = true;
          });
        },
        onTap: () {
          if (_isSelectionMode) {
            // Already in selection mode — do nothing on tap
            return;
          }
          if (datum.id != null) {
            if (isUnread) {
              markAsReadRxObj.markAsRead([datum.id!]);
              getAllNotificationListRxObj.markAsReadLocally([datum.id!]);
            }
            NavigationService.navigateToWithObject(
              Routes.notificationDetailsScreen,
              datum,
            );
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.only(bottom: 15.h),
          padding: EdgeInsets.all(15.w),
          decoration: BoxDecoration(
            color: _isSelectionMode
                ? const Color(0xFFFFE3E3)
                : (isUnread ? Colors.white : Colors.grey[200]),
            borderRadius: BorderRadius.circular(20.r),
            border: _isSelectionMode
                ? Border.all(color: Colors.red, width: 1.5)
                : (isUnread
                      ? Border(
                          left: BorderSide(
                            color: const Color(0xFF0077B6),
                            width: 4.w,
                          ),
                        )
                      : null),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_isSelectionMode)
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.red,
                    size: 24.sp,
                  ),
                )
              else if (notificationData?.image != null &&
                  notificationData!.image!.isNotEmpty)
                ClipOval(
                  child: Image.network(
                    notificationData.image!,
                    width: 44.w,
                    height: 44.w,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Skeletonizer(
                        enabled: true,
                        child: Container(
                          width: 44.w,
                          height: 44.w,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: iconBg,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, color: iconColor, size: 24.sp),
                    ),
                  ),
                )
              else
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: iconBg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: iconColor, size: 24.sp),
                ),
              SizedBox(width: 15.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColor.textColor,
                            ),
                          ),
                        ),
                        if (isUnread && !_isSelectionMode)
                          Container(
                            width: 8.w,
                            height: 8.w,
                            decoration: const BoxDecoration(
                              color: Color(0xFF0077B6),
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 12.h),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          datum.createdAt != null
                              ? DateFormat(
                                  'EEE MMM d h:mma',
                                ).format(datum.createdAt!)
                              : '',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
