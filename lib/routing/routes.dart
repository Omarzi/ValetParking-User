import 'package:valetparking_user/features/auth/models/user_data_model.dart';
import 'package:valetparking_user/features/auth/presentation/screens/fill_your_profile_screen.dart';
import 'package:valetparking_user/features/auth/presentation/screens/login_screen.dart';
import 'package:valetparking_user/features/auth/presentation/screens/otp_in_create_and_login_screen.dart';
import 'package:valetparking_user/features/auth/presentation/screens/password_configuration/create_new_password_screen.dart';
import 'package:valetparking_user/features/auth/presentation/screens/password_configuration/enter_email_screen.dart';
import 'package:valetparking_user/features/auth/presentation/screens/password_configuration/forget_password_screen.dart';
import 'package:valetparking_user/features/booking/presentation/screens/parking_timer_screen.dart';
import 'package:valetparking_user/features/booking/presentation/screens/view_ticket_screen.dart';
import 'package:valetparking_user/features/home/models/get_all_garages_model.dart';
import 'package:valetparking_user/features/home/models/make_order_response_model.dart';
import 'package:valetparking_user/features/home/presentation/screens/choice_date_and_time_screen.dart';
import 'package:valetparking_user/features/home/presentation/screens/choice_passenger_screen.dart';
import 'package:valetparking_user/features/home/presentation/screens/parking_tiket_screen.dart';
import 'package:valetparking_user/features/home/presentation/screens/place_details_screens.dart';
import 'package:valetparking_user/features/home/presentation/screens/review_sammary_screen.dart';
import 'package:valetparking_user/features/onboarding/screens/onboarding_screen.dart';
import 'package:valetparking_user/features/onboarding/screens/welcome_screen.dart';
import 'package:valetparking_user/features/profile/presentation/screens/change_password/change_password_screen.dart';
import 'package:valetparking_user/features/profile/presentation/screens/edit_profile/edit_profile_screen.dart';
import 'package:valetparking_user/features/profile/presentation/screens/privacy_policy/privacy_policy_screen.dart';
import 'package:valetparking_user/features/profile/presentation/screens/wallet/wallet_screen.dart';
import 'package:valetparking_user/features/splash/screens/splash_screen.dart';
import 'package:valetparking_user/navigation_menu.dart';
import 'package:valetparking_user/utils/constants/exports.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case VRoutesName.splashRoute:
        return PageTransition(
          child: const SplashScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
          duration: const Duration(milliseconds: 500),
          reverseDuration: const Duration(milliseconds: 500),
        );
      case VRoutesName.welcomeRoute:
        return PageTransition(
          child: const WelcomeScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
          duration: const Duration(milliseconds: 500),
          reverseDuration: const Duration(milliseconds: 500),
        );
      case VRoutesName.onBoardingRoute:
        return PageTransition(
          child: const OnBoardingScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
          duration: const Duration(milliseconds: 500),
          reverseDuration: const Duration(milliseconds: 500),
        );
      // case VRoutesName.createAccountRoute:
      //   return PageTransition(
      //     child: const CreateAccountScreen(),
      //     type: PageTransitionType.rightToLeft,
      //     settings: settings,
      //     duration: const Duration(milliseconds: 500),
      //     reverseDuration: const Duration(milliseconds: 500),
      //   );
      case VRoutesName.fillYourRoute:
        // String phoneNumber = settings.arguments as String;

        return PageTransition(
          child: const FillYourProfileScreen(),
          // child: FillYourProfileScreen(phoneNumber: phoneNumber),
          type: PageTransitionType.rightToLeft,
          settings: settings,
          duration: const Duration(milliseconds: 500),
          reverseDuration: const Duration(milliseconds: 500),
        );
      case VRoutesName.loginAccountRoute:
        return PageTransition(
          child: const LoginScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
          duration: const Duration(milliseconds: 500),
          reverseDuration: const Duration(milliseconds: 500),
        );
      case VRoutesName.forgetPasswordRoute:
        return PageTransition(
          child: const ForgetPasswordScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
          duration: const Duration(milliseconds: 500),
          reverseDuration: const Duration(milliseconds: 500),
        );
      case VRoutesName.enterEmailRoute:
        return PageTransition(
          child: const EnterEmailScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
          duration: const Duration(milliseconds: 500),
          reverseDuration: const Duration(milliseconds: 500),
        );
      case VRoutesName.enterNewPasswordRoute:
        Map data = settings.arguments as Map;

        return PageTransition(
          child: CreateNewPasswordScreen(data: data),
          type: PageTransitionType.rightToLeft,
          settings: settings,
          duration: const Duration(milliseconds: 500),
          reverseDuration: const Duration(milliseconds: 500),
        );
      case VRoutesName.otpRoute:
        // String emailAddress = settings.arguments as String;
      Map data = settings.arguments as Map;

        return PageTransition(
          child: OtpInCreateAndLoginScreen(data: data),
          type: PageTransitionType.rightToLeft,
          settings: settings,
          duration: const Duration(milliseconds: 500),
          reverseDuration: const Duration(milliseconds: 500),
        );
      case VRoutesName.navigationMenuRoute:
        int index = settings.arguments as int;

        return PageTransition(
          child: NavigationMenu(index: index),
          type: PageTransitionType.rightToLeft,
          settings: settings,
          duration: const Duration(milliseconds: 500),
          reverseDuration: const Duration(milliseconds: 500),
        );
      case VRoutesName.placeDetailsRoute:
        GarageDetails garagesList = settings.arguments as GarageDetails;

        return PageTransition(
          child: PlaceDetailsScreens(garagesItem: garagesList),
          type: PageTransitionType.rightToLeft,
          settings: settings,
          duration: const Duration(milliseconds: 500),
          reverseDuration: const Duration(milliseconds: 500),
        );
      case VRoutesName.choiceYourPassenger:
        Map data = settings.arguments as Map;

        return PageTransition(
          child: ChoicePassengersScreen(data: data),
          type: PageTransitionType.rightToLeft,
          settings: settings,
          duration: const Duration(milliseconds: 500),
          reverseDuration: const Duration(milliseconds: 500),
        );
      case VRoutesName.choiceDataAndTimeRoute:
        Map data = settings.arguments as Map;

        return PageTransition(
          child: ChoiceDateAndTimeScreen(data: data),
          type: PageTransitionType.rightToLeft,
          settings: settings,
          duration: const Duration(milliseconds: 500),
          reverseDuration: const Duration(milliseconds: 500),
        );
      case VRoutesName.reviewSummaryRoute:
        // String paymentMethod = settings.arguments as String;
        Map data = settings.arguments as Map;

        return PageTransition(
          child: ReviewSummaryScreen(data: data),
          type: PageTransitionType.rightToLeft,
          settings: settings,
          duration: const Duration(milliseconds: 500),
          reverseDuration: const Duration(milliseconds: 500),
        );
      case VRoutesName.parkingTicketRoute:
        MakeOrderResponseModel makeOrderResponseModel = settings.arguments as MakeOrderResponseModel;

        return PageTransition(
          child: ParkingTicketScreen(makeOrderResponseModel: makeOrderResponseModel),
          type: PageTransitionType.rightToLeft,
          settings: settings,
          duration: const Duration(milliseconds: 500),
          reverseDuration: const Duration(milliseconds: 500),
        );
      case VRoutesName.parkingTimerRoute:
        Map data = settings.arguments as Map;

        return PageTransition(
          child: ParkingTimerScreen(data: data),
          type: PageTransitionType.rightToLeft,
          settings: settings,
          duration: const Duration(milliseconds: 500),
          reverseDuration: const Duration(milliseconds: 500),
        );
      case VRoutesName.walletRoute:
        return PageTransition(
          child: const WalletScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
          duration: const Duration(milliseconds: 500),
          reverseDuration: const Duration(milliseconds: 500),
        );
      case VRoutesName.viewTicket:
        final String orderId = settings.arguments as String;

        return PageTransition(
          child: ViewTicketScreen(orderId: orderId),
          type: PageTransitionType.rightToLeft,
          settings: settings,
          duration: const Duration(milliseconds: 500),
          reverseDuration: const Duration(milliseconds: 500),
        );
      case VRoutesName.editProfileRoute:
        final UserData userData = settings.arguments as UserData;

        return PageTransition(
          child: EditProfileScreen(userData: userData),
          type: PageTransitionType.rightToLeft,
          settings: settings,
          duration: const Duration(milliseconds: 500),
          reverseDuration: const Duration(milliseconds: 500),
        );
      case VRoutesName.changePasswordRoute:
        return PageTransition(
          child: const ChangePasswordScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
          duration: const Duration(milliseconds: 500),
          reverseDuration: const Duration(milliseconds: 500),
        );
      case VRoutesName.privacyPolicyRoute:
        return PageTransition(
          child: const PrivacyPolicyScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
          duration: const Duration(milliseconds: 500),
          reverseDuration: const Duration(milliseconds: 500),
        );
      default:
        return unDefinedRoute();
    }
  }

  /// Un Defined Route
  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(
            '',
          ),
        ),
        body: const Center(
          child: Text(
            '',
          ),
        ),
      ),
    );
  }
}