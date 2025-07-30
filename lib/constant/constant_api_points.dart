class ConstantApiEndPoints {
  //-------------auth point---------------------------------------------------
  static const String signUpEndPoint = "user/auth/sendOtp";
  static const String loginEndPoint = "user/auth/verifyOtp";

  static const String getEmpProfile = "user/auth/profile";
  static const String updateEmpProfile = "user/auth/update";
  static const String logOutProfile = "user/auth/logOut";

  static const String emailVerifyOtp = "user/auth/sendEmailVerificationOtp";
  static const String verifyEmailOtp = "user/auth/verifyEmailOtp";

  static const String createCompanies = "admin/company/create";
  static const String getCompanies = "admin/company/getAll";
  static const String getSingleCompanies = "admin/company/get";
  static const String updateCompanies = "admin/company/update";

  static const String createTeams = "admin/company/team/create";
  static const String getTeams = "admin/company/team/getAll";
  static const String updateTeams = "admin/company/team/update";

  static const String getAllLeads = "admin/company/team/leads/getAll";
  static const String getSingleLeads = "admin/company/team/leads/getSingleLead";
  static const String createLeads = "admin/company/team/leads/createSingle";
  static const String updateLeads = "admin/company/team/leads/updateSingle";
  static const String assignLead = "admin/company/team/leads/assignLead";
  static const String bulkUploadLeads = "admin/company/team/leads/createXls";

  static const String createEmployees = "admin/employee/create";
  static const String getEmployees = "admin/employee/getAll";
  static const String getSingleEmployees = "admin/employee/getSingle";
  static const String updateEmployees = "admin/employee/update";

  static const String createEmployeeAccess = "admin/employee/access/create";
  static const String getEmployeeAccess = "admin/employee/access/getAll";
  static const String updateEmployeeAccess = "admin/employee/access/update";
}
