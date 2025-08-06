class ConstantApiEndPoints {
  //-------------auth point---------------------------------------------------
  static const String signUpEndPoint = "user/auth/sendOtp";
  static const String loginEndPoint = "user/auth/verifyOtp";

  static const String getEmpProfile = "user/auth/profile";
  static const String updateEmpProfile = "user/auth/update";
  static const String logOutProfile = "user/auth/logOut";

  static const String emailVerifyOtp = "user/auth/sendEmailVerificationOtp";
  static const String verifyEmailOtp = "user/auth/verifyEmailOtp";

  //get apps ....................................................................
  static const String getAllApps = "user/apps/getAll";
  static const String getSingleApps = "user/apps/get";
}
