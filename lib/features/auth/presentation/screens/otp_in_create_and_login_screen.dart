import 'package:valetparking_user/common/widgets/texts_rich/text_rich2_widget.dart';
import 'package:valetparking_user/features/auth/managers/auth_cubit.dart';
import 'package:valetparking_user/utils/constants/exports.dart';

class OtpInCreateAndLoginScreen extends StatefulWidget {
  // const OtpInCreateAndLoginScreen({super.key, required this.emailAddress, required this.screenName});
  const OtpInCreateAndLoginScreen({super.key, required this.data});

  // final String emailAddress, screenName;
  final Map data;

  @override
  State<OtpInCreateAndLoginScreen> createState() =>
      _OtpInCreateAndLoginScreenState();
}

class _OtpInCreateAndLoginScreenState extends State<OtpInCreateAndLoginScreen> {
  TextEditingController pinputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VColors.whiteColor,
      body: NestedScrollView(
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
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is VerifyResetPasswordSuccessState) {
              if(widget.data['screenName'] != 'loginScreen') {
                context.pushNamedAndRemoveUntil(VRoutesName.enterNewPasswordRoute,
                    predicate: (route) => false,
                    arguments: {
                      'emailAddress': widget.data['emailAddress'],
                    });

                FloatingSnackBar.show(
                  context: context,
                  message: state.message!,
                  textColor: Colors.white,
                  duration: const Duration(milliseconds: 4000),
                  backgroundColor: VColors.success,
                );
              } else {
                context.pushNamedAndRemoveUntil(
                  VRoutesName.navigationMenuRoute,
                  predicate: (route) => false,
                  arguments: 0,
                );

                FloatingSnackBar.show(
                  context: context,
                  message: state.message!,
                  textColor: Colors.white,
                  duration: const Duration(milliseconds: 4000),
                  backgroundColor: VColors.success,
                );
              }
            } else if (state is VerifyResetPasswordErrorState) {
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
            var verifyResetCodeCubit = AuthCubit.get(context);

            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w)
                        .copyWith(top: 75.h, bottom: 48.h),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50.h,
                          width: double.infinity,
                          child: Text(
                            '${AppLocalizations.of(context)!.translate('codeHasBeenSentTo: ')!}${widget.data['emailAddress']}',
                            style: VStyles.bodyXLargeRegular(context),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        /// Make Space
                        SizedBox(height: 80.h),

                        /// OTP
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: SizedBox(
                            width: double.infinity,
                            child: Pinput(
                              // androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
                              controller: pinputController,
                              length: 4,
                              obscureText: true,
                              obscuringCharacter: '⚫',
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              focusedPinTheme: PinTheme(
                                height: 61.h,
                                width: 83.w,
                                textStyle: VStyles.h4Bold(context),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.sp),
                                  border: Border.all(
                                      width: 1.w,
                                      color: VColors.primaryColor500),
                                  color: VColors.purpleTransparent
                                      .withOpacity(.08),
                                ),
                              ),
                              defaultPinTheme: PinTheme(
                                height: 61.h,
                                width: 83.w,
                                textStyle: VStyles.h4Bold(context),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.sp),
                                  color: VColors.greyScale50,
                                  border: Border.all(
                                      width: 1.w, color: VColors.greyScale200),
                                ),
                              ),
                              pinputAutovalidateMode:
                                  PinputAutovalidateMode.onSubmit,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '';
                                }
                                return null;
                              },
                              onCompleted: (value) async {
                                if (widget.data['screenName'] == 'loginScreen') {
                                  // context.pushNamedAndRemoveUntil(
                                  //   VRoutesName.navigationMenuRoute,
                                  //   predicate: (route) => false,
                                  //   arguments: 0,
                                  // );
                                  verifyResetCodeCubit.verifyResetCodeFunction(
                                    resetCode: pinputController.text,
                                  );
                                  logSuccess(pinputController.text);
                                } else {
                                  // verifyResetCodeCubit.verifyResetCodeFunction(
                                  //   resetCode: pinputController.text,
                                  // );
                                }
                              }
                                //   verifyResetCodeCubit.verifyResetCodeFunction(
                                // resetCode: pinputController.text,
                              // ),
                            ),
                          ),
                        ),

                        /// Make Space
                        SizedBox(height: 50.h),

                        /// Counter Text
                        TextRich2Widget(
                          text1:
                              '${AppLocalizations.of(context)!.translate('resendCodeIn')!} ',
                          style: VStyles.bodyXLargeMedium(context)
                              .copyWith(color: VColors.primaryColor500),
                        ),

                        /// Make Space
                        SizedBox(height: 50.h),

                        /// Continue Button
                        MainButtonWidget(
                          centerWidgetInButton:
                              state is VerifyResetPasswordLoadingState
                                  ? const CircularProgressIndicator(
                                      color: Colors.white)
                                  : Text(
                                      AppLocalizations.of(context)!
                                          .translate('verify')
                                          .toString(),
                                      style: VStyles.bodyLargeBold(context)
                                          .copyWith(color: VColors.whiteColor),
                                    ),
                          onTap: () {
                            if (widget.data['screenName'] == 'loginScreen') {
                              verifyResetCodeCubit.verifyResetCodeFunction(
                                resetCode: pinputController.text,
                              );
                            } else {
                              // verifyResetCodeCubit.verifyResetCodeForLoginFunction(
                              //   resetCode: pinputController.text,
                              // );
                            }
                          },
                          margin: EdgeInsets.zero,
                          buttonColor: VColors.primaryColor500,
                          boxShadow: [AppBoxShadows.buttonShadowOne],
                        ),

                        /// Make Space
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
