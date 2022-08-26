import 'package:sky_vacation/data/model/entity/holiday_data.dart';
import 'package:sky_vacation/data/model/entity/notification_data.dart';
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
import '../../main.dart';


class NotificationListViewVertical extends StatelessWidget {
  final List<NotificationData> dataList;
  NotificationListViewVertical({
    required this.dataList,
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

  Widget itemOrderWidget(BuildContext context, NotificationData item) {
    return Container(
        padding: EdgeInsets.fromLTRB(Dim.w4, Dim.w4, Dim.w4, Dim.w4),
        decoration: AppDecor.decoration(borderColor: AppColor.grayMed, bkgColor: AppColor.grayTF, borderRadius: Dim.w5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: Dim.h1,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
              Text("${Trans.of(context).t("id")}:  ${item.id ?? ""}",
                style: TS.medBlack10,
              ),
              Text("${Trans.of(context).t("request_id")}:  #${item.requestId ?? ""}",
                style: TS.medBlack10,
              ),
            ],),
            SizedBox(
              height: Dim.h1_5,
            ),
            Text(
              "${item.title ?? ""}",
              style: TS.medBlack10,
            ),
            SizedBox(
              height: Dim.h_8,
            ),
            Text(
              "${item.message ?? ""}",
              style: TS.regularBlack10,
            ),
            SizedBox(
              height: Dim.h_8,
            ),
            Text(
              "${item.date ?? ""}",
              style: TS.regularGray8,
              textAlign: TextAlign.end,
            ),
          ],
        ),
    );
  }
}

