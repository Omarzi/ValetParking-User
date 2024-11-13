import 'package:valetparking_user/utils/constants/exports.dart';

class CancelParkingWidget extends StatelessWidget {
  const CancelParkingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: VDeviceUtils.getScreenHeight(context) / 3,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(40.r), topRight: Radius.circular(40.r))),
        child: Column(
          children: [
            /// Make Space
            SizedBox(height: 35.h),

            SizedBox(width: double.infinity, height: VDeviceUtils.getScreenHeight(context) / 26, child: Text('Cancel Parking', style: VStyles.h4Bold(context).copyWith(color: VColors.alertsAndStatusError), textAlign: TextAlign.center)),

            /// Make Space
            SizedBox(height: 24.h),

            Container(width: double.infinity, height: 1.w, color: VColors.greyScale200,),

            /// Make Space
            SizedBox(height: 24.h),

            SizedBox(width: double.infinity, height: VDeviceUtils.getScreenHeight(context) / 26, child: Text('Are you sure you want to cancel your Parking Reservation?', style: VStyles.h5Bold(context).copyWith(color: VColors.greyScale800), textAlign: TextAlign.center)),

            SizedBox(width: double.infinity, height: VDeviceUtils.getScreenHeight(context) / 26, child: Text('Only 80% of the money you can refund from your payment according to our policy', style: VStyles.bodyMediumRegular(context).copyWith(color: VColors.greyScale800), textAlign: TextAlign.center)),

            /// Make Space
            SizedBox(height: 12.h),

            /// Two Buttons (Cancel - Yes)
            SizedBox(
              width: double.infinity,
              height: VDeviceUtils.getScreenHeight(context) / 13,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SecondButtonWidget(bgColor: VColors.primaryColor100, widget: Text(AppLocalizations.of(context)!.translate('cancel')!, style: VStyles.bodyLargeBold(context).copyWith(color: VColors.primaryColor500)), onTap: () => context.pop()),
                  SecondButtonWidget(bgColor: VColors.primaryColor500, widget: Text(AppLocalizations.of(context)!.translate('yesContinue')!, style: VStyles.bodyLargeBold(context).copyWith(color: VColors.whiteColor)), onTap: () {
                    VCacheHelper.removeFromShared(key: CacheKeys.token);
                    context.pushNamedAndRemoveUntil(VRoutesName.onBoardingRoute, predicate: (Route<dynamic> route) => false);
                  }),
                ],
              ),
            ),
          ],
        )
    );
  }
}
