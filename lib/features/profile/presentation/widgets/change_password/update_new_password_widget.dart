import 'package:valetparking_user/features/profile/manager/profile_cubit.dart';
import 'package:valetparking_user/utils/constants/exports.dart';
import 'package:valetparking_user/utils/formatters/formatter.dart';

class UpdateNewPasswordWidget extends StatefulWidget {
  const UpdateNewPasswordWidget({super.key});

  @override
  State<UpdateNewPasswordWidget> createState() =>
      _UpdateNewPasswordWidgetState();
}

class _UpdateNewPasswordWidgetState extends State<UpdateNewPasswordWidget> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  final FocusNode oldPasswordFocusNode = FocusNode();
  final FocusNode newPasswordFocusNode = FocusNode();
  final FocusNode confirmNewPasswordFocusNode = FocusNode();
  bool isOldPasswordFieldFocused = false;
  bool isNewPasswordFieldFocused = false;
  bool isConfirmNewPasswordFieldFocused = false;
  bool isShownOldPassword = false;
  bool isShownNewPassword = false;
  bool isShownConfirmNewPassword = false;

  @override
  void initState() {
    super.initState();

    /// Add listener to focus node
    oldPasswordFocusNode.addListener(() => setState(
        () => isOldPasswordFieldFocused = oldPasswordFocusNode.hasFocus));
    newPasswordFocusNode.addListener(() => setState(
        () => isNewPasswordFieldFocused = newPasswordFocusNode.hasFocus));
    confirmNewPasswordFocusNode.addListener(() => setState(() =>
        isConfirmNewPasswordFieldFocused =
            confirmNewPasswordFocusNode.hasFocus));
  }

  @override
  void dispose() {
    /// Clean up the focus node and controller when the widget is disposed.
    oldPasswordFocusNode.dispose();
    newPasswordFocusNode.dispose();
    confirmNewPasswordFocusNode.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  void validateAndNavigate(BuildContext context) {
    String oldPassword = oldPasswordController.text;
    String newPassword = newPasswordController.text;
    String confirmNewPassword = confirmNewPasswordController.text;

    if (oldPassword.isEmpty) {
      FloatingSnackBar.show(
        context: context,
        message: 'Old-Password cannot be empty',
        textColor: Colors.white,
        duration: const Duration(milliseconds: 4000),
        backgroundColor: VColors.error,
      );
    } else if (newPassword.isEmpty) {
      FloatingSnackBar.show(
        context: context,
        message: 'New-Password cannot be empty',
        textColor: Colors.white,
        duration: const Duration(milliseconds: 4000),
        backgroundColor: VColors.error,
      );
    } else if (confirmNewPassword.isEmpty) {
      FloatingSnackBar.show(
        context: context,
        message: 'Confirm-New-Password cannot be empty',
        textColor: Colors.white,
        duration: const Duration(milliseconds: 4000),
        backgroundColor: VColors.error,
      );
    } else if (newPassword != confirmNewPassword) {
      FloatingSnackBar.show(
        context: context,
        message: 'The new password must be identical to Confirm new password',
        textColor: Colors.white,
        duration: const Duration(milliseconds: 4000),
        backgroundColor: VColors.warning,
      );
    } else {
      VDeviceUtils.showDialogFunction(
        context: context,
        imagePath: VImages.congratulationUpdatePassword,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is UpdatePasswordSuccessState) {
          context.pop();

          FloatingSnackBar.show(
            context: context,
            message: 'Update password successfully',
            textColor: Colors.white,
            duration: const Duration(milliseconds: 4000),
            backgroundColor: VColors.success,
          );
        } else if (state is UpdatePasswordErrorState) {
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
        var changePasswordCubit = ProfileCubit.get(context);

        return Column(
          children: [
            /// Old Password
            TextFormFieldWidget(
              controller: oldPasswordController,
              textInputType: TextInputType.visiblePassword,
              focusNode: oldPasswordFocusNode,
              hintText: 'Old Password',
              hintColor: isOldPasswordFieldFocused
                  ? VColors.primaryColor500
                  : VColors.greyScale500,
              prefixIcon: SvgPicture.asset(VImages.passwordIcon,
                  fit: BoxFit.scaleDown,
                  colorFilter: ColorFilter.mode(
                      isOldPasswordFieldFocused
                          ? VColors.primaryColor500
                          : confirmNewPasswordController.text.isNotEmpty
                              ? VColors.greyScale900
                              : VColors.greyScale500,
                      BlendMode.srcIn)),
              suffixIcon: IconButton(
                onPressed: () =>
                    setState(() => isShownOldPassword = !isShownOldPassword),
                icon: SvgPicture.asset(
                    !isShownOldPassword
                        ? VImages.hideEyeIcon
                        : VImages.showEyeIcon,
                    fit: BoxFit.scaleDown,
                    colorFilter: ColorFilter.mode(
                        isOldPasswordFieldFocused
                            ? VColors.primaryColor500
                            : confirmNewPasswordController.text.isNotEmpty
                                ? VColors.greyScale900
                                : VColors.greyScale500,
                        BlendMode.srcIn)),
              ),
              fillColor: isOldPasswordFieldFocused
                  ? VColors.purpleTransparent.withOpacity(.08)
                  : VColors.greyScale50,
              borderSide: isOldPasswordFieldFocused
                  ? BorderSide(color: VColors.primaryColor500)
                  : BorderSide.none,
              obscureText: !isShownOldPassword,
              obscureCharacter: '●',
              maxLines: 1,
            ),

            /// Make Space
            SizedBox(height: 24.h),

            /// New Password
            TextFormFieldWidget(
              controller: newPasswordController,
              textInputType: TextInputType.visiblePassword,
              focusNode: newPasswordFocusNode,
              hintText: 'New Password',
              hintColor: isNewPasswordFieldFocused
                  ? VColors.primaryColor500
                  : VColors.greyScale500,
              prefixIcon: SvgPicture.asset(VImages.passwordIcon,
                  fit: BoxFit.scaleDown,
                  colorFilter: ColorFilter.mode(
                      isNewPasswordFieldFocused
                          ? VColors.primaryColor500
                          : confirmNewPasswordController.text.isNotEmpty
                              ? VColors.greyScale900
                              : VColors.greyScale500,
                      BlendMode.srcIn)),
              suffixIcon: IconButton(
                onPressed: () =>
                    setState(() => isShownNewPassword = !isShownNewPassword),
                icon: SvgPicture.asset(
                    !isShownNewPassword
                        ? VImages.hideEyeIcon
                        : VImages.showEyeIcon,
                    fit: BoxFit.scaleDown,
                    colorFilter: ColorFilter.mode(
                        isNewPasswordFieldFocused
                            ? VColors.primaryColor500
                            : confirmNewPasswordController.text.isNotEmpty
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
              obscureText: !isShownNewPassword,
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
              hintText: 'Confirm New Password',
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
              suffixIcon: IconButton(
                onPressed: () => setState(() =>
                    isShownConfirmNewPassword = !isShownConfirmNewPassword),
                icon: SvgPicture.asset(
                    !isShownConfirmNewPassword
                        ? VImages.hideEyeIcon
                        : VImages.showEyeIcon,
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
              obscureText: !isShownConfirmNewPassword,
              obscureCharacter: '●',
              maxLines: 1,
            ),

            /// Make Space
            SizedBox(height: 24.h),

            /// Continue Button
            MainButtonWidget(
              centerWidgetInButton: state is UpdatePasswordLoadingState
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text('Update',
                      style: VStyles.bodyLargeBold(context)
                          .copyWith(color: VColors.whiteColor)),
              // onTap: () => validateAndNavigate(context),
              onTap: () {
                String oldPassword = oldPasswordController.text;
                String newPassword = newPasswordController.text;
                String confirmNewPassword = confirmNewPasswordController.text;

                if (oldPassword.isEmpty) {
                  FloatingSnackBar.show(
                    context: context,
                    message: 'Old-Password cannot be empty',
                    textColor: Colors.white,
                    duration: const Duration(milliseconds: 4000),
                    backgroundColor: VColors.error,
                  );
                } else if (newPassword.isEmpty) {
                  FloatingSnackBar.show(
                    context: context,
                    message: 'New-Password cannot be empty',
                    textColor: Colors.white,
                    duration: const Duration(milliseconds: 4000),
                    backgroundColor: VColors.error,
                  );
                } else if (confirmNewPassword.isEmpty) {
                  FloatingSnackBar.show(
                    context: context,
                    message: 'Confirm-New-Password cannot be empty',
                    textColor: Colors.white,
                    duration: const Duration(milliseconds: 4000),
                    backgroundColor: VColors.error,
                  );
                } else if (newPassword != confirmNewPassword) {
                  FloatingSnackBar.show(
                    context: context,
                    message:
                        'The new password must be identical to Confirm new password',
                    textColor: Colors.white,
                    duration: const Duration(milliseconds: 4000),
                    backgroundColor: VColors.warning,
                  );
                } else {
                  // VDeviceUtils.showDialogFunction(
                  //   context: context,
                  //   imagePath: VImages.congratulationUpdatePassword,
                  // );
                  changePasswordCubit.updatePasswordFunction(
                    currentPassword: oldPassword,
                    newPassword: newPassword,
                    confirmPassword: confirmNewPassword,
                  );
                }
              },
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
