import 'package:valetparking_user/utils/constants/exports.dart';

class CancelledWidget extends StatelessWidget {
  const CancelledWidget({
    super.key,
    required this.pLaceImage,
    required this.placeName,
    required this.placeDesc,
    required this.placePrice,
    required this.numberOfWaiting,
    required this.onTap,
  });

  final String pLaceImage, placeName, placeDesc, placePrice, numberOfWaiting;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [AppBoxShadows.cardShadowTwo],
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Image.asset(pLaceImage),

          /// Make Space
          SizedBox(width: 16.w),

          Container(
            width: VDeviceUtils.getScreenWidth(context) / 1.8,
            padding: EdgeInsets.symmetric(vertical: 6.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  placeName,
                  style: VStyles.h5Bold(context),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  placeDesc,
                  style: VStyles.bodyMediumRegular(context).copyWith(
                    color: VColors.greyScale700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Text(
                      placePrice,
                      style: VStyles.bodyLargeBold(context).copyWith(
                        color: VColors.primaryColor500,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '/ $numberOfWaiting hour',
                      style: VStyles.bodyXSmallRegular(context).copyWith(
                        color: VColors.greyScale700,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    GestureDetector(
                      onTap: onTap,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.r),
                          border: Border.all(
                            color: VColors.alertsAndStatusError,
                            width: 1.w,
                          ),
                        ),
                        child: Text(
                          'Cancelled',
                          style: VStyles.bodyXSmallSemiBold(context).copyWith(
                            color: VColors.alertsAndStatusError,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}