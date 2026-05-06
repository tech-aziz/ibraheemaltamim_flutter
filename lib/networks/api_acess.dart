import 'package:ibraheemaltamim_flutter/features/auth/login/data/rx_login/rx.dart';
import 'package:ibraheemaltamim_flutter/features/auth/login/model/login_model.dart';
import 'package:ibraheemaltamim_flutter/features/auth/forget_password/data/rx_forget_password/rx.dart';
import 'package:ibraheemaltamim_flutter/features/auth/forget_password/model/forget_password_model.dart';
import 'package:ibraheemaltamim_flutter/features/auth/logout/rx.dart';
import 'package:ibraheemaltamim_flutter/features/auth/otp/data/rx_forget_password_verify_otp/rx.dart';
import 'package:ibraheemaltamim_flutter/features/auth/otp/model/forget_password_otp_model.dart';
import 'package:ibraheemaltamim_flutter/features/auth/otp/model/register_resend_otp_model.dart';
import 'package:ibraheemaltamim_flutter/features/auth/register/data/rx_register/rx.dart';
import 'package:ibraheemaltamim_flutter/features/auth/register/model/register_model.dart';
import 'package:ibraheemaltamim_flutter/features/auth/otp/data/rx_register_verify_otp/rx.dart';
import 'package:ibraheemaltamim_flutter/features/auth/otp/model/verify_register_otp_model.dart';
import 'package:ibraheemaltamim_flutter/features/auth/otp/data/rx_register_resend_otp/rx.dart';
import 'package:ibraheemaltamim_flutter/features/auth/set_new_password/data/rx_reset_password/rx.dart';
import 'package:ibraheemaltamim_flutter/features/auth/set_new_password/model/set_new_password_model.dart';
import 'package:ibraheemaltamim_flutter/features/profile/data/rx_delete_account/rx_delete_account/rx.dart';
import 'package:ibraheemaltamim_flutter/features/profile/data/rx_profile_update/rx.dart';
import 'package:ibraheemaltamim_flutter/features/home/data/rx_whats_app_call/rx.dart';
import 'package:ibraheemaltamim_flutter/features/home/model/whats_app_call_model.dart';
import 'package:ibraheemaltamim_flutter/features/profile/data/rx_user_info/rx.dart';
import 'package:ibraheemaltamim_flutter/features/profile/model/user_info_model.dart';
import 'package:ibraheemaltamim_flutter/features/profile/data/rx_privacy_policy/rx.dart';
import 'package:ibraheemaltamim_flutter/features/profile/data/rx_terms/rx.dart';
import 'package:ibraheemaltamim_flutter/features/profile/data/rx_update_password/rx.dart';
import 'package:ibraheemaltamim_flutter/features/profile/model/mentor_details_model.dart';
import 'package:ibraheemaltamim_flutter/features/profile/model/privacy_policy_model.dart';
import 'package:ibraheemaltamim_flutter/features/profile/data/rx_mentor_details/rx.dart';
import 'package:ibraheemaltamim_flutter/features/home/data/rx_filter_list/rx.dart';
import 'package:ibraheemaltamim_flutter/features/home/model/filter_list_model.dart';
import 'package:ibraheemaltamim_flutter/features/home/data/rx_get_notification/rx.dart';
import 'package:ibraheemaltamim_flutter/features/home/model/get_all_notification_list_model.dart';
import 'package:ibraheemaltamim_flutter/features/home/data/rx_delete_single_notification/rx.dart';
import 'package:ibraheemaltamim_flutter/features/home/model/delete_single_notification_model.dart';
import 'package:ibraheemaltamim_flutter/features/home/data/rx_mark_as_read/rx.dart';
import 'package:ibraheemaltamim_flutter/features/home/model/mark_as_read_model.dart';
import 'package:ibraheemaltamim_flutter/features/home/data/rx_delete_all_notifications/rx.dart';
import 'package:ibraheemaltamim_flutter/features/message/data/rx_chat_list/rx.dart';
import 'package:ibraheemaltamim_flutter/features/message/model/chat_list_model.dart';
import 'package:ibraheemaltamim_flutter/features/message/data/rx_show_chat/rx.dart';
import 'package:ibraheemaltamim_flutter/features/message/model/chat_show_model.dart';
import 'package:ibraheemaltamim_flutter/features/message/data/send_message/rx.dart';
import 'package:ibraheemaltamim_flutter/features/message/model/send_message_model.dart';
import 'package:rxdart/subjects.dart';

//_________________Delete Account Api Access ______________________//
DeleteAccountRx deleteAccountRxObj =
    DeleteAccountRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

//_________________Update Password Api Access ______________________//
UpdatePasswordRx updatePasswordRxObj =
    UpdatePasswordRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

//_________________Privacy Policy Api Access ______________________//
PrivacyPolicyRx privacyPolicyRxObj = PrivacyPolicyRx(
  empty: PrivacyPolicyModel(),
  dataFetcher: BehaviorSubject<PrivacyPolicyModel>(),
);

//_________________Terms And Conditions Api Access ______________________//
TermsAndConditionsRx termsAndConditionsRxObj = TermsAndConditionsRx(
  empty: PrivacyPolicyModel(),
  dataFetcher: BehaviorSubject<PrivacyPolicyModel>(),
);

// ------------- Update Profile Api Access -----------------//
UpdateProfileRx updateProfileRxObj = UpdateProfileRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

// ------------- Register Api Access -----------------//
RegisterRx registerRxObj = RegisterRx(
  empty: RegisterModel(),
  dataFetcher: BehaviorSubject<RegisterModel>(),
);

