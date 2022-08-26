
// Company  User nam 900000 password 900000
// Usernzmd 17004 - 123456
//"empid":17001,"password":"1032182592",
//رقم الموظف ١٠٧
// الباسورد ١٢٣٤٥٦
class Urls {

  static final String baseUrl = "http://ihratt-001-site19.ftempurl.com"; //"http://ihratt-001-site19.ftempurl.com/api/";
  // static final String baseUrl = "http://faragmosa-001-site5.itempurl.com"; //"http://ihratt-001-site19.ftempurl.com/api/";

  static final String initUrl = "/services/app/";
  static final String companyLogin = "/api/en/company"; //"/api/Company/GetCompanyByCode"; //
  static final String tokenAuth = "/TokenAuth/Authenticate";
  static final String userLogin = "/Login/Login";
  static final String sendNotification = "/api/Notifications/SendNotification/SendNotification";

  static final String holidayCreate =  "/HoldayreqApi/Create/Create"; //initUrl+ "HoldayreqService/Create";
  static final String holidayDelete =  "/HoldayreqApi/Delete/Delete"; //initUrl+ "HoldayreqService/Delete";
  static final String holidayUpdate =  "/HoldayreqApi/Update/Update"; //initUrl+ "HoldayreqService/Update";
  static final String holidayGet =  initUrl+  "VacationService/Get"; //"HoldayreqService/Get";
  static final String holidayGetAll =  "/HoldayreqApi/GetAllByEmployeeId/GetAllByEmployeeId"; //initUrl+ "HoldayreqService/GetAll";
  static final String holidayTypeGetAll = "/HoldayTaypeApi/GetHolidayTypes"; //initUrl+ "HoldayTaypeService/GetAll";

  static final String holidayGetAllAgreements =  "/HoldayreqApi/GetEmplVactionsToAprove/GetEmplVactionsToAprove";//initUrl+ "HoldayreqService/GetEmplVactionsToAprove";
  static final String holidayAgreementAccept =  "/HoldayreqApi/HoldayreqAbrove/HoldayreqAbrove"; //initUrl+ "HoldayreqService/HoldayreqAbrove";
  static final String holidayAgreementReject =  "/HoldayreqApi/HoldayreqReject/HoldayreqReject"; //initUrl+ "HoldayreqService/HoldayreqReject";


  static final String usersList =  initUrl+ "User/GetAll";
  static final String getAllHeadofDeps =  "/EmployeeApi/GetDBBossEmployees"; //initUrl+  "DawamUsersService/GetAllHeadofDeps"; //لجلب حميع روساء الاقسام
  static final String getAllMangers =  "/EmployeeApi/GetManagersEmployees"; //initUrl+ "DawamUsersService/GetAllMangers"; // لجب جميع المديرين
  static final String getAllSupportEmployees = "/EmployeeApi/GetSpareEmployees"; //initUrl+ "DawamUsersService/GetAllSupportEmployees"; // لجلب جميع الموظفين البدلا
  static final String getHomeCounters = "/EmployeeApi/GetHomeCounters"; //initUrl+ "DawamUsersService/GetAllSupportEmployees"; // لجلب جميع الموظفين البدلا


  static final String excuseCreate = "/ExcuseReqApi/Create/Create"; //initUrl+ "ExcuseReqService/Create";
  static final String excuseDelete =  "/ExcuseReqApi/Delete/Delete"; //initUrl+ "ExcuseReqService/Delete";
  static final String excuseUpdate = "/ExcuseReqApi/Update/Update"; //initUrl+ "ExcuseReqService/Update";
  static final String excuseGet =  initUrl+ "ExcuseRequestService/Get";
  static final String excuseGetAll =  "/ExcuseReqApi/GetAllByEmployeeId/GetAllByEmployeeId"; //"​/ExcuseReqApi/GetAllByEmployeeId/GetAllByEmployeeId";
  static final String excuseTypeGetAll =  "/ExcutypeApi/GetAll/GetAll";//initUrl+ "ExcutypeService/GetAll";
  static final String shiftGetAll =  "/ShiftsApi/GetById/GetById"; //initUrl+ "ShiftsService/GetAll";
  static final String excuseAgreementAccept =  "/ExcuseReqApi/AproveExcuseReq/AproveExcuseReq"; //initUrl+ "ExcuseReqService/AproveExcuseReq";
  static final String excuseAgreementReject =  "/ExcuseReqApi/RejectExcuseReq/RejectExcuseReq"; //initUrl+ "ExcuseReqService​/RejectExcuseReq";
  static final String excuseGetAllAgreements = "/ExcuseReqApi/GetEmplExcusereqToAprove/GetEmplExcusereqToAprove";

  static final String absentCreate =  initUrl+ "AbsentService/Create";
  static final String absentDelete =  initUrl+ "AbsentService/Delete";
  static final String absentUpdate = initUrl+ "AbsentService/Update";
  static final String absentGet =  initUrl+ "AbsentService/Get";
  static final String absentGetAll =  initUrl+ "AbsentService/GetAll";

  static final String leaveCreate =  initUrl+ "LeavesService/Create";
  static final String leaveDelete =  initUrl+ "LeavesService/Delete";
  static final String leaveUpdate = initUrl+  "LeavesService/Update";
  static final String leaveGet =  initUrl+ "LeavesService/Get";
  static final String leaveGetAll =  initUrl+ "LeavesService/GetAll";
  static final String leaveTypeGetAll =  initUrl+ "LeavesTypeService/GetAll";


  static final String sendFcmToken = "/Notifications/UpdateUserTokenFirebase/Token"; //Notifications/UpdateUserTokenFirebase/Token
  static final String getNotifications = "/EmployeeApi/GetNotificationsEmpId";

  static final String employeeLocations = "/EmployeeApi/GetEmployeeLocations";
  static final String checkInOut = "/Login/PostCheckInOutMob/PostCheckInOutMob";










}
