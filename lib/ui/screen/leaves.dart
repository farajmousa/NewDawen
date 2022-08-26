import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import 'package:sky_vacation/base/result.dart';
import 'package:sky_vacation/data/api/api_urls.dart';
import 'package:sky_vacation/data/model/entity/holiday_data.dart';
import 'package:sky_vacation/di/injection_container.dart';
import 'package:sky_vacation/data/model/entity/id_name.dart';
import 'package:sky_vacation/helper/app_color.dart';
import 'package:sky_vacation/helper/dim.dart';
import 'package:sky_vacation/helper/font_style.dart';
import '../../helper/app_color.dart';
import 'package:sky_vacation/helper/font_style.dart';
import 'package:sky_vacation/helper/localize.dart';
import 'package:sky_vacation/ui/bloc/direstors.dart';
import 'package:sky_vacation/ui/bloc/holiday.dart';
import 'package:sky_vacation/ui/bloc/holiday_create.dart';
import 'package:sky_vacation/ui/bloc/holiday_delete.dart';
import 'package:sky_vacation/ui/bloc/holiday_list.dart';
import 'package:sky_vacation/ui/bloc/holiday_type.dart';
import 'package:sky_vacation/ui/bloc/leave_create.dart';
import 'package:sky_vacation/ui/components/holiday_list_view_vertical.dart';
import 'package:sky_vacation/ui/widgets/app_button.dart';
import 'package:sky_vacation/ui/widgets/app_drop_down.dart';
import 'package:sky_vacation/ui/widgets/app_text_field.dart';
import '../../helper/app_decoration.dart';
import '../../main.dart';
import 'package:collection/collection.dart';

List<IdName> typeLeaveList = [];

class LeaveScreen extends StatefulWidget {
  @override
  _LeaveScreenState createState() => _LeaveScreenState();
}

class _LeaveScreenState extends ResumableState<LeaveScreen> {
  DateTime? _selectedDate;
  List<IdName> directorList = [];
  List<HolidayData> holidayList = [];
  HolidayData? selectedHoliday;
  String? operation;
  IdName? selectedType;
  IdName? selectedHead;
  IdName? selectedDirector;
  IdName? selectedSubstitute;
  bool isEdit = false;

  bool isLoading = false;
  TextEditingController _nameCont = TextEditingController();

  final HolidayTypesBloc _holidayTypesBloc = sl<HolidayTypesBloc>();
  final LeaveCreateBloc _holidayCreateBloc = sl<LeaveCreateBloc>();
  final HolidayListBloc _holidayListBloc = sl<HolidayListBloc>();
  final CheckItemAcceptedBloc _checkItemAcceptedBloc =
      sl<CheckItemAcceptedBloc>();
  final HolidayDeleteBloc _holidayDeleteBloc = sl<HolidayDeleteBloc>();

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
    _holidayTypesBloc.mainStream.listen(_observeHolidayTypes);
    _holidayCreateBloc.mainStream.listen(_observeHolidayCreate);
    _holidayListBloc.mainStream.listen(_observeHolidayList);
    _checkItemAcceptedBloc.mainStream.listen(_observeHoliday);
    _holidayDeleteBloc.mainStream.listen(_observeHolidayDelete);

