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
import 'package:sky_vacation/ui/bloc/execuse_create.dart';
import 'package:sky_vacation/ui/bloc/holiday.dart';
import 'package:sky_vacation/ui/bloc/holiday_delete.dart';
import 'package:sky_vacation/ui/bloc/holiday_list.dart';
import 'package:sky_vacation/ui/bloc/holiday_type.dart';
import 'package:sky_vacation/ui/bloc/user_shift.dart';
import 'package:sky_vacation/ui/components/holiday_list_view_vertical.dart';
import 'package:sky_vacation/ui/screen/home.dart';
import 'package:sky_vacation/ui/widgets/app_button.dart';
import 'package:sky_vacation/ui/widgets/app_drop_down.dart';
import 'package:sky_vacation/ui/widgets/app_text_field.dart';
import '../../helper/app_decoration.dart';
import '../../main.dart';
import 'package:collection/collection.dart';

import 'excuses.dart'; // You have to add this manually, for some reason it cannot be added automatically

// List<IdName> typeExcuseList = [];
// List<IdName> shiftList = [];

class AbsentsScreen extends StatefulWidget {
  @override
  _AbsentsScreenState createState() => _AbsentsScreenState();
}

class _AbsentsScreenState extends ResumableState<AbsentsScreen> {
  DateTime? _startDate;
  DateTime? _endDate;
  List<HolidayData> excuseList = [];
  HolidayData? selectedExcuse;
  String? operation;
  IdName? selectedType;
  IdName? selectedShift;
  IdName? selectedHead;
  IdName? selectedManager;
  IdName? selectedSupportEmp;
  bool isEdit = false;

  bool isLoading = false;
  TextEditingController _reasonCont = TextEditingController();

  final HolidayTypesBloc _excuseTypesBloc = sl<HolidayTypesBloc>();
  // final UserShiftBloc _shiftTypesBloc = sl<UserShiftBloc>();
  final ExecuseCreateBloc _excuseCreateBloc = sl<ExecuseCreateBloc>();
  final HolidayListBloc _excuseListBloc = sl<HolidayListBloc>();
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
    _excuseTypesBloc.mainStream.listen(_observeExcuseTypes);
    _excuseCreateBloc.mainStream.listen(_observeExecuseCreate);
    _excuseListBloc.mainStream.listen(_observeExecuseList);
    _checkItemAcceptedBloc.mainStream.listen(_observeExecuse);
    _holidayDeleteBloc.mainStream.listen(_observeExecuseDelete);
    // _shiftTypesBloc.mainStream.listen(_observeShift);

