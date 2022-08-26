import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import 'package:sky_vacation/base/result.dart';
import 'package:sky_vacation/data/api/api_urls.dart';
import 'package:sky_vacation/data/model/entity/excuse_data.dart';
import 'package:sky_vacation/di/injection_container.dart';
import 'package:sky_vacation/data/model/entity/id_name.dart';
import 'package:sky_vacation/helper/app_color.dart';
import 'package:sky_vacation/helper/dim.dart';
import 'package:sky_vacation/helper/font_style.dart';
import '../../helper/app_color.dart';
import 'package:sky_vacation/helper/localize.dart';
import 'package:sky_vacation/ui/bloc/excuse_list.dart';
import 'package:sky_vacation/ui/bloc/execuse_create.dart';
import 'package:sky_vacation/ui/bloc/holiday.dart';
import 'package:sky_vacation/ui/bloc/holiday_delete.dart';
import 'package:sky_vacation/ui/bloc/holiday_type.dart';
import 'package:sky_vacation/ui/bloc/user_shift.dart';
import 'package:sky_vacation/ui/components/excuse_list_view_vertical.dart';
import 'package:sky_vacation/ui/screen/home.dart';
import 'package:sky_vacation/ui/widgets/app_button.dart';
import 'package:sky_vacation/ui/widgets/app_drop_down.dart';
import 'package:sky_vacation/ui/widgets/app_text_field.dart';
import '../../helper/app_decoration.dart';
import '../../main.dart';
import 'package:collection/collection.dart';
import '../widgets/loading_indicator.dart'; // You have to add this manually, for some reason it cannot be added automatically

List<IdName> typeExcuseList = [];
// List<IdName> shiftList = [];

class ExcuseScreen extends StatefulWidget {
  @override
  _ExcuseScreenState createState() => _ExcuseScreenState();
}

class _ExcuseScreenState extends ResumableState<ExcuseScreen> {
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  DateTime? _selectedDate;
  List<ExcuseData> excuseList = [];
  ExcuseData? selectedExcuse;
  String? operation;
  IdName? selectedType;

  // IdName? selectedShift;
  IdName? selectedHeadDepart;
  IdName? selectedManager;
  IdName? selectedSupportEmp;
  bool isEdit = false;

  bool noResults = false;
  bool isLoading = false;
  TextEditingController _reasonCont = TextEditingController();

  final HolidayTypesBloc _excuseTypesBloc = sl<HolidayTypesBloc>();

