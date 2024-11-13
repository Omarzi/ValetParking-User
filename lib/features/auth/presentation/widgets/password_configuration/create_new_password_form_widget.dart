import 'package:valetparking_user/features/auth/managers/auth_cubit.dart';
import 'package:valetparking_user/utils/constants/exports.dart';

class CreateNewPasswordFormWidget extends StatefulWidget {
  const CreateNewPasswordFormWidget({super.key, required this.data});

  final Map data;

  @override
  State<CreateNewPasswordFormWidget> createState() =>
      _CreateNewPasswordFormWidgetState();
}

class _CreateNewPasswordFormWidgetState
    extends State<CreateNewPasswordFormWidget> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  final FocusNode newPasswordFocusNode = FocusNode();
  final FocusNode confirmNewPasswordFocusNode = FocusNode();
  bool isNewPasswordFieldFocused = false;
  bool isConfirmNewPasswordFieldFocused = false;
  bool isShownNewPassword = true;
  bool isShownConfirmNewPassword = true;

  @override
  void initState() {
    super.initState();

    /// Add listener to focus node
    newPasswordFocusNode.addListener(() => setState(
        () => isNewPasswordFieldFocused = newPasswordFocusNode.hasFocus));
    confirmNewPasswordFocusNode.addListener(() => setState(() =>
        isConfirmNewPasswordFieldFocused =
            confirmNewPasswordFocusNode.hasFocus));
  }

  @override
  void dispose() {
    /// Clean up the focus node and controller when the widget is disposed.
    newPasswordFocusNode.dispose();
    confirmNewPasswordFocusNode.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  // void validatePasswords(BuildContext context) {
  //   String newPassword = newPasswordController.text;
  //   String confirmNewPassword = confirmNewPasswordController.text;
  //
  //   if (newPassword.isEmpty) {
  //     /// Show snack bar if the new password field is empty
  //     FloatingSnackBar.show(
  //       context: context,
  //       message: 'New Password field cannot be empty',
  //       textColor: Colors.white,
  //       duration: const Duration(milliseconds: 4000),
  //       backgroundColor: VColors.error,
  //     );
  //   } else if (confirmNewPassword.isEmpty) {
  //     /// Show snack bar if the confirm new password field is empty
  //     FloatingSnackBar.show(
  //       context: context,
  //       message: 'Confirm New Password field cannot be empty',
  //       textColor: Colors.white,
  //       duration: const Duration(milliseconds: 4000),
  //       backgroundColor: VColors.error,
  //     );
  //   } else if (newPassword != confirmNewPassword) {
  //     /// Show snack bar if passwords do not match
  //     FloatingSnackBar.show(
  //       context: context,
  //       message: 'Passwords do not match',
  //       textColor: Colors.white,
  //       duration: const Duration(milliseconds: 4000),
  //       backgroundColor: VColors.error,
  //     );
  //   } else {
  //     /// If all validations pass, proceed with the action (e.g., showing a dialog)
  //     VDeviceUtils.showDialogFunction(
  //       context: context,
  //       imagePath: VImages.congratulationUpdatePassword,
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is CreateNewPasswordSuccessState) {
          context.pushNamedAndRemoveUntil(
            VRoutesName.loginAccountRoute,
            predicate: (route) => false,
          );

          // VDeviceUtils.showDialogFunction(
          //   context: context,
          //   imagePath: VImages.congratulationUpdatePassword,
          // );

          FloatingSnackBar.show(
            context: context,
            message: state.message!,
            textColor: Colors.white,
            duration: const Duration(milliseconds: 4000),
            backgroundColor: VColors.success,
          );
        }

        else if(state is CreateNewPasswordErrorState) {
          FloatingSnackBar.show(
            context: context,
            message: state.message!,
            textColor: Colors.white,
            duration: const Duration(milliseconds: 4000),
            backgroundColor: VColors.error,
          );
        }

      },
      builder: (context, state) {
        var createNewPasswordCubit = AuthCubit.get(context);

        return Column(
          children: [
            /// New Password
            TextFormFieldWidget(
              controller: newPasswordController,
              textInputType: TextInputType.visiblePassword,
              focusNode: newPasswordFocusNode,
              hintText: AppLocalizations.of(context)!.translate('password')!,
              hintColor: isNewPasswordFieldFocused
                  ? VColors.primaryColor500
                  : VColors.greyScale500,
              prefixIcon: SvgPicture.asset(VImages.passwordIcon,
                  fit: BoxFit.scaleDown,
                  colorFilter: ColorFilter.mode(
                      isNewPasswordFieldFocused
                          ? VColors.primaryColor500
                          : newPasswordController.text.isNotEmpty
                              ? VColors.greyScale900
                              : VColors.greyScale500,
                      BlendMode.srcIn)),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() => isShownNewPassword = !isShownNewPassword);
                },
                child: SvgPicture.asset(
                    isShownNewPassword
                        ? VImages.eyeHideIcon
                        : VImages.eyeShowIcon,
                    fit: BoxFit.scaleDown,
                    colorFilter: ColorFilter.mode(
                        isNewPasswordFieldFocused
                            ? VColors.primaryColor500
                            : newPasswordController.text.isNotEmpty
                                ? VColors.greyScale900
                                : VColors.greyScale500,
                        BlendMode.srcIn)),
              ),
              fillColor: isNewPasswordFieldFocused
                  ? VColors.purpleTransparent.withOpacity(.08)
                  : VColors.greyScale50,
              borderSide: isNewPasswordFieldFocused
                  ? BorderSide(color: VColors.primaryColor500)
                  : BorderSide.none,
              obscureText: isShownNewPassword,
              obscureCharacter: '●',
              maxLines: 1,
            ),

            /// Make Space
            SizedBox(height: 24.h),

            /// Confirm New Password
            TextFormFieldWidget(
              controller: confirmNewPasswordController,
              textInputType: TextInputType.visiblePassword,
              focusNode: confirmNewPasswordFocusNode,
              hintText: AppLocalizations.of(context)!
                  .translate('confirmNewPassword')!,
              hintColor: isConfirmNewPasswordFieldFocused
                  ? VColors.primaryColor500
                  : VColors.greyScale500,
              prefixIcon: SvgPicture.asset(VImages.passwordIcon,
                  fit: BoxFit.scaleDown,
                  colorFilter: ColorFilter.mode(
                      isConfirmNewPasswordFieldFocused
                          ? VColors.primaryColor500
                          : confirmNewPasswordController.text.isNotEmpty
                              ? VColors.greyScale900
                              : VColors.greyScale500,
                      BlendMode.srcIn)),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() =>
                      isShownConfirmNewPassword = !isShownConfirmNewPassword);
                },
                child: SvgPicture.asset(
                    isShownConfirmNewPassword
                        ? VImages.eyeHideIcon
                        : VImages.eyeShowIcon,
                    fit: BoxFit.scaleDown,
                    colorFilter: ColorFilter.mode(
                        isConfirmNewPasswordFieldFocused
                            ? VColors.primaryColor500
                            : confirmNewPasswordController.text.isNotEmpty
                                ? VColors.greyScale900
                                : VColors.greyScale500,
                        BlendMode.srcIn)),
              ),
              fillColor: isConfirmNewPasswordFieldFocused
                  ? VColors.purpleTransparent.withOpacity(.08)
                  : VColors.greyScale50,
              borderSide: isConfirmNewPasswordFieldFocused
                  ? BorderSide(color: VColors.primaryColor500)
                  : BorderSide.none,
              obscureText: isShownConfirmNewPassword,
              obscureCharacter: '●',
              maxLines: 1,
            ),

            /// Make Space
            SizedBox(height: 71.h),

            /// Continue Button
            MainButtonWidget(
              centerWidgetInButton: state is CreateNewPasswordLoadingState
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                      AppLocalizations.of(context)!.translate('continue')!,
                      style: VStyles.bodyLargeBold(context)
                          .copyWith(color: VColors.whiteColor),
                    ),
              onTap: () {
                // validatePasswords(context);
                String newPassword = newPasswordController.text;
                String confirmNewPassword = confirmNewPasswordController.text;

                if (newPassword.isEmpty) {
                  /// Show snack bar if the new password field is empty
                  FloatingSnackBar.show(
                    context: context,
                    message: 'New Password field cannot be empty',
                    textColor: Colors.white,
                    duration: const Duration(milliseconds: 4000),
                    backgroundColor: VColors.error,
                  );
                } else if (confirmNewPassword.isEmpty) {
                  /// Show snack bar if the confirm new password field is empty
                  FloatingSnackBar.show(
                    context: context,
                    message: 'Confirm New Password field cannot be empty',
                    textColor: Colors.white,
                    duration: const Duration(milliseconds: 4000),
                    backgroundColor: VColors.error,
                  );
                } else if (newPassword != confirmNewPassword) {
                  /// Show snack bar if passwords do not match
                  FloatingSnackBar.show(
                    context: context,
                    message: 'Passwords do not match',
                    textColor: Colors.white,
                    duration: const Duration(milliseconds: 4000),
                    backgroundColor: VColors.error,
                  );
                } else {
                  /// If all validations pass, proceed with the action (e.g., showing a dialog)
                  createNewPasswordCubit.createNewPasswordFunction(
                    email: widget.data['emailAddress'],
                    newPassword: newPassword,
                    confirmPassword: confirmNewPassword,
                  );
                }
              },

              /// Validate before proceeding
              margin: EdgeInsets.zero,
              buttonColor: newPasswordController.text.isEmpty ||
                      confirmNewPasswordController.text.isEmpty
                  ? VColors.disabledButton
                  : VColors.primaryColor500,
              boxShadow: newPasswordController.text.isEmpty ||
                      confirmNewPasswordController.text.isEmpty
                  ? []
                  : [AppBoxShadows.buttonShadowOne],
            ),
          ],
        );
      },
    );
  }
}

