import 'package:dawim/data/model/entity/holiday_agreement_data.dart';
import 'package:dawim/helper/app_color.dart';
import 'package:dawim/helper/app_decoration.dart';
import 'package:dawim/helper/dim.dart';
import 'package:dawim/helper/font_style.dart';
import 'package:dawim/helper/localize.dart';
import 'package:dawim/ui/widgets/app_button.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import 'row_item.dart';


class HolidayAgreementListViewVertical extends StatelessWidget {
  final List<HolidayAgreementData> dataList;
  final Function(HolidayAgreementData, String) updateDeleteTapped;
  HolidayAgreementListViewVertical({
    required this.dataList,
    required this.updateDeleteTapped,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
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

  Widget itemOrderWidget(BuildContext context,int index ) {
    HolidayAgreementData item  = dataList[index] ;
    return Container(
        padding: EdgeInsets.fromLTRB(Dim.w4, Dim.w4, Dim.w4, Dim.w4),
        decoration: AppDecor.decoration(bkgColor: colorsRandom[index%(colorsRandom.length)].withOpacity(0.1), borderRadius: Dim.h2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Dim.h1,
            ),
        rowItem(Trans.of(context).t("id"),  "${item.id}"),

        rowItem(Trans.of(context).t("emp_name"),item.empName ?? "", valueCol: AppColor.primary),
        rowItem(Trans.of(context).t("request_date"),item.startHDate ?? ""),

      rowItem(Trans.of(context).t("holiday_type"),item.hname ??""),
      rowItem(Trans.of(context).t("period"),"${item.period ?? 0}", valueCol: colorsRandom[index%(colorsRandom.length)]),

    rowItem(Trans.of(context).t("support_emp"),item.empsup ?? ""),
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
                  title: Trans.of(context).t("agree"),
                  onTap: () {
                    updateDeleteTapped(item, "agree");

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
                  title: Trans.of(context).t("reject"),
                  onTap: () {
                    updateDeleteTapped(item, "reject");
                  },
                ),
              ],
            )
          ],
        ),
    );
  }
}

