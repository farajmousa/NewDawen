import 'package:sky_vacation/helper/app_color.dart';
import 'package:sky_vacation/helper/app_decoration.dart';
import 'package:sky_vacation/helper/dim.dart';
import 'package:sky_vacation/helper/font_style.dart';
import 'package:sky_vacation/helper/localize.dart';
import 'package:sky_vacation/ui/widgets/app_button.dart';
import 'package:flutter/material.dart';
import '../../data/model/entity/excuse_agreement_data.dart';


class ExcuseAgreementListViewVertical extends StatelessWidget {
  final List<ExcuseAgreementData> dataList;
  final Function(ExcuseAgreementData, String) updateDeleteTapped;
  ExcuseAgreementListViewVertical({
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

  Widget itemOrderWidget(BuildContext context, ExcuseAgreementData item) {

    return Container(
        padding: EdgeInsets.fromLTRB(Dim.w4, Dim.w4, Dim.w4, Dim.w4),
        decoration: AppDecor.decoration(borderColor: AppColor.grayMed, bkgColor: AppColor.grayTF, borderRadius: Dim.w5),
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
              "${Trans.of(context).t("emp_name")}:  ${item.empName ?? ""}",
              style: TS.medBlack10,
            ),
            SizedBox(
              height: Dim.h_8,
            ),
            Text("${Trans.of(context).t("request_date")}:  ${item.edate ?? ""}",
              style: TS.medBlack10,
            ),
            SizedBox(
              height: Dim.h_8,
            ),
            Text(
              "${Trans.of(context).t("excuse_type")}:  ${item.typename ??""}",
              style: TS.medBlack10,
            ),
            SizedBox(
              height: Dim.h_8,
            ),
            Text(
              "${Trans.of(context).t("excuse_reason")}:  ${item.excwhy ??""}",
              style: TS.medBlack10,
            ),
            SizedBox(
              height: Dim.h_8,
            ),
            Text(
              "${Trans.of(context).t("work_duration")}:  ${item.shName ?? 0}",
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
                  title: Trans.of(context).t("agree"),
                  onTap: () {
                    updateDeleteTapped(item, "agree");

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

