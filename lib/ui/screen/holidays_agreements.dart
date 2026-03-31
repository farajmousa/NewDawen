import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import 'package:dawim/base/result.dart';
import 'package:dawim/data/api/api_urls.dart';
import 'package:dawim/data/model/entity/holiday_agreement_data.dart';
import 'package:dawim/di/injection_container.dart';
import 'package:dawim/data/model/entity/id_name.dart';
import 'package:dawim/helper/app_color.dart';
import 'package:dawim/helper/dim.dart';
import '../../helper/app_asset.dart';
import '../../helper/app_color.dart';
import 'package:dawim/helper/localize.dart';
import 'package:dawim/ui/bloc/holiday_agreement_action.dart';
import 'package:dawim/ui/bloc/holiday_list_agreements.dart';
import 'package:dawim/ui/components/holiday_agreement_list_view_vertical.dart';
import 'package:dawim/ui/components/sheet/reject_reason_sheet.dart';
import '../../main.dart';
import '../widgets/loading_indicator.dart';


class HolidaysAgreementsScreen extends StatefulWidget {
  @override
  _HolidaysAgreementsScreenState createState() =>
      _HolidaysAgreementsScreenState();
}

class _HolidaysAgreementsScreenState
    extends ResumableState<HolidaysAgreementsScreen> {
  List<HolidayAgreementData> holidayList = [];
  HolidayAgreementData? selectedHoliday;
  String? operation;
  IdName? selectedType;
  IdName? selectedHeadDepart;
  IdName? selectedManager;
  IdName? selectedSupportEmp;
  bool isEdit = false;

  bool noResults = false;
  bool isLoading = false;
  TextEditingController _periodCont = TextEditingController();

  final HolidayListAgreementBloc _holidayListBloc =
      sl<HolidayListAgreementBloc>();
  final HolidayAgreementActionBloc _holidayAgreementActionBloc =
      sl<HolidayAgreementActionBloc>();

  refresh() {
    if (mounted) setState(() {});
  }

  loading(bool load) {
    isLoading = load;
    refresh();
  }

  @override
  void initState() {
    super.initState();
    _holidayListBloc.mainStream.listen(_observeHolidayList);
    _holidayAgreementActionBloc.mainStream.listen(_observeHolidayDelete);

    _holidayListBloc.get();
  }

  @override
  void dispose() {
    _periodCont.dispose();
    super.dispose();
  }

  @override
  void onResume() {
    super.onResume();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: comp.appBar(Trans.of(context).t("holidays_agreements"),
          backTapped: () {
        Navigator.of(context).pop();
      }),
      backgroundColor: AppColor.bkg,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: Dim.w4, vertical: Dim.h2),
              child: ListView(
                children: <Widget>[
                  if (holidayList.isNotEmpty)
                    HolidayAgreementListViewVertical(
                      dataList: holidayList,
                      updateDeleteTapped: (holiday, _operation) {
                        if(!isLoading) {
                          selectedHoliday = holiday;
                          operation = _operation;
                          if (operation == "agree") {
                            _holidayAgreementActionBloc.checkAccepted("${Urls
                                .holidayAgreementAccept}/${holiday.id ??
                                0}?lang=$currentLocale", holiday.id ?? 0);
                          } else if (operation == "reject") {
                            rejectReasonSheet(context, (String reason) {
                              _holidayAgreementActionBloc.checkAccepted(
                                  Urls.holidayAgreementReject, holiday.id ?? 0,
                                  rejectReason: reason);
                            });
                          }
                        }
                      },
                    ),
                  if(noResults) comp.notFoundWidget(context)
                ],
              ),
            ),
            if (isLoading) LoadingIndicator(),

          ],
        ),
      ),
    );
  }

  //--------------------------

  void _observeHolidayList(Result<List<HolidayAgreementData>> result) {
    loading(false);
    if (result is SuccessResult) {
      if (null == result.getSuccessData()) return;
      holidayList = result.getSuccessData() ?? [];
      noResults = (holidayList.isEmpty)? true: false;
      refresh();
    } else if (result is ErrorResult) {
      comp.handleApiError(context, error: result.getErrorMessage());
    } else if (result is LoadingResult) {
      loading(true);
    }
  }

  void _observeHolidayDelete(Result<bool> result) {
    loading(false);
    if (result is SuccessResult) {
      if (null == result.getSuccessData()) return;
      holidayList = [];
      _holidayListBloc.get();
      comp.displayToast(context, Trans.of(context).t("done_success"));
    } else if (result is ErrorResult) {
      comp.handleApiError(context, error: result.getErrorMessage(), img: AppAsset.failed);
    } else if (result is LoadingResult) {
      loading(true);
    }
  }
}
