import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sky_vacation/base/result.dart';
import 'package:sky_vacation/data/api/api_urls.dart';
import 'package:sky_vacation/data/model/entity/id_name.dart';
import 'package:sky_vacation/di/injection_container.dart';
import 'package:sky_vacation/helper/app_decoration.dart';
import 'package:sky_vacation/helper/app_route.dart';
import 'package:sky_vacation/helper/dim.dart';
import 'package:sky_vacation/helper/font_style.dart';
import 'package:sky_vacation/main.dart';
import 'package:sky_vacation/data/model/entity/company.dart';
import 'package:sky_vacation/helper/localize.dart';
import 'package:sky_vacation/ui/bloc/direstors.dart';
import 'package:sky_vacation/ui/widgets/app_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../helper/app_color.dart';
import '../../helper/user_constant.dart';
import '../bloc/notifications.dart';
import '../bloc/send_fcm_token.dart';

List<IdName> managerList = [];
List<IdName> headDepartList = [];
List<IdName> supportEmployeeList = [];
List homeCounters = [];

class HomeScreen extends StatefulWidget {
  final List notificationList;
  final bool isThereNotification;
  final void Function() navigateToProfile;
  final void Function() getNotificationsLength;
  const HomeScreen(this.notificationList , this.isThereNotification, this.navigateToProfile, this.getNotificationsLength);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Company? company;
  int userId = 0;
  String departId = "0";
  List homeNotificationsCounters = [];

  final DirectorsBloc _directorsBloc = sl<DirectorsBloc>();
  final SendFcmTokenBloc _sendFcmTokenBloc = sl<SendFcmTokenBloc>();


  @override
  void initState() {
    widget.getNotificationsLength();
    _sendFcmTokenBloc.send();

    userId = sm.getUser()?.usId ?? 0;
    departId = "${sm.getUser()?.depId?? 0}" ;
    getNumbers(userId);
    _directorsBloc.mainStream.listen(_observeDirectors);
    _directorsBloc.get("${Urls.getAllHeadofDeps}/$departId");
    _directorsBloc.get(Urls.getAllMangers);
    _directorsBloc.get("${Urls.getAllSupportEmployees}/$userId");

    company = sm.getCompany();
    super.initState();
  }
  getNumbers(int userId)async{
    String token = sm.getValue(UserConstant.accessToken);
    Response response = await get(
        Uri.parse("${sm.getCompany()?.Url}${Urls.getHomeCounters}/$userId?lang=$currentLocale"),
      headers: {'Authorization': 'Bearer $token'}
    );
    if(response.statusCode > 199 && response.statusCode <300){
      setState(() {
        homeNotificationsCounters = jsonDecode(response.body)["result"]["response_data"];
      });
    }

    print(homeNotificationsCounters);
    print("#homeCounters: $homeCounters");
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: Dim.w4, vertical: Dim.h2),

      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${Trans.of(context).t("welcome_to")}:  ${sm.getCompany()?.CompName}",
              style: TS.boldPrimary11,
            ),
            if (null != sm.getCompany()?.CompLogo)
              AppImage(
                img: sm.getCompany()?.CompLogo ?? "",
                fit: BoxFit.contain,
                height: Dim.h6,
                width: Dim.h6,
              ),
          ],
        ),

        SizedBox(
          height: Dim.h2,
        ),
    Container(
      width:MediaQuery.of(context).size.width,
      height:MediaQuery.of(context).size.height - 210,
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        primary: false,
        children: [
          item(Icons.person_pin ,Trans.of(context).t("homeProfile"), () { widget.navigateToProfile();}),
          item( Icons.fingerprint , Trans.of(context).t("checkin_checkout"), () {
            Navigator.of(context).pushNamed(AppRoute.checkInOut);
          }),
          item( Icons.card_giftcard ,  Trans.of(context).t("holidays"), () {
            Navigator.of(context).pushNamed(AppRoute.holidays);
          }),
          item(Icons.thumb_up_alt ,Trans.of(context).t("holidays_agreements"), () {
            Navigator.of(context).pushNamed(AppRoute.holidaysAgreements,
                arguments: Urls.holidayGetAllAgreements);
          } , hasNotify: widget.isThereNotification, notificationNum: widget.notificationList.isNotEmpty? widget.notificationList[2]["actionValue"] : '0'),
          item(FontAwesomeIcons.handPointUp , Trans.of(context).t("excuses"), () {
            Navigator.of(context).pushNamed(AppRoute.excuse);
          } ),
          item(Icons.thumb_up_alt ,Trans.of(context).t("excuse_agreements"), () {
            Navigator.of(context).pushNamed(AppRoute.excuseAgreements,
                arguments: Urls.excuseGetAllAgreements);
          } , hasNotify: widget.isThereNotification , notificationNum: widget.notificationList.isNotEmpty? widget.notificationList[1]["actionValue"] : '0'),

        ],
      ),
    ),


        // item(Trans.of(context).t("leaves"), () {
        //   //Get.toNamed(AppStrings.excuseScreenId);
        //   Navigator.of(context).pushNamed(AppRoute.leaves);
        // }),
        // item(Trans.of(context).t("absents"), () {
        //   //Get.toNamed(AppStrings.excuseScreenId);
        //   Navigator.of(context).pushNamed(AppRoute.absents);
        // }),
      ],
    );
  }

  Widget item(IconData mainIcon ,String title, Function() onTap , {bool hasNotify = false , String notificationNum = '0'}) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: Dim.w4, vertical: Dim.h2),
            margin: EdgeInsets.symmetric( vertical: Dim.h_8),
            decoration: AppDecor.decoration(borderColor: AppColor.grayLight),
            height:200,
            child: Column(
              children: [
                Icon(mainIcon ,  size: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      textAlign: TextAlign.center,
                      title,
                      style: TS.medBlack10,
                    ),
                  ]
                ),
              ],
            ),
          ),
          hasNotify ? Positioned(
            right: 0,
            top: 0,
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(40)),
                child: Container(
                    width: 35,
                    height: 35,
                    color: AppColor.red,
                    child: Center(child: Text(notificationNum , style: TextStyle(color: Colors.white ,  fontSize: 18),)))),
          ) : SizedBox()
        ],
      ),
    );
  }

  void _observeDirectors(Result<Map<String, List<IdName>>> result) {
    if (result is SuccessResult) {
      if (null == result.getSuccessData()) return;
      String url = result.getSuccessData()!.keys.toList().first;
      if (url == "${Urls.getAllHeadofDeps}/$departId")
        headDepartList = result.getSuccessData()![url] ?? [];
      else if (url == Urls.getAllMangers)
        managerList = result.getSuccessData()![url] ?? [];
      else if (url == "${Urls.getAllSupportEmployees}/$userId")
        supportEmployeeList = result.getSuccessData()![url] ?? [];
      print("#_observeDirectors url: $url");
      print("#headDepartList: $headDepartList");
      print("#managerList: $managerList");
      print("#supportEmployeeList: $supportEmployeeList");

    } else if (result is ErrorResult) {
      comp.handleApiError(context, error: result.getErrorMessage());
    } else if (result is LoadingResult) {}
  }
}
