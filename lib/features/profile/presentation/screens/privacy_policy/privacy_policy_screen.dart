import 'package:valetparking_user/utils/constants/exports.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
              title: Padding(
                padding: EdgeInsets.only(right: 24.w),
                child: Text(
                  AppLocalizations.of(context)!.translate('privacyPolicy')!,
                  style: VStyles.h4Bold(context),
                ),
              ),
              leading: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back_outlined),
              ),
              floating: true,
              pinned: true,
              flexibleSpace: Container(
                color: VColors.whiteColor,
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: 24.w, right: 24.w, top: 24.h, bottom: 48.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('1. Types of Data We Collect', style: VStyles.h5Bold(context)),

                /// Make Space
                SizedBox(height: 24.h),

                Text(VConstants.loremText1, style: VStyles.bodyMediumRegular(context)),

                /// Make Space
                SizedBox(height: 24.h),

                Text('2. Use of Your Personal Data', style: VStyles.h5Bold(context)),

                /// Make Space
                SizedBox(height: 24.h),

                Text(VConstants.loremText2, style: VStyles.bodyMediumRegular(context)),

                /// Make Space
                SizedBox(height: 24.h),

                Text('3. Disclosure of Your Personal Data',
                    style: VStyles.h5Bold(context)),

                /// Make Space
                SizedBox(height: 24.h),

                Text(VConstants.loremText3, style: VStyles.bodyMediumRegular(context)),

                /// Make Space
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