    _holidayTypesBloc.get(Urls.leaveTypeGetAll);
    // _holidayListBloc.get();
  }

  @override
  void dispose() {
    _holidayTypesBloc.dispose();
    _holidayCreateBloc.dispose();
    _nameCont.dispose();
    super.dispose();
  }

  @override
  void onResume() {
    super.onResume();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: comp.appBar(Trans.of(context).t("leaves"), backTapped: () {
        Navigator.of(context).pop();
      }),
      body: SafeArea(
        child: Container(
          color: AppColor.whiteColor,
          child: Container(
            color: AppColor.whiteColor,
            margin: EdgeInsets.symmetric(horizontal: Dim.w4, vertical: Dim.h2),
            child: ListView(
              children: <Widget>[
                createHolidayWidget(),
                if (holidayList.isNotEmpty)
                  HolidayListViewVertical(
                    dataList: holidayList,
                    updateDeleteTapped: (holiday, _operation) {
                      selectedHoliday = holiday;
                      operation = _operation;
                      _checkItemAcceptedBloc.checkAccepted(
                          Urls.holidayGet, holiday.id ?? 0);
                    },
                  ),
              ],
            ),
          ),
          // ),
        ),
      ),
    );
  }

  Widget createHolidayWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(Dim.w4, Dim.w2, Dim.w4, Dim.w2),
      margin: EdgeInsets.only(bottom: Dim.h2),
      decoration: AppDecor.decoration(
          borderColor: AppColor.primary,
          bkgColor: AppColor.bkgBlue,
          borderRadius: Dim.w5,
          isShadow: false),
      child: ExpandablePanel(
        theme: ExpandableThemeData(
            headerAlignment: ExpandablePanelHeaderAlignment.center),
        header: Text(
          Trans.of(context).t("create_leave"),
          style: TS.boldBlack11,
        ),
        collapsed: Center(),
        expanded: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: Dim.h3,
            ),
            Text(
              "${Trans.of(context).t("create_leave")}:",
              style: TS.boldBlack11,
            ),
            SizedBox(
              height: Dim.h1,
            ),
            AppDropDown(
              hint: 'select_type',
              items: typeLeaveList,
              selectedItem: selectedType,
              onItemChanged: (dynamic? newValue) {
                setState(() {
                  selectedType = newValue as IdName;
                });
              },
              onDeleteTapped: () {
                setState(() {
                  selectedType = null;
                });
              },
            ),
            AppTextField(
              fillColor: AppColor.white,
              enable: true,
              hint: Trans.of(context).t('_name'),
              isRequired: true,
              inputType: TextInputType.number,
              controller: _nameCont,
              onValueChanged: (value) {},
              onValidate: (value) {
                if ((value ?? "").isEmpty) {
                  return Trans.of(context).t('empty_field');
                }
                return null;
              },
            ),
            AppButton(
              title: Trans.of(context).t("send"),
              onTap: () {
                if (_nameCont.text.isNotEmpty && null != selectedType) {
                  _holidayCreateBloc.create(
                      _nameCont.text, selectedType?.id ?? 0,
                      holidayId: isEdit ? selectedHoliday?.id : 0);
                } else {
                  comp.displayDialog(
                      context, Trans.of(context).t("fill_fields"));
                }
              },
            ),
            SizedBox(
              height: Dim.h3,
            ),
          ],
        ),
      ),
    );
  }

  void clearAllFields() {
    _selectedDate = null;
    selectedType = null;
    _nameCont.text = "";
    selectedSubstitute = null;
    selectedHead = null;
    selectedDirector = null;
    isEdit = false;
    selectedHoliday = null;
    operation = null;
    refresh();
  }

  void fillOldData() {
    _selectedDate = au.formatDateGlobal(selectedHoliday?.datereq ?? "");
    selectedType = typeLeaveList.firstWhereOrNull(
        (element) => element.id == selectedHoliday?.holdaytype);
    _nameCont.text = "${selectedHoliday?.briod ?? 0}";
    selectedSubstitute = directorList.firstWhereOrNull(
        (element) => element.id == selectedHoliday?.empsupport);
    selectedHead = directorList
        .firstWhereOrNull((element) => element.id == selectedHoliday?.dbbossid);
    selectedDirector = directorList
        .firstWhereOrNull((element) => element.id == selectedHoliday?.bossid);
    refresh();
  }

  //--------------------------
  void _observeHolidayTypes(Result<List<IdName>> result) {
    loading(false);
    if (result is SuccessResult) {
      if (null == result.getSuccessData()) return;
      typeLeaveList = result.getSuccessData() ?? [];
      print("TypeList: $typeLeaveList");
      refresh();
    } else if (result is ErrorResult) {
      comp.handleApiError(context, error: result.getErrorMessage());
    } else if (result is LoadingResult) {
      loading(true);
    }
  }

  void _observeHolidayList(Result<List<HolidayData>> result) {
    loading(false);
    if (result is SuccessResult) {
      if (null == result.getSuccessData()) return;
      holidayList = result.getSuccessData() ?? [];
      print("holidayList: $holidayList");
      refresh();
    } else if (result is ErrorResult) {
      comp.handleApiError(context, error: result.getErrorMessage());
    } else if (result is LoadingResult) {
      loading(true);
    }
  }

  void _observeHoliday(Result<bool> result) {
    loading(false);
    if (result is SuccessResult) {
      if (null == result.getSuccessData()) return;
      bool isAccepted = result.getSuccessData() ?? false;
      print("isAccepted: $isAccepted");
      if (isAccepted) {
        if (operation == "delete") {
          _holidayDeleteBloc.checkAccepted(
              Urls.holidayDelete, selectedHoliday?.id ?? 0);
        } else if (operation == "update") {
          isEdit = true;
          fillOldData();
        }
      }
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
      comp.handleApiError(context, error: result.getErrorMessage());
    } else if (result is LoadingResult) {
      loading(true);
    }
  }

  void _observeDirectors(Result<List<IdName>> result) {
    loading(false);
    if (result is SuccessResult) {
      if (null == result.getSuccessData()) return;
      directorList = result.getSuccessData() ?? [];
      print("TypeList: $directorList");
      refresh();
    } else if (result is ErrorResult) {
      comp.handleApiError(context, error: result.getErrorMessage());
    } else if (result is LoadingResult) {
      loading(true);
    }
  }

  void _observeHolidayCreate(Result<bool> result) {
    loading(false);
    if (result is SuccessResult) {
      if (null == result.getSuccessData()) return;
      clearAllFields();
      _holidayListBloc.get();
      refresh();
    } else if (result is ErrorResult) {
      comp.handleApiError(context, error: result.getErrorMessage());
    } else if (result is LoadingResult) {
      loading(true);
    }
  }
}