// import 'package:valetparking_user/utils/constants/exports.dart';
//
// class CreateNewPasswordFormWidget extends StatefulWidget {
//   const CreateNewPasswordFormWidget({super.key});
//
//   @override
//   State<CreateNewPasswordFormWidget> createState() => _CreateNewPasswordFormWidgetState();
// }
//
// class _CreateNewPasswordFormWidgetState extends State<CreateNewPasswordFormWidget> {
//   TextEditingController newPasswordController = TextEditingController();
//   TextEditingController confirmNewPasswordController = TextEditingController();
//   final FocusNode newPasswordFocusNode = FocusNode();
//   final FocusNode confirmNewPasswordFocusNode = FocusNode();
//   bool isNewPasswordFieldFocused = false;
//   bool isConfirmNewPasswordFieldFocused = false;
//   bool isShownNewPassword = false;
//   bool isShownConfirmNewPassword = false;
//
//   @override
//   void initState() {
//     super.initState();
//     /// Add listener to focus node
//     newPasswordFocusNode.addListener(() => setState(() => isNewPasswordFieldFocused = newPasswordFocusNode.hasFocus));
//     confirmNewPasswordFocusNode.addListener(() => setState(() => isConfirmNewPasswordFieldFocused = confirmNewPasswordFocusNode.hasFocus));
//   }
//
//   @override
//   void dispose() {
//     /// Clean up the focus node and controller when the widget is disposed.
//     newPasswordFocusNode.dispose();
//     confirmNewPasswordFocusNode.dispose();
//     newPasswordController.dispose();
//     confirmNewPasswordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         /// New Password
//         TextFormFieldWidget(
//           controller: newPasswordController,
//           textInputType: TextInputType.visiblePassword,
//           focusNode: newPasswordFocusNode,
//           hintText: AppLocalizations.of(context)!.translate('password')!,
//           hintColor: isNewPasswordFieldFocused
//               ? VColors.primaryColor500
//               : VColors.greyScale500,
//           prefixIcon: SvgPicture.asset(VImages.passwordIcon,
//               fit: BoxFit.scaleDown,
//               colorFilter: ColorFilter.mode(
//                   isNewPasswordFieldFocused
//                       ? VColors.primaryColor500
//                       : newPasswordController.text.isNotEmpty
//                       ? VColors.greyScale900
//                       : VColors.greyScale500,
//                   BlendMode.srcIn)),
//           suffixIcon: GestureDetector(
//             onTap: () {
//               setState(() => isShownNewPassword = !isShownNewPassword);
//             },
//             child: SvgPicture.asset(
//                 isShownNewPassword ? VImages.eyeHideIcon : VImages.eyeShowIcon,
//                 fit: BoxFit.scaleDown,
//                 colorFilter: ColorFilter.mode(
//                     isNewPasswordFieldFocused
//                         ? VColors.primaryColor500
//                         : newPasswordController.text.isNotEmpty
//                         ? VColors.greyScale900
//                         : VColors.greyScale500,
//                     BlendMode.srcIn)),
//           ),
//           fillColor: isNewPasswordFieldFocused
//               ? VColors.purpleTransparent.withOpacity(.08)
//               : VColors.greyScale50,
//           borderSide: isNewPasswordFieldFocused
//               ? BorderSide(color: VColors.primaryColor500)
//               : BorderSide.none,
//           obscureText: isShownNewPassword,
//           obscureCharacter: '●',
//           maxLines: 1,
//         ),
//
//
//         /// Make Space
//         SizedBox(height: 24.h),
//
//         /// Confirm New Password
//         TextFormFieldWidget(
//           controller: confirmNewPasswordController,
//           textInputType: TextInputType.visiblePassword,
//           focusNode: confirmNewPasswordFocusNode,
//           hintText: AppLocalizations.of(context)!.translate('confirmNewPassword')!,
//           hintColor: isConfirmNewPasswordFieldFocused
//               ? VColors.primaryColor500
//               : VColors.greyScale500,
//           prefixIcon: SvgPicture.asset(VImages.passwordIcon,
//               fit: BoxFit.scaleDown,
//               colorFilter: ColorFilter.mode(
//                   isConfirmNewPasswordFieldFocused
//                       ? VColors.primaryColor500
//                       : confirmNewPasswordController.text.isNotEmpty
//                       ? VColors.greyScale900
//                       : VColors.greyScale500,
//                   BlendMode.srcIn)),
//           suffixIcon: GestureDetector(
//             onTap: () {
//               setState(() => isShownConfirmNewPassword = !isShownConfirmNewPassword);
//             },
//             child: SvgPicture.asset(
//                 isShownConfirmNewPassword ? VImages.eyeHideIcon : VImages.eyeShowIcon,
//                 fit: BoxFit.scaleDown,
//                 colorFilter: ColorFilter.mode(
//                     isConfirmNewPasswordFieldFocused
//                         ? VColors.primaryColor500
//                         : confirmNewPasswordController.text.isNotEmpty
//                         ? VColors.greyScale900
//                         : VColors.greyScale500,
//                     BlendMode.srcIn)),
//           ),
//           fillColor: isConfirmNewPasswordFieldFocused
//               ? VColors.purpleTransparent.withOpacity(.08)
//               : VColors.greyScale50,
//           borderSide: isConfirmNewPasswordFieldFocused
//               ? BorderSide(color: VColors.primaryColor500)
//               : BorderSide.none,
//           obscureText: isShownConfirmNewPassword,
//           obscureCharacter: '●',
//           maxLines: 1,
//         ),
//
//         /// Make Space
//         SizedBox(height: 71.h),
//
//         /// Continue Button
//         MainButtonWidget(
//           centerWidgetInButton: Text(
//               AppLocalizations.of(context)!.translate('continue')!,
//               style: VStyles.bodyLargeBold.copyWith(color: VColors.whiteColor),
//           ),
//           onTap: () => VDeviceUtils.showDialogFunction(context: context, imagePath: VImages.congratulationUpdatePassword),
//           margin: EdgeInsets.zero,
//           buttonColor: newPasswordController.text.isEmpty || confirmNewPasswordController.text.isEmpty ? VColors.disabledButton : VColors.primaryColor500,
//           boxShadow: newPasswordController.text.isEmpty || confirmNewPasswordController.text.isEmpty ? [] : [AppBoxShadows.buttonShadowOne],
//         ),
//       ],
//     );
//   }
// }
