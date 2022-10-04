import 'package:sky_vacation/data/model/entity/excuse_data.dart';
import 'package:sky_vacation/helper/app_color.dart';
import 'package:sky_vacation/helper/app_constant.dart';
import 'package:sky_vacation/helper/app_decoration.dart';
import 'package:sky_vacation/helper/dim.dart';
import 'package:sky_vacation/helper/font_style.dart';
import 'package:sky_vacation/helper/localize.dart';
import 'package:sky_vacation/data/model/entity/id_name.dart';
import 'package:sky_vacation/ui/screen/excuses.dart';
import 'package:sky_vacation/ui/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import '../../main.dart';
import 'row_item.dart';

class ExcuseListViewVertical extends StatelessWidget {
  final List<ExcuseData> dataList;
  final Function(ExcuseData, String) updateDeleteTapped;

  ExcuseListViewVertical({
    required this.dataList,
    required this.updateDeleteTapped,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      // physics: NeverScrollableScrollPhysics(),
      // shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        return itemOrderWidget(
          context,
          index,
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: Dim.h1_5,
        );
      },
    );
  }

  Widget itemOrderWidget(BuildContext context, int index) {
    ExcuseData item = dataList[index];
    IdName? typeHoliday =
        typeExcuseList.firstWhereOrNull((element) => element.id == item.typeid);
    // IdName? shift =
    // shiftList.firstWhereOrNull((element) => element.id == item.shiftid);
    return ClipRRect(
      borderRadius: BorderRadius.circular(Dim.w5),
      child: Stack(
        children: [

      Container(
        // margin: EdgeInsets.fromLTRB(Dim.w4, 0, Dim.w4, 0),
        padding: EdgeInsets.fromLTRB((currentLocale == AppLocale.EN) ? Dim.w6 :Dim.w4 , Dim.w4, (currentLocale == AppLocale.AR) ? Dim.w6 :Dim.w4, Dim.w4),
        decoration: AppDecor.decoration(
            bkgColor: AppColor.bkg,
            borderRadius: Dim.w5,
            borderColor: colorsRandom[index % (colorsRandom.length)]), child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Dim.h1,
              ),
              rowItem(Trans.of(context).t("id"), "${item.id ?? 0}"),

              rowItem(Trans.of(context).t("request_date"),
                  au.formatDateString(item.edate ?? "")),

              rowItem(Trans.of(context).t("start_time"), item.stime ?? ""),
              rowItem(Trans.of(context).t("end_time"), item.etime ?? ""),

              rowItem(Trans.of(context).t("excuse_type"), typeHoliday?.name ?? ""),

              rowItem(Trans.of(context).t("excuse_reason"), item.excwhy ?? ""),

              rowItem(Trans.of(context).t("status"), item.exstatuestext ?? "",
                  valueCol: colorsRandom[index % (colorsRandom.length)]),
              SizedBox(
                height: Dim.h3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppButton(
                    width: Dim.w26,
                    height: Dim.h4,
                    titleSize: Dim.s7,
                    radius: Dim.w2,
                    marginHorizontal: Dim.w2,
                    marginVertical: 0,
                    title: Trans.of(context).t("update"),
                    onTap: () {
                      updateDeleteTapped(item, "update");
                    },
                  ),
                  AppButton(
                    width: Dim.w26,
                    height: Dim.h4,
                    bkgColor: AppColor.red,
                    titleSize: Dim.s7,
                    radius: Dim.w2,
                    marginHorizontal: Dim.w2,
                    marginVertical: 0,
                    title: Trans.of(context).t("delete"),
                    onTap: () {
                      updateDeleteTapped(item, "delete");
                    },
                  ),
                ],
              )
            ],),
          ),
          Positioned(
            left: (currentLocale == AppLocale.EN) ? 0 : null,
            right: (currentLocale == AppLocale.AR) ? 0 : null,
            top: 0,
            bottom: 0,
            child: Container(
              width: Dim.w2,
              color: colorsRandom[index % (colorsRandom.length)],
            ),),
        ],
      ),
    );
  }
}
