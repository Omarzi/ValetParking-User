part of 'saved_cubit.dart';

@immutable
sealed class SavedState {}

final class SavedInitialState extends SavedState {}


/// Get All User Saved Garages States
final class GetAllUserSavedGaragesLoadingState extends SavedState {}

final class GetAllUserSavedGaragesSuccessState extends SavedState {
  final String? message;

  GetAllUserSavedGaragesSuccessState({this.message});
}

final class GetAllUserSavedGaragesErrorState extends SavedState {
  final String? message;

  GetAllUserSavedGaragesErrorState({this.message});
}
