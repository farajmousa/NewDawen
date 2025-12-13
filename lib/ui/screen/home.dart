import 'package:flutter/material.dart';
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
import '../../helper/app_asset.dart';
import '../../helper/app_color.dart';
import '../bloc/send_fcm_token.dart';

List<IdName> managerList = [];
List<IdName> headDepartList = [];
List<IdName> supportEmployeeList = [];
List homeCounters = [];

class HomeScreen extends StatefulWidget {
  final int? holidayCounter ;
  final int? excuseCounter ;
  final void Function() navigateToProfile;
  // final void Function() getNotificationsLength;
   HomeScreen({
     required this.holidayCounter,
     required this.excuseCounter,
    required this.navigateToProfile,
  }
      // this.getNotificationsLength,
      );
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Company? company;
  int userId = 0;
  String departId = "0";
  // List homeNotificationsCounters = [];

  final DirectorsBloc _directorsBloc = sl<DirectorsBloc>();
  final SendFcmTokenBloc _sendFcmTokenBloc = sl<SendFcmTokenBloc>();


  @override
  void initState() {
    // widget.getNotificationsLength();
    _sendFcmTokenBloc.send();

    userId = sm.getUser()?.usId ?? 0;
    departId = "${sm.getUser()?.depId?? 0}" ;
    // getNumbers(userId);
    _directorsBloc.mainStream.listen(_observeDirectors);
    _directorsBloc.get("${Urls.getAllHeadofDeps}/$departId");
    _directorsBloc.get(Urls.getAllMangers);
    _directorsBloc.get("${Urls.getAllSupportEmployees}/$userId");

    company = sm.getCompany();
    super.initState();
  }

  // getNumbers(int userId)async{
  //   String token = sm.getValue(UserConstant.accessToken);
  //   Response response = await get(
  //       Uri.parse("${sm.getCompany()?.Url}${Urls.getHomeCounters}/$userId?lang=$currentLocale"),
  //     headers: {'Authorization': 'Bearer $token'}
  //   );
  //   if(response.statusCode > 199 && response.statusCode <300){
  //     setState(() {
  //       homeNotificationsCounters = jsonDecode(response.body)["result"]["response_data"];
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return ListView(

      children: <Widget>[
          Container(
            decoration: AppDecor.roundedBottom(bkgColor: AppColor.primary,
                borderRadius: 0),
            padding: EdgeInsets.symmetric(horizontal: Dim.w5, vertical: Dim.h4),

            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${Trans.of(context).t("hi")}  ${sm.getUser()?.name ?? ""}",
                      style: TS.textStyle(color: AppColor.white, size: Dim.s11, weight: FontWeight.w600),
                    ),
                    SizedBox(height: Dim.h_8,),
                    Text(
                      "${Trans.of(context).t("welcome_to")}:  ${sm.getCompany()?.CompName}",
                      style: TS.textStyle(color: AppColor.accentDark, size: Dim.s12, weight: FontWeight.bold),
                    ),
                  ],
                ),
                if (null != sm.getCompany()?.CompLogo)
                  AppImage(
                    img: sm.getCompany()?.CompLogo ?? "",
                    fit: BoxFit.contain,
                    height: Dim.h6,
                    width: Dim.h6,
                    radius: Dim.w1_5,
                  ),
              ],
            ),
          ),

        SizedBox(
          height: Dim.h1,
        ),
    Container(
      width:MediaQuery.of(context).size.width,
      height:MediaQuery.of(context).size.height - 210,
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: Dim.w3,
        mainAxisSpacing: Dim.w3,
        padding: EdgeInsets.symmetric(horizontal: Dim.w3, vertical: Dim.h2),

        primary: false,
        children: [
          item(AppAsset.profile2 ,Trans.of(context).t("homeProfile"), AppColor.accentDark,() { widget.navigateToProfile();}),
          item( AppAsset.faceprint , Trans.of(context).t("checkin_checkout"), AppColor.green, () {
            Navigator.of(context).pushNamed(AppRoute.checkInOut);
          }),
          item( AppAsset.holiday ,  Trans.of(context).t("holidays"),  AppColor.blue,() {
            Navigator.of(context).pushNamed(AppRoute.holidays);
          }),
          item(AppAsset.holiday_agree ,Trans.of(context).t("holidays_agreements"), AppColor.redTomato, () {
            Navigator.of(context).pushNamed(AppRoute.holidaysAgreements,
                arguments: Urls.holidayGetAllAgreements);
          } , notificationNum: widget.holidayCounter ?? 0),
          item(AppAsset.excuse , Trans.of(context).t("excuses"),  AppColor.greenBlue,() {
            Navigator.of(context).pushNamed(AppRoute.excuse);
          } ),
          item(AppAsset.excuse_agree ,Trans.of(context).t("excuse_agreements"), AppColor.purple, () {
            Navigator.of(context).pushNamed(AppRoute.excuseAgreements,
                arguments: Urls.excuseGetAllAgreements);
          } , notificationNum: widget.excuseCounter ?? 0),

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

  Widget item(String mainIcon ,String title, Color color , Function() onTap ,{ int notificationNum = 0}) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(Dim.w4, Dim.h3, Dim.w4, 0),
            // margin: EdgeInsets.symmetric( vertical: Dim.h1, horizontal: Dim.h1),
            decoration: AppDecor.decoration(bkgColor: AppColor.white, borderRadius: Dim.w6),
            height:200,
            child: Column(
              children: [

                CircleAvatar(
                  backgroundColor: color,
                  radius:  Dim.h5,
                  child:   Image.asset(mainIcon ,  width: Dim.h5,
                    height: Dim.h5, color: AppColor.white,),
                ),
               SizedBox(height: Dim.h1,),
               Center(
                 child:  Text(
                   textAlign: TextAlign.center,
                   title,
                   style: TS.medBlack10,
                 ),
               ),
              ],
            ),
          ),
          if(notificationNum > 0) Positioned(
            right: 0,
            top: 0,
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(40)),
                child: Container(
                    width: Dim.w6,
                    height: Dim.w6,
                    color: AppColor.red,
                    child: Center(child: Text(notificationNum.toString() , style: TS.textStyle(color: Colors.white ,  size: Dim.s9, weight: FontWeight.bold), )))),
          ),
        ],
      ),
    );
  }

  void _observeDirectors(Result<Map<String, List<IdName>>> result) {
    if (result is SuccessResult) {
      if (null == result.getSuccessData()) return;
      String url = result.getSuccessData()!.keys.toList().first;
      if (url == "${Urls.getAllHeadofDeps}/$departId") {
        headDepartList = result.getSuccessData()![url] ?? [];
      } else if (url == Urls.getAllMangers) {
        managerList = result.getSuccessData()![url] ?? [];
      } else if (url == "${Urls.getAllSupportEmployees}/$userId") {
        supportEmployeeList = result.getSuccessData()![url] ?? [];
      }

    } else if (result is ErrorResult) {
      comp.handleApiError(context, error: result.getErrorMessage());
    } else if (result is LoadingResult) {}
  }
}
