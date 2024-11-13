import 'package:valetparking_user/features/auth/presentation/widgets/signup/fill_your_profile_form_widget.dart';
import 'package:valetparking_user/utils/constants/exports.dart';

class FillYourProfileScreen extends StatelessWidget {
  const FillYourProfileScreen({super.key});

  // final String phoneNumber;

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
                AppLocalizations.of(context)!.translate('fillYourAccount')!,
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
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: 24.h),

                const FillYourProfileFormWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}