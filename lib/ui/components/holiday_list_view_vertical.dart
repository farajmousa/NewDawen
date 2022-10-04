import 'package:sky_vacation/data/model/entity/holiday_data.dart';
import 'package:sky_vacation/helper/app_color.dart';
import 'package:sky_vacation/helper/app_decoration.dart';
import 'package:sky_vacation/helper/dim.dart';
import 'package:sky_vacation/helper/font_style.dart';
import 'package:sky_vacation/helper/localize.dart';
import 'package:sky_vacation/data/model/entity/id_name.dart';
import 'package:sky_vacation/ui/screen/holidays.dart';
import 'package:sky_vacation/ui/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import '../../helper/app_constant.dart';
import '../../main.dart';
import 'row_item.dart';

class HolidayListViewVertical extends StatelessWidget {
  final List<HolidayData> dataList;
  final Function(HolidayData, String) updateDeleteTapped;

  HolidayListViewVertical({
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
    HolidayData item = dataList[index];
    IdName? typeHoliday = typeHolidayList
        .firstWhereOrNull((element) => element.id == item.holdaytype);
    return ClipRRect(
      borderRadius: BorderRadius.circular(Dim.w5),
      child: Stack(
          children: [

      Container(
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
          rowItem(Trans.of(context).t("id"), "${item.id}"),
          rowItem(
              Trans.of(context).t("request_date"),
              (null != item.startDate)
                  ? au.formatDateString(item.startDate ?? "")
                  : ""),
          rowItem(Trans.of(context).t("holiday_type"), typeHoliday?.name ?? ""),
          rowItem(
            Trans.of(context).t("period"),
            "${item.briod ?? 0}",
          ),
          rowItem(Trans.of(context).t("status"), item.hstatuestext ?? "",
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
        ],
      ),),

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