    _excuseTypesBloc.get(Urls.excuseTypeGetAll);
    // _shiftTypesBloc.get();
    _excuseListBloc.get();
  }

  @override
  void dispose() {
    _excuseTypesBloc.dispose();
    _excuseCreateBloc.dispose();
    _reasonCont.dispose();
    super.dispose();
  }

  @override
  void onResume() {
    super.onResume();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: comp.appBar(Trans.of(context).t("excuses"), backTapped: () {
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
                createExecuseWidget(),
                if (excuseList.isNotEmpty)
                  HolidayListViewVertical(
                    dataList: excuseList,
                    updateDeleteTapped: (holiday, _operation) {
                      selectedExcuse = holiday;
                      operation = _operation;
                      _checkItemAcceptedBloc.checkAccepted(
                          Urls.excuseGet, holiday.id ?? 0);
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

  Widget createExecuseWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(Dim.w4, Dim.w2, Dim.w4, Dim.w2),
      margin: EdgeInsets.only(bottom: Dim.h2),
      decoration: AppDecor.decoration(
          borderColor: AppColor.primary,
          bkgColor: AppColor.bkgBlue,
          borderRadius: Dim.w5, isShadow: false),

      child: ExpandablePanel(
        theme: ExpandableThemeData(headerAlignment: ExpandablePanelHeaderAlignment.center),
        header: Text(
        Trans.of(context).t("create_excuse"),
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
            "${Trans.of(context).t("create_excuse")}:",
            style: TS.boldBlack11,
          ),
          SizedBox(
            height: Dim.h1,
          ),
          dateWidget(context, _startDate, (DateTime? date) {
            _startDate = date;
            refresh();
          }, title: "start_date"),
          dateWidget(context, _endDate, (DateTime? date) {
            _endDate = date;
            refresh();
          }, title: "end_date"),
          AppDropDown(
            hint: 'excuse_type',
            items: typeExcuseList,
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
          // AppDropDown(
          //   hint: 'shift',
          //   items: shiftList,
          //   selectedItem: selectedShift,
          //   onItemChanged: (dynamic? newValue) {
          //     setState(() {
          //       selectedShift = newValue as IdName;
          //     });
          //   },
          //   onDeleteTapped: () {
          //     setState(() {
          //       selectedShift = null;
          //     });
          //   },
          // ),
          AppTextField(
            fillColor: AppColor.white,
            enable: true,
            hint: Trans.of(context).t('excuse_reason'),
            isRequired: true,
            inputType: TextInputType.text,
            controller: _reasonCont,
            onValueChanged: (value) {},
            onValidate: (value) {
              if ((value ?? "").isEmpty) {
                return Trans.of(context).t('empty_field');
              }
              return null;
            },
          ),
          AppDropDown(
            hint: 'head_department',
            items: headDepartList,
            selectedItem: selectedHead,
            onItemChanged: (dynamic? newValue) {
              setState(() {
                selectedHead = newValue as IdName;
              });
            },
            onDeleteTapped: () {
              setState(() {
                selectedHead = null;
              });
            },
          ),
          AppDropDown(
            hint: 'director',
            items: managerList,
            selectedItem: selectedManager,
            onItemChanged: (dynamic? newValue) {
              setState(() {
                selectedManager = newValue as IdName;
              });
            },
            onDeleteTapped: () {
              setState(() {
                selectedManager = null;
              });
            },
          ),
          AppDropDown(
            hint: 'substitute_employee',
            items: supportEmployeeList,
            selectedItem: selectedSupportEmp,
            onItemChanged: (dynamic? newValue) {
              setState(() {
                selectedSupportEmp = newValue as IdName;
              });
            },
            onDeleteTapped: () {
              setState(() {
                selectedSupportEmp = null;
              });
            },
          ),
          AppButton(
            title: Trans.of(context).t("send"),
            onTap: () {
              // if (null != _startDate && null != _endDate &&
              //     _reasonCont.text.isNotEmpty &&
              //     null != selectedHead &&
              //     null != selectedDirector &&
              //     null != selectedSubstitute &&
              //     null != selectedType && null != selectedShift) {
              //   _excuseCreateBloc.create(_startDate!, _endDate!, selectedHead?.id ?? 0,selectedDirector?.id ?? 0,
              //       selectedSubstitute?.id ?? 0, selectedType?.id ?? 0, selectedShift?.id ?? 0,_reasonCont.text,holidayId: isEdit? selectedExcuse?.id : 0);
              // } else {
              //   comp.displayDialog(context, Trans.of(context).t("fill_fields"));
              // }
            },
          ),
          SizedBox(
            height: Dim.h3,
          ),
        ],
      ),
    ),);
  }

  void clearAllFields() {
    _startDate = null;
    _endDate = null;
    selectedType = null;
    selectedShift = null;
    _reasonCont.text = "";
    selectedSupportEmp = null;
    selectedHead = null;
    selectedManager = null;
    isEdit = false;
    selectedExcuse = null;
    operation = null;
    refresh();
  }

  void fillOldData() {
    _startDate = au.formatDateGlobal(selectedExcuse?.datereq ?? "");
    _endDate = au.formatDateGlobal(selectedExcuse?.datereq ?? "");
    selectedType = typeExcuseList.firstWhereOrNull(
        (element) => element.id == selectedExcuse?.holdaytype);
    selectedShift = typeExcuseList.firstWhereOrNull(
        (element) => element.id == selectedExcuse?.holdaytype);
    _reasonCont.text = "${selectedExcuse?.briod ?? 0}";
    selectedSupportEmp = supportEmployeeList.firstWhereOrNull(
        (element) => element.id == selectedExcuse?.empsupport);
    selectedHead = managerList
        .firstWhereOrNull((element) => element.id == selectedExcuse?.dbbossid);
    selectedManager = managerList
        .firstWhereOrNull((element) => element.id == selectedExcuse?.bossid);
    refresh();
  }

  //--------------------------
  void _observeExcuseTypes(Result<List<IdName>> result) {
    loading(false);
    if (result is SuccessResult) {
      if (null == result.getSuccessData()) return;
      typeExcuseList = result.getSuccessData() ?? [];
      print("TypeList: $typeExcuseList");
      refresh();
    } else if (result is ErrorResult) {
      comp.handleApiError(context, error: result.getErrorMessage());
    } else if (result is LoadingResult) {
      loading(true);
    }
  }

  // void _observeShift(Result<List<IdName>> result) {
  //   loading(false);
  //   if (result is SuccessResult) {
  //     if (null == result.getSuccessData()) return;
  //     shiftList = result.getSuccessData() ?? [];
  //     print("shiftList: $typeExcuseList");
  //     refresh();
  //   } else if (result is ErrorResult) {
  //     comp.handleApiError(context, error: result.getErrorMessage());
  //   } else if (result is LoadingResult) {
  //     loading(true);
  //   }
  // }

  void _observeExecuseList(Result<List<HolidayData>> result) {
    loading(false);
    if (result is SuccessResult) {
      if (null == result.getSuccessData()) return;
      excuseList = result.getSuccessData() ?? [];
      print("holidayList: $excuseList");
      refresh();
    } else if (result is ErrorResult) {
      comp.handleApiError(context, error: result.getErrorMessage());
    } else if (result is LoadingResult) {
      loading(true);
    }
  }

  void _observeExecuse(Result<bool> result) {
    loading(false);
    if (result is SuccessResult) {
      if (null == result.getSuccessData()) return;
      bool isAccepted = result.getSuccessData() ?? false;
      print("isAccepted: $isAccepted");
      if (isAccepted) {
        if (operation == "delete") {
          _holidayDeleteBloc.checkAccepted(
              Urls.excuseDelete, selectedExcuse?.id ?? 0);
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

  void _observeExecuseDelete(Result<bool> result) {
    loading(false);
    if (result is SuccessResult) {
      if (null == result.getSuccessData()) return;
      excuseList = [];
      _excuseListBloc.get();
      comp.displayToast(context, Trans.of(context).t("done_success"));
    } else if (result is ErrorResult) {
      comp.handleApiError(context, error: result.getErrorMessage());
    } else if (result is LoadingResult) {
      loading(true);
    }
  }

  void _observeExecuseCreate(Result<bool> result) {
    loading(false);
    if (result is SuccessResult) {
      if (null == result.getSuccessData()) return;
      clearAllFields();
      _excuseListBloc.get();
      refresh();
    } else if (result is ErrorResult) {
      comp.handleApiError(context, error: result.getErrorMessage());
    } else if (result is LoadingResult) {
      loading(true);
    }
  }
}
