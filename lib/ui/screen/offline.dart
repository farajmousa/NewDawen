import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:sky_vacation/helper/app_asset.dart';
import 'package:sky_vacation/helper/app_color.dart';
import 'package:sky_vacation/helper/dim.dart';
import 'package:sky_vacation/helper/font_style.dart';
import 'package:sky_vacation/helper/localize.dart';
import 'package:sky_vacation/ui/widgets/app_button.dart';



class OfflineScreen extends StatefulWidget {

  OfflineScreen({
    Key? key,
  }) : super(key: key);

  @override
  _OfflineScreenState createState() => _OfflineScreenState();
}

class _OfflineScreenState extends State<OfflineScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bkg,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: Dim.w10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: "logo",
              child: Image.asset(
                AppAsset.no_internet,
                width: Dim.h26,
                height: Dim.h12,
              ),
            ),
            SizedBox(height: Dim.h10,),
            Text(Trans.of(context).t("no_internet_connection"), textAlign: TextAlign.center, style: TS.medGrayDark8,),
            SizedBox(height: Dim.h4,),
            AppButton(
              title: Trans.of(context).t("retry"),
              onTap: () {
                Phoenix.rebirth(context);
              },
            ),
          ],
        ),
      ),
    );
  }

//  ----------

}
