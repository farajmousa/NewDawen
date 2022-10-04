
// Company  User nam 900000 password 900000
// Usernzmd 17004 - 123456
//"empid":17001,"password":"1032182592",
//رقم الموظف ١٠٧
// الباسورد ١٢٣٤٥٦
class Urls {

  static const String baseUrl = "http://ihratt-001-site19.ftempurl.com"; //"http://ihratt-001-site19.ftempurl.com/api/";
  // static const String baseUrl = "http://faragmosa-001-site5.itempurl.com"; //"http://ihratt-001-site19.ftempurl.com/api/";

  static const String initUrl = "/services/app/";
  static const String companyLogin = "/api/en/company"; //"/api/Company/GetCompanyByCode"; //
  static const String tokenAuth = "/TokenAuth/Authenticate";
  static const String userLogin = "/Login/Login";
  static const String userLogout = "/Login/LogOut";

  static const String holidayCreate =  "/HoldayreqApi/Create/Create"; //initUrl+ "HoldayreqService/Create";
  static const String holidayDelete =  "/HoldayreqApi/Delete/Delete"; //initUrl+ "HoldayreqService/Delete";
  static const String holidayUpdate =  "/HoldayreqApi/Update/Update"; //initUrl+ "HoldayreqService/Update";
  static const String holidayGet =  initUrl+  "VacationService/Get"; //"HoldayreqService/Get";
  static const String holidayGetAll =  "/HoldayreqApi/GetAllByEmployeeId/GetAllByEmployeeId"; //initUrl+ "HoldayreqService/GetAll";
  static const String holidayTypeGetAll = "/HoldayTaypeApi/GetHolidayTypes"; //initUrl+ "HoldayTaypeService/GetAll";

  static const String holidayGetAllAgreements =  "/HoldayreqApi/GetEmplVactionsToAprove/GetEmplVactionsToAprove";//initUrl+ "HoldayreqService/GetEmplVactionsToAprove";
  static const String holidayAgreementAccept =  "/HoldayreqApi/HoldayreqAbrove/HoldayreqAbrove"; //initUrl+ "HoldayreqService/HoldayreqAbrove";
  static const String holidayAgreementReject =  "/HoldayreqApi/HoldayreqReject/HoldayreqReject"; //initUrl+ "HoldayreqService/HoldayreqReject";


  static const String usersList =  initUrl+ "User/GetAll";
  static const String getAllHeadofDeps =  "/EmployeeApi/GetDBBossEmployees"; //initUrl+  "DawamUsersService/GetAllHeadofDeps"; //لجلب حميع روساء الاقسام
  static const String getAllMangers =  "/EmployeeApi/GetManagersEmployees"; //initUrl+ "DawamUsersService/GetAllMangers"; // لجب جميع المديرين
  static const String getAllSupportEmployees = "/EmployeeApi/GetSpareEmployees"; //initUrl+ "DawamUsersService/GetAllSupportEmployees"; // لجلب جميع الموظفين البدلا
  static const String getHomeCounters = "/EmployeeApi/GetHomeCounters"; //initUrl+ "DawamUsersService/GetAllSupportEmployees"; // لجلب جميع الموظفين البدلا


  static const String excuseCreate = "/ExcuseReqApi/Create/Create"; //initUrl+ "ExcuseReqService/Create";
  static const String excuseDelete =  "/ExcuseReqApi/Delete/Delete"; //initUrl+ "ExcuseReqService/Delete";
  static const String excuseUpdate = "/ExcuseReqApi/Update/Update"; //initUrl+ "ExcuseReqService/Update";
  static const String excuseGet =  initUrl+ "ExcuseRequestService/Get";
  static const String excuseGetAll =  "/ExcuseReqApi/GetAllByEmployeeId/GetAllByEmployeeId"; //"​/ExcuseReqApi/GetAllByEmployeeId/GetAllByEmployeeId";
  static const String excuseTypeGetAll =  "/ExcutypeApi/GetAll/GetAll";//initUrl+ "ExcutypeService/GetAll";
  static const String shiftGetAll =  "/ShiftsApi/GetById/GetById"; //initUrl+ "ShiftsService/GetAll";
  static const String excuseAgreementAccept =  "/ExcuseReqApi/AproveExcuseReq/AproveExcuseReq"; //initUrl+ "ExcuseReqService/AproveExcuseReq";
  static const String excuseAgreementReject =  "/ExcuseReqApi/RejectExcuseReq/RejectExcuseReq"; //initUrl+ "ExcuseReqService​/RejectExcuseReq";
  static const String excuseGetAllAgreements = "/ExcuseReqApi/GetEmplExcusereqToAprove/GetEmplExcusereqToAprove";

  static const String absentCreate =  initUrl+ "AbsentService/Create";
  static const String absentDelete =  initUrl+ "AbsentService/Delete";
  static const String absentUpdate = initUrl+ "AbsentService/Update";
  static const String absentGet =  initUrl+ "AbsentService/Get";
  static const String absentGetAll =  initUrl+ "AbsentService/GetAll";

  static const String leaveCreate =  initUrl+ "LeavesService/Create";
  static const String leaveDelete =  initUrl+ "LeavesService/Delete";
  static const String leaveUpdate = initUrl+  "LeavesService/Update";
  static const String leaveGet =  initUrl+ "LeavesService/Get";
  static const String leaveGetAll =  initUrl+ "LeavesService/GetAll";
  static const String leaveTypeGetAll =  initUrl+ "LeavesTypeService/GetAll";


  static const String sendFcmToken = "/Notifications/UpdateUserTokenFirebase/Token"; //Notifications/UpdateUserTokenFirebase/Token
  static const String sendNotification = "/Notifications/SendNotification/SendNotification";
  static const String getNotifications = "/EmployeeApi/GetNotificationsEmpId";

  static const String employeeLocations = "/EmployeeApi/GetEmployeeLocations";
  static const String checkInOut = "/Login/PostCheckInOutMob/PostCheckInOutMob";










}
