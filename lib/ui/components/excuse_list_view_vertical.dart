import 'package:sky_vacation/data/model/entity/excuse_data.dart';
import 'package:sky_vacation/helper/app_color.dart';
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
          dataList[index],
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: Dim.h1_5,
        );
      },
    );
  }

  Widget itemOrderWidget(BuildContext context, ExcuseData item) {
    IdName? typeHoliday =
        typeExcuseList.firstWhereOrNull((element) => element.id == item.typeid);
    // IdName? shift =
    // shiftList.firstWhereOrNull((element) => element.id == item.shiftid);
    return Container(
      // margin: EdgeInsets.fromLTRB(Dim.w4, 0, Dim.w4, 0),
      padding: EdgeInsets.fromLTRB(Dim.w4, Dim.w4, Dim.w4, Dim.w4),
      decoration: AppDecor.decoration(
          borderColor: AppColor.grayMed,
          bkgColor: AppColor.grayTF,
          borderRadius: Dim.w5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Dim.h1,
          ),
          Text("${Trans.of(context).t("id")}:  ${item.id}",
            style: TS.medBlack10,
          ),
          SizedBox(
            height: Dim.h_8,
          ),
          Text(
            "${Trans.of(context).t("request_date")}:  ${au.formatDateString(item.edate ?? "")}",
            style: TS.medBlack10,
          ),
          SizedBox(
            height: Dim.h_8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${Trans.of(context).t("start_time")}:  ${item.stime ?? ""}",
                style: TS.medBlack10,
              ),
              Text(
                "${Trans.of(context).t("end_time")}:  ${item.etime ?? ""}",
                style: TS.medBlack10,
              ),
            ],
          ),
          SizedBox(
            height: Dim.h_8,
          ),

          Text(
            "${Trans.of(context).t("excuse_type")}:  ${typeHoliday?.name ?? ""}",
            style: TS.medBlack10,
          ),
          SizedBox(
            height: Dim.h_8,
          ),
          Text(
            "${Trans.of(context).t("excuse_reason")}:  ${item.excwhy ?? 0}",
            style: TS.medBlack10,
          ),
          SizedBox(
            height: Dim.h_8,
          ),
          Text(
            "${Trans.of(context).t("status")}:  ${item.exstatuestext ?? ""}",
            style: TS.medBlack10,
          ),
          SizedBox(
            height: Dim.h1_5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppButton(
                width: Dim.w26,
                height: Dim.h4,
                titleSize: Dim.s7,
                radius: Dim.w1,
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
                radius: Dim.w1,
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
    );
  }
}
