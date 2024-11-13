import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:valetparking_user/features/saved/models/get_all_user_saved_garages_model.dart';
import 'package:valetparking_user/utils/constants/api_constants.dart';
import 'package:valetparking_user/utils/constants/exports.dart';

part 'saved_state.dart';

class SavedCubit extends Cubit<SavedState> {
  SavedCubit() : super(SavedInitialState());

  static SavedCubit get(context) => BlocProvider.of(context);

  DioHelper dioHelper = DioHelper();

  GetAllUserSavedGaragesModel getAllUserSavedGaragesModel = GetAllUserSavedGaragesModel();

  Future<void> getAllUserSavedGaragesFunction({String? searchQuery}) async {
    emit(GetAllUserSavedGaragesLoadingState());
    try {
      final response = await dioHelper.getData2(
        endPoint: ApiConstants.getUserSavedGarageUrl,
        query: {
          if (searchQuery != null && searchQuery.isNotEmpty) 'search': searchQuery,
        },
      );

      if (response.statusCode == 200) {
        getAllUserSavedGaragesModel = GetAllUserSavedGaragesModel.fromJson(response.data);
        emit(GetAllUserSavedGaragesSuccessState(message: 'Get all user saved Garages successfully'));
      } else if (response.statusCode == 422 || response.statusCode == 404) {
        emit(GetAllUserSavedGaragesErrorState(message: response.data['message'] ?? ''));
      }

    } catch (error) {
      logError(error.toString());
      emit(GetAllUserSavedGaragesErrorState(message: error.toString()));
    }
  }

}
