part of 'booking_cubit.dart';

@immutable
sealed class BookingState {}

final class BookingInitialState extends BookingState {}

/// Get All Orders
final class GetAllOrdersLoadingState extends BookingState {}

final class GetAllOrdersSuccessState extends BookingState {
  final String? message;

  GetAllOrdersSuccessState({this.message});
}

final class GetAllOrdersErrorState extends BookingState {
  final String? message;

  GetAllOrdersErrorState({this.message});
}

/// Get Specific Order States
final class GetSpecificOrderLoadingState extends BookingState {}

final class GetSpecificOrderSuccessState extends BookingState {
  final String? message;

  GetSpecificOrderSuccessState({this.message});
}

final class GetSpecificOrderErrorState extends BookingState {
  final String? message;

  GetSpecificOrderErrorState({this.message});
}
