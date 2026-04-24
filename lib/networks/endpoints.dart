// ignore_for_file: constant_identifier_names, unnecessary_string_interpolations

const String url = "https://ibraheemaltamim.thesyndicates.team";
const String imageUrl = "${url}";

final class NetworkConstants {
  NetworkConstants._();
  static const ACCEPT = "Accept";
  static const APP_KEY = "App-Key";
  static const ACCEPT_LANGUAGE = "Accept-Language";
  static const ACCEPT_LANGUAGE_VALUE = "pt";
  static const APP_KEY_VALUE = String.fromEnvironment("APP_KEY_VALUE");
  static const ACCEPT_TYPE = "application/json";
  static const AUTHORIZATION = "Authorization";
  static const CONTENT_TYPE = "content-Type";
}

final class Endpoints {
  Endpoints._();

  // -------------------Register start-------------------
  static String register() => "/api/register";
  // -------------------Register end-------------------

  // -------------------Register Verify email start-------------------
  static String verifyEmail() => "/api/verify-email";
  // -------------------Register Verify email end-------------------

  // -------------------Resend OTP start-------------------
  static String resendOtp() => "/api/resend-otp";
  // -------------------Resend OTP end-------------------

  // -------------------Login start-------------------
  static String login() => "/api/login";
  // -------------------Login end-------------------


  // -------------------Logout start-------------------
  static String logout() => "/api/logout";
  // -------------------Logout end-------------------

  // -------------------Forget Password start-------------------
  static String forgetPassword() => "/api/forget-password";
  // -------------------Forget Password end-------------------


  // -------------------Reset Password start-------------------
  static String resetPassword() => "/api/reset-password";
  // -------------------Reset Password end-------------------

  // -------------------Verify Otp start-------------------
  static String verifyForgetPasswordOtp() => "/api/verify-otp";
  // -------------------Verify Otp end-------------------
  
  // -------------------Update Profile start-------------------
  static String updateProfile() => "/api/update-profile";
  // -------------------Update Profile end-------------------
  

  // -------------------Get Profile start-------------------
  static String getProfile() => "/api/me";
  // -------------------Get Profile end-------------------

  // -------------------Delete Account start-------------------
  static String deleteAccount() => "/api/delete-profile";
  // -------------------Delete Account end-------------------


  // -------------------Update Password start-------------------
  static String updatePassword() => "/api/update-password";
  // -------------------Update Password end-------------------


  // -------------------Privacy Policy start-------------------
  static String privacyPolicy() => "/api/dynamic-pages/single/privacy-policy";
  // -------------------Privacy Policy end-------------------

  // -------------------Terms And Conditions start-------------------
  static String termsAndConditions() => "/api/dynamic-pages/single/terms-and-conditions";
  // -------------------Terms And Conditions end-------------------

  // -------------------Services start-------------------
  static String services() => "/api/services";
  // -------------------Services end-------------------

  // -------------------Favourites start-------------------
  static String favourites() => "/api/researcher/favourites";
  // -------------------Favourites end-------------------

  // -------------------Delete Favourites start-------------------
  static String deleteFavourites(String favouriteId) => "/api/researcher/favourites/$favouriteId";
  // -------------------Delete Favourites end-------------------

  // -------------------Favourites Details start-------------------
  static String favouritesDetails(String favouriteId) => "/api/researcher/favourites/$favouriteId";
  // -------------------Favourites Details end-------------------

  // -------------------Opportunities start-------------------
  static String opportunitiesList() => "/api/opportunities";
  // -------------------Opportunities end-------------------

  // -------------------Add Favourites start-------------------
  static String addFavourites() => "/api/researcher/favourites";
  // -------------------Add Favourites end-------------------


  // -------------------Opportunity Details start-------------------
  static String opportunityDetails(String opportunityId) => "/api/opportunities/$opportunityId";
  // -------------------Opportunity Details end-------------------

  // ------------------- Mentors details start-------------------
  static String mentorsDetails(String mentorId) => "/api/opportunities/mentors/$mentorId";
  // ------------------- Mentors details end-------------------

  // ------------------- Filter List start-------------------
  static String filterList() => "/api/opportunities/fillter-list";
  // ------------------- Filter List end-------------------

}
