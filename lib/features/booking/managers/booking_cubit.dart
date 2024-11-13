import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:valetparking_user/features/booking/models/get_all_orders_model.dart';
import 'package:valetparking_user/features/booking/models/get_all_orders_model.dart';
import 'package:valetparking_user/features/booking/models/get_specific_order_model.dart';
import 'package:valetparking_user/utils/constants/api_constants.dart';
import 'package:valetparking_user/utils/constants/exports.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingInitialState());

  static BookingCubit get(context) => BlocProvider.of(context);

  DioHelper dioHelper = DioHelper();

  GetAllOrdersModel getAllOrdersModel = GetAllOrdersModel();
  GetSpecificOrderModel getSpecificOrderModel = GetSpecificOrderModel();

  /// Get All Orders Function
  Future<void> getAllOrdersFunction({required String status}) async {
    emit(GetAllOrdersLoadingState());
    try {
      final response = await dioHelper.getData(
        endPoint: '${ApiConstants.getAllOrdersUrl}?status=$status',
      );

      if (response.statusCode == 200) {
        getAllOrdersModel = GetAllOrdersModel.fromJson(response.data);
        // logSuccess('${getAllOrdersModel.orderDetails!.length} ljksfdolajk');
        // logSuccess('${response.data}');
        emit(GetAllOrdersSuccessState(message: 'Get all Orders successfully'));
      }
      else if (response.statusCode == 422 || response.statusCode == 404) {
        emit(GetAllOrdersErrorState(message: response.data['message'] ?? ''));
      }

    } catch (error) {
      logError(error.toString());
      emit(GetAllOrdersErrorState(message: error.toString()));
    }
  }

  Future<void> getSpecificFunction({required String status, required String orderId}) async {
    emit(GetSpecificOrderLoadingState());
    try {
      final response = await dioHelper.getData(
        endPoint: '${ApiConstants.getSpecificOrderUrl}$orderId',
      );

      // logSuccess(response.data.toString());

      if (response.statusCode == 200) {
        getSpecificOrderModel = GetSpecificOrderModel.fromJson(response.data);
        emit(GetSpecificOrderSuccessState(message: 'Get specific Order successfully'));
      }
      else if (response.statusCode == 422 || response.statusCode == 404) {
        emit(GetSpecificOrderErrorState(message: response.data['message'] ?? ''));
      }

    } catch (error) {
      logError(error.toString());
      emit(GetSpecificOrderErrorState(message: error.toString()));
    }
  }
}
