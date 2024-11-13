import 'package:flutter/material.dart';
import 'package:valetparking_user/features/auth/managers/auth_cubit.dart';
import 'package:valetparking_user/utils/constants/exports.dart';

class EnterEmailScreen extends StatefulWidget {
  const EnterEmailScreen({super.key});

  @override
  State<EnterEmailScreen> createState() => _EnterEmailScreenState();
}

class _EnterEmailScreenState extends State<EnterEmailScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  bool isEmailFieldFocused = false;

  @override
  void initState() {
    super.initState();

    /// Add listener to focus node
    emailFocusNode.addListener(
        () => setState(() => isEmailFieldFocused = emailFocusNode.hasFocus));
  }

  @override
  void dispose() {
    /// Clean up the focus node and controller when the widget is disposed.
    emailFocusNode.dispose();
    emailController.dispose();
    super.dispose();
  }

  // void validateAndNavigate(BuildContext context) {

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ForgetPasswordSuccessState) {
            context.pushNamed(VRoutesName.otpRoute, arguments: {
              'emailAddress': emailController.text,
              'screenName': 'forgetPasswordScreen',
            });

            FloatingSnackBar.show(
              context: context,
              message: state.message!,
              textColor: Colors.white,
              duration: const Duration(milliseconds: 4000),
              backgroundColor: VColors.success,
            );
          } else if(state is ForgetPasswordErrorState) {
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
          var forgetPasswordCubit = AuthCubit.get(context);

          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  elevation: 0,
                  backgroundColor: VColors.whiteColor,
                  title: Text(
                    "Forgot Password",
                    style: VStyles.h4Bold(context).copyWith(fontSize: 21.sp),
                  ),
                  flexibleSpace: Container(
                    color: VColors.whiteColor,
                  ),
                ),
              ];
            },
            body: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 46.w),
                        child: Center(
                            child:
                                SvgPicture.asset(VImages.forgetPasswordImage)),
                      ),

                      /// Make Space
                      SizedBox(height: 33.33.h),

                      /// Email
                      TextFormFieldWidget(
                        controller: emailController,
                        textInputType: TextInputType.emailAddress,
                        focusNode: emailFocusNode,
                        hintText:
                            AppLocalizations.of(context)!.translate('email')!,
                        hintColor: isEmailFieldFocused
                            ? VColors.primaryColor500
                            : VColors.greyScale500,
                        prefixIcon: SvgPicture.asset(VImages.email2Icon,
                            fit: BoxFit.scaleDown,
                            colorFilter: ColorFilter.mode(
                                isEmailFieldFocused
                                    ? VColors.primaryColor500
                                    : emailController.text.isNotEmpty
                                        ? VColors.greyScale900
                                        : VColors.greyScale500,
                                BlendMode.srcIn)),
                        fillColor: isEmailFieldFocused
                            ? VColors.purpleTransparent.withOpacity(.08)
                            : VColors.greyScale50,
                        borderSide: isEmailFieldFocused
                            ? BorderSide(color: VColors.primaryColor500)
                            : BorderSide.none,
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'You must fill out this field';
                          } else if (!RegExp(
                                  r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$")
                              .hasMatch(value)) {
                            return 'You must fill this field in valid ex: example@gmail.com';
                          }
                          return null;
                        },
                      ),

                      /// Make Space
                      SizedBox(height: 24.h),

                      /// Sign in Button
                      MainButtonWidget(
                        centerWidgetInButton: state is ForgetPasswordLoadingState
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                            AppLocalizations.of(context)!
                                .translate('continue')!,
                            style: VStyles.bodyLargeBold(context)
                                .copyWith(color: VColors.whiteColor)),
                        onTap: () {
                          /// Validate and navigate
                          String email = emailController.text;

                          if (email.isEmpty) {
                            /// Show snack bar if the field is empty
                            FloatingSnackBar.show(
                              context: context,
                              message: 'You must fill out this field',
                              textColor: Colors.white,
                              duration: const Duration(milliseconds: 4000),
                              backgroundColor: VColors.error,
                            );
                          }
                          else if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$")
                              .hasMatch(email)) {
                            /// Show snack bar for invalid email format
                            FloatingSnackBar.show(
                              context: context,
                              message: 'You must fill this field in valid ex: example@gmail.com',
                              textColor: Colors.white,
                              duration: const Duration(milliseconds: 4000),
                              backgroundColor: VColors.error,
                            );
                          }
                          else {
                            /// Proceed with navigation if validation passes
                            forgetPasswordCubit.forgetPasswordFunction(email: email);
                          }
                          // validateAndNavigate(context);
                        },
                        margin: EdgeInsets.zero,
                        buttonColor: emailController.text.isEmpty
                            ? VColors.disabledButton
                            : VColors.primaryColor500,
                        boxShadow: emailController.text.isEmpty
                            ? []
                            : [AppBoxShadows.buttonShadowOne],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