  // final UserShiftBloc _shiftTypesBloc = sl<UserShiftBloc>();
  final ExecuseCreateBloc _excuseCreateBloc = sl<ExecuseCreateBloc>();
  final ExcuseListBloc _excuseListBloc = sl<ExcuseListBloc>();
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
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Stack(children: [
          Container(
            color: AppColor.whiteColor,
            margin: EdgeInsets.symmetric(horizontal: Dim.w4, vertical: Dim.h2),
            child: Column(
              children: <Widget>[
                createExecuseWidget(),
                if (excuseList.isNotEmpty)
                  Expanded(
                    child: ExcuseListViewVertical(
                      dataList: excuseList,
                      updateDeleteTapped: (holiday, _operation) {
                        selectedExcuse = holiday;
                        operation = _operation;
                        _checkItemAcceptedBloc.checkAccepted(
                            Urls.excuseGet, holiday.id ?? 0);
                      },
                    ),
                  ),
                if (noResults) comp.notFoundWidget(context)
              ],
            ),
          ),
          if (isLoading) LoadingIndicator(),
        ]),
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
          borderRadius: Dim.w5,
          isShadow: false),
      child: ExpandablePanel(
        theme: ExpandableThemeData(
            headerAlignment: ExpandablePanelHeaderAlignment.center),
        header: Text(
          Trans.of(context).t("create_excuse"),
          style: TS.boldBlack11,
        ),
        collapsed: Center(),
        expanded: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: Dim.h1,
            ),
            dateWidget(context, _selectedDate, (DateTime? date) {
              _selectedDate = date;
              refresh();
            }),
            AppDropDown(
              hint: 'excuse_type',
              items: typeExcuseList,
              selectedItem: selectedType,
              onItemChanged: (dynamic? newValue) {
                setState(() {
                  _startTime = _endTime = null;
                  selectedType = newValue as IdName;
                });
              },
              onDeleteTapped: () {
                setState(() {
                  selectedType = null;
                });
              },
            ),
            if (selectedType?.id == 3 || selectedType?.id == 6)
              timeWidget(context, _startTime, (TimeOfDay? time) {
                _startTime = time;
                refresh();
              }, title: "start_time"),
            if (selectedType?.id == 3 || selectedType?.id == 6)
              timeWidget(context, _endTime, (TimeOfDay? time) {
                _endTime = time;
                refresh();
              }, title: "end_time"),

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
              selectedItem: selectedHeadDepart,
              onItemChanged: (dynamic? newValue) {
                setState(() {
                  selectedHeadDepart = newValue as IdName;
                });
              },
              onDeleteTapped: () {
                setState(() {
                  selectedHeadDepart = null;
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
                print("selectedType?.id: ${selectedType?.id}");
                if (null != _selectedDate &&
                    _reasonCont.text.isNotEmpty &&
                    null != selectedHeadDepart &&
                    null != selectedManager &&
                    null != selectedSupportEmp &&
                    null != selectedType) {
                  if ((selectedType?.id == 3 || selectedType?.id == 6)) {
                    if (null != _startTime && null != _endTime) {
                      _excuseCreateBloc.create(
                          _startTime,
                          _endTime,
                          _selectedDate!,
                          selectedManager?.id ?? 0,
                          selectedHeadDepart?.id ?? 0,
                          selectedSupportEmp?.id ?? 0,
                          selectedType?.id ?? 0,
                          _reasonCont.text,
                          holidayId: isEdit ? selectedExcuse?.id : 0);
                    } else {
                      comp.displayDialog(
                          context, Trans.of(context).t("fill_fields"));
                    }
                  } else {
                    _excuseCreateBloc.create(
                        null,
                        null,
                        _selectedDate!,
                        selectedManager?.id ?? 0,
                        selectedHeadDepart?.id ?? 0,
                        selectedSupportEmp?.id ?? 0,
                        selectedType?.id ?? 0,
                        _reasonCont.text,
                        holidayId: isEdit ? selectedExcuse?.id : 0);
                  }
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
    _startTime = null;
    _endTime = null;
    _selectedDate = null;
    selectedType = null;
    _reasonCont.text = "";
    selectedSupportEmp = null;
    selectedHeadDepart = null;
    selectedManager = null;
    isEdit = false;
    selectedExcuse = null;
    operation = null;
    refresh();
  }

  void fillOldData() {
    _startTime = au.parseTime(selectedExcuse?.stime ?? "");
    _endTime = au.parseTime(selectedExcuse?.etime ?? "");
    selectedType = typeExcuseList
        .firstWhereOrNull((element) => element.id == selectedExcuse?.typeid);
    // selectedShift = shiftList
    //     .firstWhereOrNull((element) => element.id == selectedExcuse?.shiftid);
    _selectedDate =
        au.formatDateGlobal(selectedExcuse?.edate ?? "1443-11-23T00:00:00");
    _startTime = au.parseTime(selectedExcuse?.stime ?? "00:00:00");
    _endTime = au.parseTime(selectedExcuse?.etime ?? "00:00:00");

    _reasonCont.text = "${selectedExcuse?.excwhy ?? 0}";
    selectedSupportEmp = supportEmployeeList.firstWhereOrNull(
        (element) => element.id == selectedExcuse?.empsupport);
    selectedHeadDepart = headDepartList
        .firstWhereOrNull((element) => element.id == selectedExcuse?.bossid);
    selectedManager = managerList
        .firstWhereOrNull((element) => element.id == selectedExcuse?.dbbossIdd);

    for(var  item in managerList){
      print("#Manager: ${item.id} - ${item.name} - ${selectedExcuse?.dbbossIdd}");
    }

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

  void _observeExecuseList(Result<List<ExcuseData>> result) {
    loading(false);
    if (result is SuccessResult) {
      if (null == result.getSuccessData()) return;
      excuseList = result.getSuccessData() ?? [];
      noResults = (excuseList.isEmpty) ? true : false;
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
