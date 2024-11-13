
import 'package:valetparking_user/features/booking/managers/booking_cubit.dart';
import 'package:valetparking_user/features/home/managers/home_cubit.dart';
import 'package:valetparking_user/features/profile/manager/profile_cubit.dart';
import 'package:valetparking_user/features/saved/managers/saved_cubit.dart';
import 'package:valetparking_user/features/saved/presentation/screen/saved_screen.dart';
import 'package:valetparking_user/utils/constants/exports.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key, required this.index});

  final int index;

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int currentIndex = 0;

  @override
  void initState() {
    HomeCubit.get(context).getAllGaragesFunction();
    SavedCubit.get(context).getAllUserSavedGaragesFunction();
    BookingCubit.get(context).getAllOrdersFunction(status: 'ongoing');
    ProfileCubit.get(context).getProfileDataFunction();
    ProfileCubit.get(context).getUserWalletFunction();
    super.initState();
    currentIndex = widget.index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List tabs = [
      const HomeScreen(),
      const SavedScreen(),
      const BookingScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: VColors.whiteColor,
      // body: NestedScrollView(
      //   physics: currentIndex == 1
      //       ? const NeverScrollableScrollPhysics()
      //       : const BouncingScrollPhysics(),
      //   headerSliverBuilder: (context, innerBoxIsScrolled) {
      //     return <Widget> [
      //       SliverAppBar(
      //         elevation: 0,
      //         backgroundColor: VColors.whiteColor,
      //         title: Padding(
      //           padding: EdgeInsets.only(right: 24.w),
      //           child: Text(
      //             currentIndex == 1
      //                 ? "My Bookmark"
      //                 : currentIndex == 2
      //                 ? "My Parking"
      //                 : currentIndex == 3
      //                 ? 'Profile'
      //                 : '',
      //             style: VStyles.h4Bold,
      //           ),
      //         ),
      //         leading: currentIndex == 1 || currentIndex == 2 || currentIndex == 3
      //             ? Padding(
      //           padding: EdgeInsets.only(left: 24.w),
      //           child: SvgPicture.asset(VImages.appBarIcon, width: 32.w),
      //         )
      //             : null,
      //         floating: true,
      //         pinned: true,
      //         actions: [
      //           GestureDetector(
      //             onTap: () {},
      //             child: Padding(
      //               padding: EdgeInsets.only(right: 24.w),
      //               child: SvgPicture.asset(VImages.moreIcon),
      //             ),
      //           ),
      //         ],
      //         // snap: false,
      //         flexibleSpace: Container(
      //           color: VColors.whiteColor,
      //         ),
      //       ),
      //     ];
      //   },
      //   body: AnimatedSwitcher(
      //     duration: const Duration(milliseconds: 400),
      //     transitionBuilder: (Widget child, Animation<double> animation) {
      //       return FadeTransition(
      //         opacity: animation,
      //         child: child,
      //       );
      //     },
      //     child: tabs[currentIndex],
      //   ),
      // ),
      body: currentIndex == 0
          ? AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: tabs[currentIndex],
      )
          : NestedScrollView(
        physics: currentIndex == 1
            ? const NeverScrollableScrollPhysics()
            : const BouncingScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              elevation: 0,
              backgroundColor: VColors.whiteColor,
              title: Padding(
                padding: EdgeInsets.only(right: 24.w),
                child: Text(
                  currentIndex == 1
                      ? AppLocalizations.of(context)!.translate('myBookmark')!
                      : currentIndex == 2
                      ? AppLocalizations.of(context)!.translate('myParking')!
                      : currentIndex == 3
                      ? AppLocalizations.of(context)!.translate('profile')!
                      : '',
                  style: VStyles.h4Bold(context),
                ),
              ),
              leading: currentIndex == 1 ||
                  currentIndex == 2 ||
                  currentIndex == 3
                  ? Padding(
                padding: EdgeInsets.only(left: 24.w),
                child: SvgPicture.asset(VImages.appBarIcon, width: 32.w),
              )
                  : null,
              floating: true,
              pinned: true,
              actions: [
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.only(right: 24.w),
                    child: SvgPicture.asset(VImages.moreIcon),
                  ),
                ),
              ],
              flexibleSpace: Container(
                color: VColors.whiteColor,
              ),
            ),
          ];
        },
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: tabs[currentIndex],
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        height: 90.h,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16.r),
            topLeft: Radius.circular(16.r),
          ),
          child: Theme(
            data: ThemeData(splashColor: Colors.transparent),
            child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: VColors.greyScale50,
              iconSize: 24.sp,
              type: BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              onTap: (index) => setState(() => currentIndex = index),
              enableFeedback: false,
              selectedItemColor: VColors.primaryColor500,
              unselectedItemColor: VColors.greyScale500,
              selectedLabelStyle: VStyles.bodyXSmallBold(context)
                  .copyWith(color: VColors.primaryColor500),
              unselectedLabelStyle: VStyles.bodyXSmallMedium(context)
                  .copyWith(color: VColors.greyScale500),
              showUnselectedLabels: true,
              items: [
                BottomNavigationBarItem(
                  icon: SizedBox(
                    width: 57.6.w,
                    height: 38.h,
                    child: currentIndex == 0
                        ? SvgPicture.asset(VImages.homeIconSelected,
                            colorFilter: ColorFilter.mode(
                                VColors.primaryColor500, BlendMode.srcIn),
                            fit: BoxFit.scaleDown)
                        : SvgPicture.asset(VImages.homeIconNotSelected,
                            colorFilter: ColorFilter.mode(
                                VColors.greyScale500, BlendMode.srcIn),
                            fit: BoxFit.scaleDown),
                  ),
                  label: AppLocalizations.of(context)!.translate('home')!,
                ),
                BottomNavigationBarItem(
                  icon: SizedBox(
                    width: 57.6.w,
                    height: 38.h,
                    child: currentIndex == 1
                        ? SvgPicture.asset(VImages.savedIconSelected,
                            colorFilter: ColorFilter.mode(
                                VColors.primaryColor500, BlendMode.srcIn),
                            fit: BoxFit.scaleDown)
                        : SvgPicture.asset(VImages.savedIconNotSelected,
                            colorFilter: ColorFilter.mode(
                                VColors.greyScale500, BlendMode.srcIn),
                            fit: BoxFit.scaleDown),
                  ),
                  label: AppLocalizations.of(context)!.translate('saved')!,
                ),
                BottomNavigationBarItem(
                  icon: SizedBox(
                    width: 57.6.w,
                    height: 38.h,
                    child: currentIndex == 2
                        ? SvgPicture.asset(VImages.bookingIconSelected,
                            colorFilter: ColorFilter.mode(
                                VColors.primaryColor500, BlendMode.srcIn),
                            fit: BoxFit.scaleDown)
                        : SvgPicture.asset(VImages.bookingIconNotSelected,
                            colorFilter: ColorFilter.mode(
                                VColors.greyScale500, BlendMode.srcIn),
                            fit: BoxFit.scaleDown),
                  ),
                  label: AppLocalizations.of(context)!.translate('booking')!,
                ),
                BottomNavigationBarItem(
                  icon: SizedBox(
                    width: 57.6.w,
                    height: 38.h,
                    child: currentIndex == 3
                        ? SvgPicture.asset(VImages.profileIconSelected,
                            colorFilter: ColorFilter.mode(
                                VColors.primaryColor500, BlendMode.srcIn),
                            fit: BoxFit.scaleDown)
                        : SvgPicture.asset(VImages.profileIconNotSelected,
                            colorFilter: ColorFilter.mode(
                                VColors.greyScale500, BlendMode.srcIn),
                            fit: BoxFit.scaleDown),
                  ),
                  label: AppLocalizations.of(context)!.translate('profile')!,
                ),
              ],
            ),
          ),
        ),
      ),
      // ),
    );
  }
}
