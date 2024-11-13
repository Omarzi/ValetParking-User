import 'package:valetparking_user/utils/constants/exports.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  bool viaSms = true;
  bool viaEmail = false;

  @override
  Widget build(BuildContext context) {
    final List<String> connectionTypeTexts = [
      'via SMS:',
      'via Email:',
    ];
    final List<String> connectionTypeValue = [
      '+20 115 3083387',
      '3omar123@gmail.com',
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              elevation: 0,
              backgroundColor: VColors.whiteColor,
              title: Text(
                "Forget Password",
                style: VStyles.h4Bold(context),
              ),
              // centerTitle: true,
              leading: null,
              floating: true,
              pinned: true,
              // snap: false,
              flexibleSpace: Container(
                color: VColors.whiteColor,
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 35.h, bottom: 48.h),
            child: Column(
              children: [
                Padding(padding: EdgeInsets.symmetric(horizontal: 46.w), child: Center(child: SvgPicture.asset(VImages.forgetPasswordImage))),

                /// Make Space
                SizedBox(height: 33.33.h),

                /// Check Container (Phone - Email)
                SizedBox(
                  width: double.infinity,
                  // height: 355.h,
                  child: Column(
                    children: [
                      Text('Select which contact details should we use to reset your password', style: VStyles.bodyXLargeMedium(context)),
                      SizedBox(height: 24.h),
                      Column(
                        children: [
                          for (int index = 0; index < 2; index++) ...[
                            CheckToSendOTPContainerWidget(
                              logo: index == 0 ? VImages.smsLogo : VImages.emailLogo,
                              connectionType: connectionTypeTexts[index],
                              detailsText: connectionTypeValue[index],
                              borderColor: (index == 0 && viaSms) || (index == 1 && viaEmail) ? VColors.primaryColor500 : VColors.greyScale200,
                              onTap: () {
                                setState(() {
                                  viaSms = index == 0;
                                  viaEmail = index == 1;
                                });
                              },
                            ),
                            if (index < 1) SizedBox(height: 24.h), /// Add space between the widgets, but not after the last one
                          ],
                        ],
                      ),
                    ],
                  ),
                ),

                /// Make Space
                SizedBox(height: 33.33.h),

                /// Continue Button
                MainButtonWidget(
                  onTap: () {
                    if(viaSms) {
                      FloatingSnackBar.show(
                        context: context,
                        message: 'This feature is not available now, you have to click on via Email',
                        textColor: Colors.white,
                        duration: const Duration(milliseconds: 4000),
                        backgroundColor: VColors.warning,
                      );
                    } else {
                      context.pushNamed(VRoutesName.enterEmailRoute, arguments: viaSms);
                    }
                  },
                  margin: EdgeInsets.zero,
                  buttonColor: VColors.primaryColor500,
                  boxShadow: [AppBoxShadows.buttonShadowOne],
                  centerWidgetInButton: Text(
                      AppLocalizations.of(context)!.translate('continue')!,
                      style: VStyles.bodyLargeBold(context)
                          .copyWith(color: VColors.whiteColor)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}