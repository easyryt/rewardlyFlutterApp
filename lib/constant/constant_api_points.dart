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
  static const String proofSubmit = "user/apps/submit/installProof";
  static const String getSubmittedApps = "user/apps/ins/rev/history";
  static const String getSubmittedSingleApps = "user/apps/ins/rev/history";
  static const String getAllAnalytics = "user/apps/analyticsUser";
  static const String getRewardAmount = "user/apps/rewardAmount";
}
