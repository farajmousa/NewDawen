import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import 'package:sky_vacation/data/model/entity/notification_data.dart';
import 'package:sky_vacation/helper/localize.dart';
import 'package:sky_vacation/ui/bloc/notifications.dart';
import '../../base/result.dart';
import '../../di/injection_container.dart';
import '../../helper/app_color.dart';
import '../../helper/dim.dart';
import '../../main.dart';
import '../components/notification_list_view_vertical.dart';
import '../widgets/loading_indicator.dart';


class NotificationScreen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends ResumableState<NotificationScreen> {
  final NotificationsBloc _notificationsBloc = sl<NotificationsBloc>();

  List<NotificationData> notificationList = [];

  bool isLoading = false;
  bool noResults = false;

  refresh() {
    if (mounted) setState(() {});
  }

  loading(bool load) {
    isLoading = load;
    refresh();
  }

  @override
  void initState() {
    _notificationsBloc.mainStream.listen(observeNotificationList);
    _notificationsBloc.getNotifications();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onResume() {
    super.onResume();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: comp.appBar(Trans.of(context).t("notificationText"), backTapped: () {
      }, showBack: false),
      backgroundColor: AppColor.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            if (notificationList.isNotEmpty)
              Container(
                margin:
                    EdgeInsets.symmetric(horizontal: Dim.w4, vertical: Dim.h2),
                child: RefreshIndicator(
                  onRefresh: () async {
                    noResults = false;
                    // _notificationsBloc.getNotifications();
                  },
                  child: NotificationListViewVertical(
                    dataList: notificationList,
                  ),
                ),
              ),
            if (noResults) comp.notFoundWidget(context),
            if (isLoading) LoadingIndicator(),
          ],
        ),
      ),
    );
  }

  //--------------------------


  void observeNotificationList(Result<List<NotificationData>?> result) {
    loading(false);
    if (result is SuccessResult) {
      if (null == result.getSuccessData()) return;
      notificationList = result.getSuccessData() ?? [];
      noResults = (notificationList.isEmpty) ? true : false;
      refresh();
    } else if (result is ErrorResult) {
      comp.handleApiError(context, error: result.getErrorMessage());
    } else if (result is LoadingResult) {
      loading(true);
    }
  }
}
