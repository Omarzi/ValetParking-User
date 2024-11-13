
import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:valetparking_user/features/auth/models/user_data_model.dart';
import 'package:valetparking_user/features/profile/models/update_password_model.dart';
import 'package:valetparking_user/utils/constants/api_constants.dart';
import 'package:valetparking_user/utils/constants/exports.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);

  DioHelper dioHelper = DioHelper();

  UserData userData = UserData();
  UpdatePasswordModel updatePasswordModel = UpdatePasswordModel();

  int balance = 0;

  Future<void> getProfileDataFunction() async {
    emit(GetProfileDataLoadingState());
    try {
      final userId = VCacheHelper.getString(key: CacheKeys.userId);

      final response = await dioHelper.getData(
        endPoint: '${ApiConstants.profileDataUrl}$userId',
      );

      if (response.statusCode == 200) {
        userData = UserData.fromJson(response.data);
        // logSuccess(response.data.toString());
        // logSuccess(userData.toString());
        emit(GetProfileDataSuccessState());
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        emit(GetProfileDataErrorState(message: response.data['message'] ?? ''));
      }
    } catch (error) {
      logError(error.toString());
      logError(
          '${ApiConstants.baseUrl}${ApiConstants.profileDataUrl}${VCacheHelper.getString(key: CacheKeys.userId)}');
      emit(GetProfileDataErrorState(message: error.toString()));
    }
  }

  Future<void> updateProfileDataFunction({
    String? name,          // Optional
    String? email,         // Optional
    String? carName,       // Optional
    String? carNumber,     // Optional
  }) async {
    emit(UpdateProfileDataLoadingState());
    try {
      final userId = VCacheHelper.getString(key: CacheKeys.userId);
      final Map<String, dynamic> body = {};

      // Validate inputs before sending
      if (name != null && name.isNotEmpty) body['username'] = name;
      if (email != null && email.isNotEmpty) {
        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
          emit(UpdateProfileDataErrorState(message: 'Invalid email format'));
          return;
        }
        body['email'] = email;
      }
      if (carName != null && carName.isNotEmpty) body['carName'] = carName;
      if (carNumber != null && carNumber.isNotEmpty) body['carNumber'] = carNumber;

      log("Request Body: $body"); // Log the request body

      final response = await dioHelper.putData(
        endPoint: '${ApiConstants.updateProfileDataUrl}$userId',
        body: body,
      );

      if (response.statusCode == 200) {
        emit(UpdateProfileDataSuccessState());
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        log("Server response: ${response.data}"); // Log the error response
        emit(UpdateProfileDataErrorState(message: response.data['message'] ?? ''));
      }
    } catch (error) {
      log("Error: $error");
      logError(error.toString());
      emit(UpdateProfileDataErrorState(message: error.toString()));
    }
  }




  Future<void> updatePasswordFunction({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(UpdatePasswordLoadingState());
    try {
      final userId = VCacheHelper.getString(key: CacheKeys.userId);

      final response = await dioHelper.putData(endPoint: '${ApiConstants.changePasswordUrl}$userId', body: {
        "currentPassword": currentPassword,
        "newPassword": newPassword,
        "confirmPassword": confirmPassword,
      });

      if (response.statusCode == 200) {
        updatePasswordModel = UpdatePasswordModel.fromJson(response.data);
        logSuccess(response.data.toString());
        logSuccess(updatePasswordModel.toString());
        VCacheHelper.putString(key: CacheKeys.token, value: updatePasswordModel.token!);
        emit(UpdatePasswordSuccessState(message: 'Update password successfully'));
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        emit(UpdatePasswordErrorState(message: response.data['message'] ?? ''));
      }
    } catch (error) {
      logError(error.toString());
      logError('${ApiConstants.baseUrl}${ApiConstants.profileDataUrl}${VCacheHelper.getString(key: CacheKeys.userId)}');
      emit(UpdatePasswordErrorState(message: error.toString()));
    }
  }

  Future<void> getUserWalletFunction() async {
    emit(GetWalletLoadingState());
    try {
      final userId = VCacheHelper.getString(key: CacheKeys.userId);

      final response = await dioHelper.getData(
        endPoint: '${ApiConstants.walletUrl}$userId',
      );

      if (response.statusCode == 200) {
        // logSucces/**/s(response.data.toString());
        if(response.data['message'] == 'This user does not have wallet') {
          emit(GetWalletSuccessState(message: 'This user does not have wallet'));
        } else if(response.data['message'] == 'This user have wallet') {
          balance = response.data['data'];
          emit(GetWalletSuccessState(message: 'This user have wallet'));
        }
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        String message = response.data['message'];
        logError(message.toString());
        emit(GetWalletErrorState(message: response.data['message'] ?? ''));
      }
    } catch (error) {
      logError(error.toString());
      emit(GetWalletErrorState(message: error.toString()));
    }
  }

}
