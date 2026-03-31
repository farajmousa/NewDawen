
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dawim/data/api/api_repo.dart';
import 'package:dawim/helper/app_util.dart';
import 'package:dawim/helper/session_manager.dart';
import 'package:dawim/ui/bloc/absent_create.dart';
import 'package:dawim/ui/bloc/absent_list.dart';
import 'package:dawim/ui/bloc/direstors.dart';
import 'package:dawim/ui/bloc/excuse_list.dart';
import 'package:dawim/ui/bloc/execuse_create.dart';
import 'package:dawim/ui/bloc/holiday.dart';
import 'package:dawim/ui/bloc/holiday_agreement_action.dart';
import 'package:dawim/ui/bloc/holiday_create.dart';
import 'package:dawim/ui/bloc/holiday_delete.dart';
import 'package:dawim/ui/bloc/holiday_list.dart';
import 'package:dawim/ui/bloc/holiday_list_agreements.dart';
import 'package:dawim/ui/bloc/holiday_type.dart';
import 'package:dawim/ui/bloc/leave_create.dart';
import 'package:dawim/ui/bloc/leave_list.dart';
import 'package:dawim/ui/bloc/login.dart';
import 'package:dawim/ui/bloc/loginCompany.dart';
import 'package:dawim/ui/bloc/send_fcm_token.dart';
import 'package:dawim/ui/bloc/user_shift.dart';
import 'package:dawim/ui/bloc/token.dart';
import 'package:dawim/ui/widgets/components.dart';

import '../ui/bloc/check_in_out.dart';
import '../ui/bloc/excuse_list_agreements.dart';
import '../ui/bloc/home_notification_counter.dart';
import '../ui/bloc/logout.dart';
import '../ui/bloc/notifications.dart';
import '../ui/bloc/user_locations_list.dart';


final sl = GetIt.instance;

Future<void> init() async {
  //! init external
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => prefs);
  sl.registerLazySingleton(() => Client());

  //! init core
  sl.registerLazySingleton(() => SessionManager(sl()));
  sl.registerLazySingleton(() => Components());
  sl.registerLazySingleton(() => AppUtil());

//api
  sl.registerLazySingleton(() => ApiRepo(sl(),));

  //! init features
  injectBlocs();
}

void injectBlocs() {

  sl.registerFactory(() => LoginCompanyBloc(sl()));
  sl.registerFactory(() => LoginBloc(sl()));
  sl.registerFactory(() => LogoutBloc(sl()));
  sl.registerFactory(() => TokenBloc(sl()));
  sl.registerFactory(() => HolidayTypesBloc(sl()));
  sl.registerFactory(() => HolidayCreateBloc(sl()));
  sl.registerFactory(() => DirectorsBloc(sl()));
  sl.registerFactory(() => HolidayListBloc(sl()));
  sl.registerFactory(() => CheckItemAcceptedBloc(sl()));
  sl.registerFactory(() => HolidayDeleteBloc(sl()));
  sl.registerFactory(() => HomeNotificationCounterBloc(sl()));


  sl.registerFactory(() => UserShiftBloc(sl()));
  sl.registerFactory(() => ExecuseCreateBloc(sl()));
  sl.registerFactory(() => ExcuseListBloc(sl()));
  sl.registerFactory(() => ExcuseListAgreementBloc(sl()));
  sl.registerFactory(() => HolidayAgreementActionBloc(sl()));
  sl.registerFactory(() => HolidayListAgreementBloc(sl()));


  sl.registerFactory(() => AbsentCreateBloc(sl()));
  sl.registerFactory(() => LeaveCreateBloc(sl()));
  sl.registerFactory(() => LeaveListBloc(sl()));
  sl.registerFactory(() => AbsentListBloc(sl()));
  sl.registerFactory(() => SendFcmTokenBloc(sl()));

  sl.registerFactory(() => UserLocationsListBloc(sl()));
  sl.registerFactory(() => CheckInOutBloc(sl()));
  sl.registerFactory(() => NotificationsBloc(sl()));






  

}
