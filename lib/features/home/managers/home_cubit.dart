import 'package:meta/meta.dart';
import 'package:valetparking_user/features/home/models/get_all_garages_model.dart';
import 'package:valetparking_user/features/home/models/make_order_response_model.dart';
import 'package:valetparking_user/features/saved/models/get_all_user_saved_garages_model.dart';
import 'package:valetparking_user/utils/constants/api_constants.dart';
import 'package:valetparking_user/utils/constants/exports.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  DioHelper dioHelper = DioHelper();

  GetAllGaragesModel getAllGaragesModel = GetAllGaragesModel();
  MakeOrderResponseModel makeOrderResponseModel = MakeOrderResponseModel();

  /// Get All Garages Function
  Future<void> getAllGaragesFunction() async {
    emit(GetAllGaragesLoadingState());
    try {
      final response = await dioHelper.getData(
        endPoint: '${ApiConstants.getAllGaragesUrl}?active=true',
      );

      if (response.statusCode == 200) {
        getAllGaragesModel = GetAllGaragesModel.fromJson(response.data);
        emit(
            GetAllGaragesSuccessState(message: 'Get all Garages successfully'));
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        emit(GetAllGaragesErrorState(message: response.data['message'] ?? ''));
      }
    } catch (error) {
      logError(error.toString());
      emit(GetAllGaragesErrorState(message: error.toString()));
    }
  }

  /// Make new order Function
  // Future<void> makeNewOrderFunction({
  //   required String typeOfCar,
  //   required String garageId,
  //   required String date,
  //   required bool startNow,
  //   required double duration,
  //   required double totalPrice,
  //   required double paymentMethod,
  //   required double status,
  //   required bool isPaid,
  // }) async {
  //   emit(MakeNewOrderLoadingState());
  //   try {
  //     final response = await dioHelper.postData(
  //       endPoint: ApiConstants.makeOrderUrl,
  //       body: {
  //
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //       emit(MakeNewOrderSuccessState(message: response.data['message'] ?? ''));
  //     } else if (response.statusCode == 422 || response.statusCode == 404) {
  //       emit(MakeNewOrderErrorState(message: response.data['message'] ?? ''));
  //     }
  //   } catch (error) {
  //     logError(error.toString());
  //     emit(MakeNewOrderErrorState(message: error.toString()));
  //   }
  // }

  Future<void> makeNewOrderFunction({
    required String typeOfCar,
    required String garageId,
    required String date,
    required bool startNow,
    required double duration,
    required double totalPrice,
    required String paymentMethod,
    required String status,
    required bool isPaid,
    required String startTime,
    required String endTime,
  }) async {
    emit(MakeNewOrderLoadingState());
    try {
      final response = await dioHelper.postData(
        endPoint: '${ApiConstants.makeOrderUrl}${VCacheHelper.getString(key: CacheKeys.userId)}',
        body: {
          "typeOfCar": typeOfCar,
          "garage": garageId,
          "date": date,
          "startNow": startNow,
          "duration": duration,
          "totalPrice": totalPrice,
          "paymentMethod": paymentMethod,
          "status": status,
          "isPaid": isPaid,
          "timeRange": {
            "start": startTime,
            "end": endTime,
          },
        },
      );

      if (response.statusCode == 201) {
        makeOrderResponseModel = MakeOrderResponseModel.fromJson(response.data);
        emit(MakeNewOrderSuccessState(message: response.data['message'] ?? '', makeOrderResponseModel: makeOrderResponseModel));
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        emit(MakeNewOrderErrorState(message: response.data['message'] ?? ''));
      }
    } catch (error) {
      logError(error.toString());
      emit(MakeNewOrderErrorState(message: error.toString()));
    }
  }


  /// Add Garage To Saved Function
  Future<void> addGarageToSaved({required String garageId}) async {
    emit(AddGarageToSaveLoadingState());
    try {
      final response = await dioHelper.postData(
        endPoint: ApiConstants.addGarageToSavedUrl,
        body: {
          'garageId': garageId,
        },
      );

      if (response.statusCode == 200) {
        emit(AddGarageToSaveSuccessState(
            message: response.data['message'] ?? ''));
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        emit(
            AddGarageToSaveErrorState(message: response.data['message'] ?? ''));
      }
    } catch (error) {
      logError(error.toString());
      emit(AddGarageToSaveErrorState(message: error.toString()));
    }
  }

  /// Remove Garage From Saved Function
  Future<void> removeGarageFromSaved({required String garageId}) async {
    emit(RemoveGarageFromSaveLoadingState());
    try {
      final response = await dioHelper.deleteData(
        endPoint: ApiConstants.removeGarageFromSavedUrl,
        body: {
          'garageId': garageId,
        },
      );

      if (response.statusCode == 200) {
        emit(RemoveGarageFromSaveSuccessState(
            message: response.data['message'] ?? ''));
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        emit(RemoveGarageFromSaveErrorState(
            message: response.data['message'] ?? ''));
      }
    } catch (error) {
      logError(error.toString());
      emit(RemoveGarageFromSaveErrorState(message: error.toString()));
    }
  }
}
