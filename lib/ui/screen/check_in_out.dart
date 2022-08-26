import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:need_resume/need_resume.dart';
import 'package:sky_vacation/data/model/entity/location_data.dart';
import 'package:sky_vacation/helper/dim.dart';
import 'package:sky_vacation/helper/font_style.dart';
import 'package:sky_vacation/main.dart';
import 'package:sky_vacation/data/model/entity/user.dart';
import 'package:sky_vacation/ui/bloc/check_in_out.dart';
import '../../helper/app_color.dart';
import 'package:sky_vacation/helper/localize.dart';
import 'package:sky_vacation/ui/widgets/app_drop_down.dart';
import '../../base/result.dart';
import '../../di/injection_container.dart';
import '../../helper/app_constant.dart';
import '../bloc/user_locations_list.dart';
import '../components/image_picker.dart';
import '../components/rounded_button.dart';
import '../widgets/loading_indicator.dart';

class CheckInOutScreen extends StatefulWidget {
  @override
  _CheckInOutScreenState createState() => _CheckInOutScreenState();
}

class _CheckInOutScreenState extends ResumableState<CheckInOutScreen> {
  bool? checkInDisabled;
  bool? checkInLoading;
  bool? supervisorDisabled;
  bool? supervisorLoading;
  bool? checkOutDisabled;
  bool? checkOutLoading;
  List<LocationData> locationList = [];
  int selectedLocationIndex = -2;
  File? imageFile;
  User? user;
  bool isLoading = false;
  int shiftId = 0;

  final UserLocationsListBloc _userLocationsListBloc =
      sl<UserLocationsListBloc>();
  final CheckInOutBloc _checkInOutBloc = sl<CheckInOutBloc>();

  refresh() {
    if (mounted) setState(() {});
  }

  loading(bool load) {
    isLoading = load;
    refresh();
  }

