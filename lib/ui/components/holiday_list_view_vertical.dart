import 'package:dawim/data/model/entity/holiday_data.dart';
import 'package:dawim/helper/app_color.dart';
import 'package:dawim/helper/app_decoration.dart';
import 'package:dawim/helper/dim.dart';
import 'package:dawim/helper/font_style.dart';
import 'package:dawim/helper/localize.dart';
import 'package:dawim/data/model/entity/id_name.dart';
import 'package:dawim/ui/screen/holidays.dart';
import 'package:dawim/ui/widgets/app_button.dart';
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
      borderRadius: BorderRadius.circular(Dim.h2),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(
                (currentLocale == AppLocale.EN) ? Dim.w6 : Dim.w4,
                Dim.w4,
                (currentLocale == AppLocale.AR) ? Dim.w6 : Dim.w4,
                Dim.w4),
            decoration: AppDecor.decoration(
                bkgColor: AppColor.bkg,
                borderRadius: Dim.h2,
                borderColor: colorsRandom[index % (colorsRandom.length)]),
            child: Column(
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
                rowItem(Trans.of(context).t("holiday_type"),
                    typeHoliday?.name ?? ""),
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
                      titleSize: Dim.s11,
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
                      titleSize: Dim.s11,
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
            ),
          ),
          Positioned(
            left: (currentLocale == AppLocale.EN) ? 0 : null,
            right: (currentLocale == AppLocale.AR) ? 0 : null,
            top: 0,
            bottom: 0,
            child: Container(
              width: Dim.w2,
              color: colorsRandom[index % (colorsRandom.length)],
            ),
          ),
        ],
      ),
    );
  }
}
