import 'package:valetparking_user/features/profile/presentation/widgets/change_password/update_new_password_widget.dart';
import 'package:valetparking_user/utils/constants/exports.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              elevation: 0,
              backgroundColor: VColors.whiteColor,
              title: Padding(
                padding: EdgeInsets.only(right: 24.w),
                child: Text(
                  AppLocalizations.of(context)!.translate('changePassword')!,
                  style: VStyles.h4Bold(context),
                ),
              ),
              leading: null,
              floating: true,
              pinned: true,
              flexibleSpace: Container(
                color: VColors.whiteColor,
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 24.h, bottom: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Make Space
                // SizedBox(height: 71.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 49.5.w),
                  child: SvgPicture.asset(
                    VImages.createNewPasswordLogo,
                    fit: BoxFit.scaleDown,
                    width: 329.w,
                    height: 250.h,
                  ),
                ),

                /// Make Space
                SizedBox(height: 71.h),

                Text(AppLocalizations.of(context)!.translate('updateYourPassword')!, style: VStyles.bodyXLargeMedium(context)),

                /// Make Space
                SizedBox(height: 24.h),

                const UpdateNewPasswordWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
