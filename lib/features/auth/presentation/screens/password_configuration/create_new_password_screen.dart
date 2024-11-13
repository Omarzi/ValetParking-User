import 'package:valetparking_user/features/auth/managers/auth_cubit.dart';
import 'package:valetparking_user/features/auth/presentation/widgets/password_configuration/create_new_password_form_widget.dart';
import 'package:valetparking_user/utils/constants/exports.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  const CreateNewPasswordScreen({super.key, required this.data});

  final Map data;

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
              title: Text(
                "Create New Password",
                style: VStyles.h4Bold(context).copyWith(fontSize: 21.sp),
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 46.w),
                  child: Center(
                    child: SvgPicture.asset(VImages.createNewPasswordLogo),
                  ),
                ),
                CreateNewPasswordFormWidget(data: data),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