  FToast fToast = FToast();
  @override
  void initState() {
    _userLocationsListBloc.mainStream.listen(_observeUserLocationList);
    _checkInOutBloc.mainStream.listen(_observeCheckInOut);
    _userLocationsListBloc.get();

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      user = sm.getUser();
    });

    super.initState();
    fToast.init(context);
  }

  @override
  void dispose() {
    _checkInOutBloc.dispose();
    _userLocationsListBloc.dispose();
    super.dispose();
  }

  @override
  void onResume() {
    super.onResume();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          comp.appBar(Trans.of(context).t("checkin_checkout"), backTapped: () {
        Navigator.of(context).pop();
      }),
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.symmetric(horizontal: Dim.w4),
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Text(
                  Trans.of(context).t("selectLocation"),
                  style: TS.boldBlack10,
                ),
                locationsDropDown(),
                // (null != user && (user?.imageRequired ?? false))
                //     ? Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(Trans.of(context).t("insertFaceRecogn"),
                //           textAlign: TextAlign.right, style: TS.medPrimary10),
                //       MyImagePicker(
                //         size: 120,
                //         imageFile: imageFile,
                //         onImagePicked: (String value) {
                //           print("$value");
                //           setState(() {
                //             imageFile = File(value);
                //           });
                //         },
                //       ),
                //     ],
                //   ),
                // )
                //     : Center(),
                SizedBox(
                  height: Dim.h5,
                ),
                RoundedButton(
                  icon: Icons.check,
                  verticalMargin: Dim.h1,
                  fontSize: Dim.s10,
                  onPressed: () {
                    print("Camera file: $imageFile");
                    if (selectedLocationIndex > -2) {
                      if (user?.imageRequired ?? false) {
                        if (null != user && null != imageFile) {
                          callCheckInOutApi(CheckInOut.checkIn);
                        } else {
                          comp.displayToast(
                              context, Trans.of(context).t("insertImageFace"));
                        }
                      } else {
                        callCheckInOutApi(1);
                      }
                    } else {
                      comp.displayToast(
                          context, Trans.of(context).t("selectLocationFirst"));
                   //   showCustomToast("llllllllllllllllll");
                    }
                  },
                  disabled: checkInDisabled ?? false,
                  text: Trans.of(context).t("check_in"),
                  loading: checkInLoading ?? false,
                  backgroundColor: AppColor.primary,
                ),
                SizedBox(
                  height: Dim.h5,
                ),
                RoundedButton(
                  icon: Icons.check,
                  verticalMargin: Dim.h1,
                  fontSize: Dim.s10,
                  onPressed: () {
                    print("Camera file: $imageFile");
                    if (selectedLocationIndex > -2) {
                      if (user?.imageRequired ?? false) {
                        if (null != user && null != imageFile) {
                          callCheckInOutApi(CheckInOut.recheck);
                        } else {
                          comp.displayToast(
                              context, Trans.of(context).t("insertImageFace"));
                        }
                      } else {
                        callCheckInOutApi(CheckInOut.recheck);
                      }
                    } else {
                      comp.displayToast(
                          context, Trans.of(context).t("selectLocationFirst"));
                    }
                  },
                  disabled: checkInDisabled ?? false,
                  text: Trans.of(context).t("recheck"),
                  loading: checkInLoading ?? false,
                  backgroundColor: AppColor.primary,
                ),

                SizedBox(
                  height: Dim.h4,
                ),
                RoundedButton(
                  icon: Icons.close,
                  verticalMargin: Dim.h1,
                  fontSize: Dim.s10,
                  onPressed: () {
                    if (selectedLocationIndex > -2) {
                      if (user?.imageRequired ?? false) {
                        if (null != user && null != imageFile) {
                          callCheckInOutApi(CheckInOut.checkOut);
                        } else {
                          comp.displayToast(
                              context, Trans.of(context).t("insertImageFace"));
                          // showToasted("hhhh");

                        }
                      } else {
                        callCheckInOutApi(CheckInOut.checkOut);
                        //  showToasted("kkkk");

                      }
                    } else {
                      comp.displayToast(
                          context, Trans.of(context).t("selectLocationFirst"));
                    }
                  },
                  disabled: checkOutDisabled ?? false,
                  text: Trans.of(context).t("check_out"),
                  loading: checkOutLoading ?? false,
                  backgroundColor: AppColor.red,
                ),
              ],
            ),
            if (isLoading) LoadingIndicator(),
          ],
        ),
      ),
    );
  }

  callCheckInOutApi(int mode) {
    _checkInOutBloc.create(
      mode,
      (selectedLocationIndex > -1)
          ? locationList[selectedLocationIndex].id ?? 0
          : null,
    );
  }

  Widget locationsDropDown() {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      children: [
        // InkWell(
        //   onTap: () {
        //     setState(() {
        //       selectedLocationIndex = -1;
        //     });
        //   },
        //   child: Container(
        //       height: 50,
        //       alignment: Alignment.center,
        //       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        //       decoration: BoxDecoration(
        //           color: (selectedLocationIndex == -1)
        //               ? Colors.lightGreen.shade100
        //               : Colors.white,
        //           border: Border.all(color: AppColor.primaryColor),
        //           borderRadius: BorderRadius.circular(10)),
        //       child: Text(Trans.of(context).t("randomRecogn"),
        //           textAlign: TextAlign.center, style: TS.medPrimary10)),
        // ),
        // SizedBox(
        //   height: 10,
        // ),
        // Text(Trans.of(context).t("or"),
        //     textAlign: TextAlign.center,
        //     style: TS.homeTextAppBar.copyWith(
        //         fontSize: Dim.fontSize14,
        //         color: AppColor.primaryColor,
        //         fontWeight: FontWeight.w800)),
        // SizedBox(
        //   height: 10,
        // ),
        AppDropDown(
          hint: 'districtedRecogn',
          items: locationList,
          selectedItem: (selectedLocationIndex >= 0)
              ? locationList[selectedLocationIndex]
              : null,
          onItemChanged: (dynamic? newValue) {
            setState(() {
              var index = locationList.indexOf(newValue as LocationData);
              selectedLocationIndex = index;
            });
          },
          onDeleteTapped: () {
            setState(() {
              selectedLocationIndex = -2;
            });
          },
        ),
      ],
      // ),
    );
  }

  //--------------------------

  void _observeUserLocationList(Result<List<LocationData>> result) {
    loading(false);
    if (result is SuccessResult) {
      if (null == result.getSuccessData()) return;
      locationList = result.getSuccessData() ?? [];
      print("holidayList: $locationList");
      refresh();
    } else if (result is ErrorResult) {
      comp.handleApiError(context, error: result.getErrorMessage());
    } else if (result is LoadingResult) {
      loading(true);
    }
  }

  void _observeCheckInOut(Result<bool> result) {
    loading(false);
    if (result is SuccessResult) {
      comp.displayToast(context, Trans.of(context).t("done_success"));

      Navigator.pop(context);
    } else if (result is ErrorResult) {
      comp.handleApiError(context, error: result.getErrorMessage());
    } else if (result is LoadingResult) {
      loading(true);
    }
  }

  void showToasted(String msg) => Fluttertoast.showToast(
        msg: msg,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 10,
        backgroundColor: Colors.green,
        toastLength: Toast.LENGTH_LONG,
      );

  // showCustomToast(String msg) {
  //   Widget toast = Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(25.0),
  //       color: Colors.greenAccent,
  //     ),
  //     child: Text(msg),
  //   );

  //   fToast!.showToast(
  //     child: toast,
  //     toastDuration: Duration(seconds: 15),
  //     gravity: ToastGravity.TOP,
  //   );
  // }
}
