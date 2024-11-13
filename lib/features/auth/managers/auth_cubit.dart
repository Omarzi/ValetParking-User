import 'package:meta/meta.dart';
import 'package:valetparking_user/features/auth/models/user_data_model.dart';
import 'package:valetparking_user/utils/constants/api_constants.dart';
import 'package:valetparking_user/utils/constants/exports.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);

  DioHelper dioHelper = DioHelper();

  UserDataModel userDataModel = UserDataModel();

  /// Login Function
  Future<void> loginFunction({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    try {
      final response =
          await dioHelper.postData(endPoint: ApiConstants.loginUrl, body: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        emit(LoginSuccessState(message: 'Reset code sent to email. Please verify the code.'));
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        logError(response.data['message'].toString());
        emit(LoginErrorState(message: response.data['message'] ?? ''));
      } else {
        logError(response.data['message'].toString());
        emit(LoginErrorState(message: 'Error in login'));
      }
    } catch (error) {
      logError(error.toString());
      emit(LoginErrorState(message: error.toString()));
    }
  }

  /// Verify Reset Code For Login Function
  Future<void> verifyResetCodeForLoginFunction({
    required String resetCode,
  }) async {
    emit(VerifyResetCodeOfLoginLoadingState());
    try {
      final response =
      await dioHelper.postData(endPoint: ApiConstants.verifyResetCodeOfLoginUrl, body: {
        'resetCode': resetCode,
      });

      if (response.statusCode == 200) {
        userDataModel = UserDataModel.fromJson(response.data);
        VCacheHelper.putString(key: CacheKeys.userId, value: userDataModel.userData!.userId.toString());
        VCacheHelper.putString(key: CacheKeys.token, value: userDataModel.token.toString());
        VCacheHelper.putString(key: CacheKeys.role, value: userDataModel.userData!.role.toString());
        VCacheHelper.putString(key: CacheKeys.userName, value: userDataModel.userData!.username.toString());
        VCacheHelper.putString(key: CacheKeys.email, value: userDataModel.userData!.email.toString());
        logSuccess(userDataModel.userData!.email.toString());
        emit(VerifyResetCodeOfLoginSuccessState(message: 'Reset code sent to email. Please verify the code.'));
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        logError(response.data['message'].toString());
        emit(VerifyResetCodeOfLoginErrorState(message: response.data['message'] ?? ''));
      } else {
        logError(response.data['message'].toString());
        emit(VerifyResetCodeOfLoginErrorState(message: 'Error in verify'));
      }
    } catch (error) {
      emit(VerifyResetCodeOfLoginErrorState(message: error.toString()));
    }
  }

  /// Signup Function
  // Future<void> signUpFunction({
  //   required String username,
  //   required String email,
  //   required String password,
  //   required String phone,
  //   required String profileImage,
  //   required String carName,
  //   required String carNumber,
  //   required String carImage,
  // }) async {
  //   emit(SignupLoadingState());
  //   try {
  //     FormData formData = FormData.fromMap({
  //       'username': username,
  //       'email': email,
  //       'password': password,
  //       'phone': phone,
  //       // 'profileImage': await MultipartFile.fromFile(profileImage),
  //       'carName': carName,
  //       'carNumber': carNumber,
  //       // 'carImage': await MultipartFile.fromFile(carImage),
  //     });
  //
  //     final response = await Dio().post('${ApiConstants.baseUrl}${ApiConstants.signupUrl}', data: formData);
  //
  //     if (response.statusCode == 200) {
  //       emit(SignupSuccessState(message: 'Sign up successful!'));
  //     } else if (response.statusCode == 422 || response.statusCode == 404) {
  //       logError(response.data['message'].toString());
  //       emit(SignupErrorState(message: response.data['message'] ?? ''));
  //     } else {
  //       logError(response.data['message'].toString());
  //       emit(SignupErrorState(message: 'Error during sign up'));
  //     }
  //   } catch (error) {
  //     logError(error.toString());
  //     emit(SignupErrorState(message: error.toString()));
  //   }
  // }

  Future<void> signupFunction({
    required String username,
    required String email,
    required String password,
    required String phone,
    required String profileImage,
    required String carName,
    required String carNumber,
    required String carImage,
  }) async {
    emit(SignupLoadingState());
    try {
      /// Prepare FormData
      FormData formData = FormData.fromMap({
        'username': username,
        'email': email,
        'password': password,
        'phone': phone,
        // 'profileImage': await MultipartFile.fromFile(profileImage),
        // 'profileImage': await MultipartFile.fromFile(profileImage.path, filename: profileImage.path.split('/').last),
        'carName': carName,
        'carNumber': carNumber,
        // 'carImage': await MultipartFile.fromFile(carImage),
      });

      final response = await dioHelper.postFormData(
        endPoint: ApiConstants.signupUrl,
        formData: formData,
      );

      if (response.statusCode == 200) {
        userDataModel = UserDataModel.fromJson(response.data);
        VCacheHelper.putString(key: CacheKeys.userId, value: userDataModel.userData!.userId.toString());
        VCacheHelper.putString(key: CacheKeys.token, value: userDataModel.token.toString());
        VCacheHelper.putString(key: CacheKeys.role, value: userDataModel.userData!.role.toString());
        VCacheHelper.putString(key: CacheKeys.userName, value: userDataModel.userData!.username.toString());
        VCacheHelper.putString(key: CacheKeys.email, value: userDataModel.userData!.email.toString());
        // logSuccess(userDataModel.userData!.email.toString());
        emit(SignupSuccessState(message: 'Signup successfully'));
      } else if (response.statusCode == 422 || response.statusCode == 404) {

        logError(response.data['message'].toString());
        emit(SignupErrorState(message: response.data['message'] ?? ''));
      } else {
        logError(response.data['message'].toString());
        emit(SignupErrorState(message: 'Error in signup'));
      }
    } catch (error) {
      logError('${ApiConstants.baseUrl}${ApiConstants.signupUrl}');
      logError(error.toString());
      emit(SignupErrorState(message: error.toString()));
    }
  }

  /// Forget Password Function
  Future<void> forgetPasswordFunction({
    required String email,
  }) async {
    emit(ForgetPasswordLoadingState());
    try {
      final response = await dioHelper
          .postData(endPoint: ApiConstants.forgetPasswordUrl, body: {
        'email': email,
      });

      if (response.statusCode == 200) {
        emit(ForgetPasswordSuccessState(message: 'Reset code send to email'));
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        logError(response.data['message'].toString());
        emit(ForgetPasswordErrorState(message: response.data['message'] ?? ''));
      } else {
        logError(response.data['message'].toString());
        emit(ForgetPasswordErrorState(message: 'Error in forget password'));
      }
    } catch (error) {
      emit(ForgetPasswordErrorState(message: error.toString()));
    }
  }

  /// Verify Reset Code Function
  Future<void> verifyResetCodeFunction({
    required String resetCode,
  }) async {
    emit(VerifyResetPasswordLoadingState());
    try {
      final response = await dioHelper
          .postData(endPoint: ApiConstants.verifyResetCodeOfLoginUrl, body: {
        'resetCode': resetCode,
      });

      if (response.statusCode == 200) {
        userDataModel = UserDataModel.fromJson(response.data);
        VCacheHelper.putString(key: CacheKeys.userId, value: userDataModel.userData!.userId.toString());
        VCacheHelper.putString(key: CacheKeys.token, value: userDataModel.token.toString());
        VCacheHelper.putString(key: CacheKeys.role, value: userDataModel.userData!.role.toString());
        VCacheHelper.putString(key: CacheKeys.userName, value: userDataModel.userData!.username.toString());
        VCacheHelper.putString(key: CacheKeys.email, value: userDataModel.userData!.email.toString());
        logSuccess(userDataModel.userData!.email.toString());
        emit(VerifyResetPasswordSuccessState(
            message: 'Reset code send to email'));
      }
      else if (response.statusCode == 422 || response.statusCode == 404) {
        logError(response.data['message'].toString());
        emit(VerifyResetPasswordErrorState(
            message: response.data['message'] ?? ''));
      }
      else {
        logError(response.data['message'].toString());
        emit(
            VerifyResetPasswordErrorState(message: 'Error in forget password'));
      }
    } catch (error) {
      emit(VerifyResetPasswordErrorState(message: error.toString()));
    }
  }

  /// Create a new password Function
  Future<void> createNewPasswordFunction({
    required String email,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(CreateNewPasswordLoadingState());
    try {
      final response = await dioHelper.putData(endPoint: ApiConstants.createNewPasswordUrl, body: {
        "email": email,
        "newPassword": newPassword,
        "confirmPassword": confirmPassword,
      });

      if (response.statusCode == 200) {
        emit(CreateNewPasswordSuccessState(message: 'Reset code send to email'));
      }
      else if (response.statusCode == 422 || response.statusCode == 404) {
        logError(response.data['message'].toString());
        emit(CreateNewPasswordErrorState(message: response.data['message'] ?? ''));
      }
      else {
        logError(response.data['message'].toString());
        emit(CreateNewPasswordErrorState(message: 'Error in forget password'));
      }
    } catch (error) {
      emit(CreateNewPasswordErrorState(message: error.toString()));
    }
  }
}
