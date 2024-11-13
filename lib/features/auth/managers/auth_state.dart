part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitialState extends AuthState {}

/// Login States
class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {
  final String? message;

  LoginSuccessState({this.message});
}

class LoginErrorState extends AuthState {
  final String? message;

  LoginErrorState({this.message});
}

/// Verify Reset Code Of Login States
class VerifyResetCodeOfLoginLoadingState extends AuthState {}

class VerifyResetCodeOfLoginSuccessState extends AuthState {
  final String? message;

  VerifyResetCodeOfLoginSuccessState({this.message});
}

class VerifyResetCodeOfLoginErrorState extends AuthState {
  final String? message;

  VerifyResetCodeOfLoginErrorState({this.message});
}

/// Signup States
class SignupLoadingState extends AuthState {}

class SignupSuccessState extends AuthState {
  final String? message;

  SignupSuccessState({this.message});
}

class SignupErrorState extends AuthState {
  final String? message;

  SignupErrorState({this.message});
}

/// Forget Password States
class ForgetPasswordLoadingState extends AuthState {}

class ForgetPasswordSuccessState extends AuthState {
  final String? message;

  ForgetPasswordSuccessState({this.message});
}

class ForgetPasswordErrorState extends AuthState {
  final String? message;

  ForgetPasswordErrorState({this.message});
}

/// Verify Reset Password States
class VerifyResetPasswordLoadingState extends AuthState {}

class VerifyResetPasswordSuccessState extends AuthState {
  final String? message;

  VerifyResetPasswordSuccessState({this.message});
}

class VerifyResetPasswordErrorState extends AuthState {
  final String? message;

  VerifyResetPasswordErrorState({this.message});
}

/// Create New Password States
class CreateNewPasswordLoadingState extends AuthState {}

class CreateNewPasswordSuccessState extends AuthState {
  final String? message;

  CreateNewPasswordSuccessState({this.message});
}

class CreateNewPasswordErrorState extends AuthState {
  final String? message;

  CreateNewPasswordErrorState({this.message});
}
