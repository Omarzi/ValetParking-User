import 'package:valetparking_user/utils/constants/exports.dart';

class ChangeLanguageWidget extends StatefulWidget {
  const ChangeLanguageWidget({super.key});

  @override
  State<ChangeLanguageWidget> createState() => _ChangeLanguageWidgetState();
}

class _ChangeLanguageWidgetState extends State<ChangeLanguageWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: VDeviceUtils.getScreenHeight(context) / 3.6,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(40.r), topRight: Radius.circular(40.r))),
      child: Column(
        children: [
          /// Make Space
          SizedBox(height: 35.h),

          SizedBox(width: double.infinity, height: VDeviceUtils.getScreenHeight(context) / 26, child: Text(AppLocalizations.of(context)!.translate('changeLanguage')!, style: VStyles.h4Bold(context).copyWith(color: VColors.alertsAndStatusError), textAlign: TextAlign.center)),

          /// Make Space
          SizedBox(height: 24.h),

          Container(width: double.infinity, height: 1.w, color: VColors.greyScale200,),

          /// Make Space
          SizedBox(height: 24.h),

          SizedBox(width: double.infinity, height: VDeviceUtils.getScreenHeight(context) / 26, child: Text(AppLocalizations.of(context)!.translate('choiceFromTwoLanguages')!, style: VStyles.h5Bold(context).copyWith(color: VColors.greyScale800), textAlign: TextAlign.center)),

          /// Make Space
          SizedBox(height: 12.h),

          InkWellWidget(
            onTap: () {
              VCacheHelper.putString(key: CacheKeys.lang, value: 'ar');
              BlocProvider.of<LocaleCubit>(context).toArabic();
              context.pop();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: VDeviceUtils.getScreenHeight(context) / 26, child: Text(AppLocalizations.of(context)!.translate('arabic')!, style: VStyles.h5Bold(context).copyWith(color: AppLocalizations.of(context)!.isEnLocale ? VColors.greyScale800 : VColors.primaryColor500))),
                SvgPicture.asset(
                  VImages.checkIcon,
                  height: 18.h,
                  colorFilter: ColorFilter.mode(
                    AppLocalizations.of(context)!.isEnLocale ? VColors.greyScale900 : VColors.primaryColor500,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),

          /// Make Space
          SizedBox(height: 12.h),

          InkWellWidget(
            onTap: () {
              VCacheHelper.putString(key: CacheKeys.lang, value: 'en');
              BlocProvider.of<LocaleCubit>(context).toEnglish();
              context.pop();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: VDeviceUtils.getScreenHeight(context) / 26, child: Text(AppLocalizations.of(context)!.translate('english')!, style: VStyles.h5Bold(context).copyWith(color: AppLocalizations.of(context)!.isEnLocale ? VColors.primaryColor500 : VColors.greyScale800))),
                SvgPicture.asset(
                  VImages.checkIcon,
                  height: 18.h,
                  colorFilter: ColorFilter.mode(
                    AppLocalizations.of(context)!.isEnLocale ? VColors.primaryColor500 : VColors.greyScale900,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
