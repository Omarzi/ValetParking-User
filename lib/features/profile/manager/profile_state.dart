part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitialState extends ProfileState {}

/// Get Profile Data State
final class GetProfileDataLoadingState extends ProfileState {}

final class GetProfileDataSuccessState extends ProfileState {}

final class GetProfileDataErrorState extends ProfileState {
  final String? message;

  GetProfileDataErrorState({this.message});
}

final class UpdateProfileDataLoadingState extends ProfileState {}

final class UpdateProfileDataSuccessState extends ProfileState {}

final class UpdateProfileDataErrorState extends ProfileState {
  final String? message;

  UpdateProfileDataErrorState({this.message});
}

/// Update Password States
final class UpdatePasswordLoadingState extends ProfileState {}

final class UpdatePasswordSuccessState extends ProfileState {
  final String? message;

  UpdatePasswordSuccessState({this.message});
}

final class UpdatePasswordErrorState extends ProfileState {
  final String? message;

  UpdatePasswordErrorState({this.message});
}

/// Get Wallet States
final class GetWalletLoadingState extends ProfileState {}

final class GetWalletSuccessState extends ProfileState {
  final String? message;

  GetWalletSuccessState({this.message});
}

final class GetWalletErrorState extends ProfileState {
  final String? message;

  GetWalletErrorState({this.message});
}