// ------------- Verify Register Otp Api Access -----------------//
VerifyRegisterOtpRx verifyRegisterOtpRxObj = VerifyRegisterOtpRx(
  empty: VerifyRegisterOtpModel(),
  dataFetcher: BehaviorSubject<VerifyRegisterOtpModel>(),
);

// ------------- Resend Register Otp Api Access -----------------//
ResendRegisterOtpRx resendRegisterOtpRxObj = ResendRegisterOtpRx(
  empty: ResendRegisterOtpModel(),
  dataFetcher: BehaviorSubject<ResendRegisterOtpModel>(),
);

// ------------- Login Api Access -----------------//
LoginRx loginRxObj = LoginRx(
  empty: LoginModel(),
  dataFetcher: BehaviorSubject<LoginModel>(),
);

//___________________ Forget Password Api Access ______________________//
ForgetPasswordRx forgetPasswordRxObj = ForgetPasswordRx(
  empty: ForgetPasswordModel(),
  dataFetcher: BehaviorSubject<ForgetPasswordModel>(),
);

//___________________ User Info Api Access ______________________//
UserInfoRx userInfoRxObj = UserInfoRx(
  empty: UserInfoModel(),
  dataFetcher: BehaviorSubject<UserInfoModel>(),
);

//___________________ Mentor Details Api Access ______________________//
MentorDetailsRx mentorDetailsRxObj = MentorDetailsRx(
  empty: MentorDetailsModel(),
  dataFetcher: BehaviorSubject<MentorDetailsModel>(),
);

//___________________ Filter List Api Access ______________________//
FilterListRx filterListRxObj = FilterListRx(
  empty: FilterListModel(),
  dataFetcher: BehaviorSubject<FilterListModel>.seeded(FilterListModel()),
);

FilterListRx studentDesignListRxObj = FilterListRx(
  empty: FilterListModel(),
  dataFetcher: BehaviorSubject<FilterListModel>.seeded(FilterListModel()),
);

FilterListRx contributionListRxObj = FilterListRx(
  empty: FilterListModel(),
  dataFetcher: BehaviorSubject<FilterListModel>.seeded(FilterListModel()),
);

FilterListRx universityHospitalListRxObj = FilterListRx(
  empty: FilterListModel(),
  dataFetcher: BehaviorSubject<FilterListModel>.seeded(FilterListModel()),
);

FilterListRx placeListRxObj = FilterListRx(
  empty: FilterListModel(),
  dataFetcher: BehaviorSubject<FilterListModel>.seeded(FilterListModel()),
);

FilterListRx experienceLevelListRxObj = FilterListRx(
  empty: FilterListModel(),
  dataFetcher: BehaviorSubject<FilterListModel>.seeded(FilterListModel()),
);

//___________________ Notification List Api Access ______________________//
GetAllNotificationListRx getAllNotificationListRxObj = GetAllNotificationListRx(
  empty: GetAllNotificationListModel(),
  dataFetcher: BehaviorSubject<GetAllNotificationListModel>(),
);

DeleteSingleNotificationRx deleteSingleNotificationRxObj = DeleteSingleNotificationRx(
  empty: DeleteSingleNotificationModel(),
  dataFetcher: BehaviorSubject<DeleteSingleNotificationModel>(),
);

MarkAsReadRx markAsReadRxObj = MarkAsReadRx(
  empty: MarkAsReadModel(),
  dataFetcher: BehaviorSubject<MarkAsReadModel>(),
);

DeleteAllNotificationsRx deleteAllNotificationsRxObj = DeleteAllNotificationsRx(
  empty: DeleteSingleNotificationModel(),
  dataFetcher: BehaviorSubject<DeleteSingleNotificationModel>(),
);

//___________________ Chat List Api Access ______________________//
ChatListRx getChatListRxObj = ChatListRx(
  empty: ChatListModel(),
  dataFetcher: BehaviorSubject<ChatListModel>(),
);

ChatListRx createGroupRxObj = ChatListRx(
  empty: ChatListModel(),
  dataFetcher: BehaviorSubject<ChatListModel>(),
);

//___________________ Chat Show Api Access ______________________//
ChatShowRx chatShowRxObj = ChatShowRx(
  empty: ChatShowModel(),
  dataFetcher: BehaviorSubject<ChatShowModel>(),
);

//___________________ Send Message Api Access ______________________//
SendMessageRx sendMessageRxObj = SendMessageRx(
  empty: SendMessageModel(),
  dataFetcher: BehaviorSubject<SendMessageModel>(),
);

//___________________ WhatsApp Call Api Access ______________________//
WhatsAppCallRx whatsAppCallRxObj = WhatsAppCallRx(
  empty: WhatsAppCallModel(),
  dataFetcher: BehaviorSubject<WhatsAppCallModel>(),
);

// ------------- Reset Password Api Access -----------------//
ResetPasswordRx resetPasswordRxObj = ResetPasswordRx(
  empty: SetNewPasswordModel(),
  dataFetcher: BehaviorSubject<SetNewPasswordModel>(),
);


VerifyForgetPasswordOtpRx verifyForgetPasswordOtpRxObj = VerifyForgetPasswordOtpRx(
  empty: ForgetPasswordOtpVerifyModel(),
  dataFetcher: BehaviorSubject<ForgetPasswordOtpVerifyModel>(),
);


//_________________LogOut Api Access ______________________//
LogOutRx logOutRx = LogOutRx(empty: {}, dataFetcher: BehaviorSubject<Map>());


