import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import 'package:sky_vacation/base/result.dart';
import 'package:sky_vacation/data/api/api_urls.dart';
import 'package:sky_vacation/data/model/entity/holiday_data.dart';
import 'package:sky_vacation/di/injection_container.dart';
import 'package:sky_vacation/data/model/entity/id_name.dart';
import 'package:sky_vacation/helper/app_color.dart';
import 'package:sky_vacation/helper/app_decoration.dart';
import 'package:sky_vacation/helper/dim.dart';
import 'package:sky_vacation/helper/font_style.dart';
import '../../helper/app_color.dart';
import 'package:sky_vacation/helper/localize.dart';
import 'package:sky_vacation/ui/bloc/holiday.dart';
import 'package:sky_vacation/ui/bloc/holiday_create.dart';
import 'package:sky_vacation/ui/bloc/holiday_delete.dart';
import 'package:sky_vacation/ui/bloc/holiday_list.dart';
import 'package:sky_vacation/ui/bloc/holiday_type.dart';
import 'package:sky_vacation/ui/components/holiday_list_view_vertical.dart';
import 'package:sky_vacation/ui/screen/home.dart';
import 'package:sky_vacation/ui/widgets/app_button.dart';
import 'package:sky_vacation/ui/widgets/app_drop_down.dart';
import 'package:sky_vacation/ui/widgets/app_text_field.dart';
import '../../main.dart';
import 'package:collection/collection.dart';
import '../widgets/loading_indicator.dart'; // You have to add this manually, for some reason it cannot be added automatically


List<IdName> typeHolidayList = [];

class HolidayScreen extends StatefulWidget {
  @override
  _HolidayScreenState createState() => _HolidayScreenState();
}

class _HolidayScreenState extends ResumableState<HolidayScreen> {
  DateTime? _selectedDate;
  List<HolidayData> holidayList = [];
  HolidayData? selectedHoliday;
  String? operation;
  IdName? selectedType;
  IdName? selectedHeadDepart;
  IdName? selectedManager;
  IdName? selectedSupportEmp;
  bool isEdit = false;

  bool isLoading = false;
  bool noResults = false;

  TextEditingController _periodCont = TextEditingController();

  final HolidayTypesBloc _holidayTypesBloc = sl<HolidayTypesBloc>();
  final HolidayCreateBloc _holidayCreateBloc = sl<HolidayCreateBloc>();
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

    _holidayTypesBloc.get(Urls.holidayTypeGetAll);
    _holidayListBloc.get();
  }

  @override
  void dispose() {
    _holidayTypesBloc.dispose();
    _holidayCreateBloc.dispose();
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
      appBar: comp.appBar(Trans.of(context).t("holidays"), backTapped: () {
        Navigator.of(context).pop();
      }),
      backgroundColor: AppColor.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(

          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: Dim.w4, vertical: Dim.h2),
              child: Column(
                children: <Widget>[
                  createHolidayWidget(),
                  if (holidayList.isNotEmpty)
                   Expanded(child:  HolidayListViewVertical(
                     dataList: holidayList,
                     updateDeleteTapped: (holiday, _operation) {
                       selectedHoliday = holiday;
                       operation = _operation;
                       _checkItemAcceptedBloc.checkAccepted(
                           Urls.holidayGet, holiday.id ?? 0);
                     },
                   ),),

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

  Widget createHolidayWidget() {
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
          Trans.of(context).t("create_holiday"),
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
              hint: 'select_type',
              items: typeHolidayList,
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
              hint: Trans.of(context).t('period'),
              isRequired: true,
              inputType: TextInputType.number,
              controller: _periodCont,
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
                if (null != _selectedDate &&
                    _periodCont.text.isNotEmpty &&
                    null != selectedHeadDepart &&
                    null != selectedManager &&
                    null != selectedSupportEmp &&
                    null != selectedType) {
                  _holidayCreateBloc.create(
                      _selectedDate!,
                      int.tryParse(_periodCont.text) ?? 0,
                      selectedManager?.id ?? 0,
                      selectedHeadDepart?.id ?? 0,
                      selectedSupportEmp?.id ?? 0,
                      selectedType?.id ?? 0,
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
    _periodCont.text = "";
    selectedSupportEmp = null;
    selectedHeadDepart = null;
    selectedManager = null;
    isEdit = false;
    selectedHoliday = null;
    operation = null;
    refresh();
  }

  void fillOldData() {
    _selectedDate = au.formatDateGlobal(selectedHoliday?.datereq ?? "");
    selectedType = typeHolidayList.firstWhereOrNull(
        (element) => element.id == selectedHoliday?.holdaytype);
    _periodCont.text = "${selectedHoliday?.briod ?? 0}";
    selectedSupportEmp = supportEmployeeList.firstWhereOrNull(
        (element) => element.id == selectedHoliday?.empsupport);
    selectedHeadDepart = headDepartList
        .firstWhereOrNull((element) => element.id == selectedHoliday?.bossid);
    selectedManager = managerList
        .firstWhereOrNull((element) => element.id == selectedHoliday?.dbbossid);
    refresh();
  }

  //--------------------------
  void _observeHolidayTypes(Result<List<IdName>> result) {
    loading(false);
    if (result is SuccessResult) {
      if (null == result.getSuccessData()) return;
      typeHolidayList = result.getSuccessData() ?? [];
      print("TypeList: $typeHolidayList");
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
      noResults = (holidayList.isEmpty)? true: false;
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
