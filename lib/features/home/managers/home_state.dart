part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitialState extends HomeState {}

/// Get All Garages States
final class GetAllGaragesLoadingState extends HomeState {}

final class GetAllGaragesSuccessState extends HomeState {
  final String? message;

  GetAllGaragesSuccessState({this.message});
}

final class GetAllGaragesErrorState extends HomeState {
  final String? message;

  GetAllGaragesErrorState({this.message});
}

/// Make new order States
final class MakeNewOrderLoadingState extends HomeState {}

final class MakeNewOrderSuccessState extends HomeState {
  final String? message;
  final MakeOrderResponseModel makeOrderResponseModel;

  MakeNewOrderSuccessState({this.message, required this.makeOrderResponseModel});
}

final class MakeNewOrderErrorState extends HomeState {
  final String? message;

  MakeNewOrderErrorState({this.message});
}

/// Add Garage To Save States
final class AddGarageToSaveLoadingState extends HomeState {}

final class AddGarageToSaveSuccessState extends HomeState {
  final String? message;

  AddGarageToSaveSuccessState({this.message});
}

final class AddGarageToSaveErrorState extends HomeState {
  final String? message;

  AddGarageToSaveErrorState({this.message});
}

/// Remove Garage From Save States
final class RemoveGarageFromSaveLoadingState extends HomeState {}

final class RemoveGarageFromSaveSuccessState extends HomeState {
  final String? message;

  RemoveGarageFromSaveSuccessState({this.message});
}

final class RemoveGarageFromSaveErrorState extends HomeState {
  final String? message;

  RemoveGarageFromSaveErrorState({this.message});
}