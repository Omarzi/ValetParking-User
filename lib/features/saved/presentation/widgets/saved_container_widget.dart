import 'package:valetparking_user/utils/constants/exports.dart';

class SavedContainerWidget extends StatelessWidget {
  const SavedContainerWidget({
    super.key,
    required this.placeImage,
    required this.placeName,
    required this.placeDesc,
    required this.onTap,
  });

  final String placeImage, placeName, placeDesc;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [AppBoxShadows.cardShadowTwo],
      ),
      child: Row(
        children: [
          /// Place Image
          Container(
            width: 70.w,
            height: 70.h,
            margin: EdgeInsets.only(
              left: 16.w,
              top: 16.h,
              bottom: 16.h,
            ),
            child: Image.asset(placeImage, fit: BoxFit.scaleDown),
          ),

          /// Make Space
          SizedBox(width: 24.w),

          Container(
            width: 200.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  placeName,
                  style: VStyles.h5Bold(context),
                  overflow: TextOverflow.ellipsis,
                ),

                /// Make Space
                SizedBox(height: 8.h),

                Text(
                  placeDesc,
                  style: VStyles.bodyMediumMedium(context).copyWith(
                    color: VColors.greyScale700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          const Spacer(),

          InkWellWidget(
            onTap: onTap,
            child: SvgPicture.asset(VImages.savedIconSelected),
          ),

          /// Make Space
          SizedBox(width: 20.h),
        ],
      ),
    );
  }
}
