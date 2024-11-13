import 'package:valetparking_user/features/home/models/get_all_garages_model.dart';
import 'package:valetparking_user/features/saved/presentation/screen/saved_screen.dart';
import 'package:valetparking_user/utils/constants/exports.dart';
import 'package:intl/intl.dart';

class PlaceDetailsScreens extends StatefulWidget {
  const PlaceDetailsScreens({super.key, required this.garagesItem});

  final GarageDetails garagesItem;

  @override
  State<PlaceDetailsScreens> createState() => _PlaceDetailsScreensState();
}

class _PlaceDetailsScreensState extends State<PlaceDetailsScreens> {
  int currentIndex = 0;

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
                  AppLocalizations.of(context)!.translate('parkingDetails')!,
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
        body: Container(
          padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 24.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Place Banner
              Stack(
                children: [
                  /// Banner
                  CarouselSlider(
                    options: CarouselOptions(
                      height: VDeviceUtils.getScreenHeight(context) / 6,
                      autoPlay: true,
                      viewportFraction: 1,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) =>
                          setState(() => currentIndex = index),
                    ),
                    items: VConstants.bannerImages
                        .map(
                          (item) => Container(
                            decoration: BoxDecoration(
                              boxShadow: [AppBoxShadows.cardShadowTwo],
                              image: DecorationImage(
                                image: AssetImage(item),
                                fit: BoxFit.fill,
                              ),
                              borderRadius: BorderRadius.circular(32.r),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  // Positioned dots indicator
                  Positioned(
                    bottom: 12.h,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        VConstants.bannerImages.length,
                        (index) => VDeviceUtils.buildDotWidget(
                          index,
                          currentIndex,
                          context,
                          BoxDecoration(
                            color: currentIndex == index
                                ? VColors.primaryColor500
                                : VColors.whiteColor,
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              /// Make Space
              SizedBox(height: 24.h),

              /// Place Name & Place Location
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: VDeviceUtils.getScreenWidth(context) / 1.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            widget.garagesItem.gragename != null
                                ? '${widget.garagesItem.gragename![0].toUpperCase()}${widget.garagesItem.gragename!.substring(1).toLowerCase()}'
                                : '',
                            // widget.garagesItem.gragename ?? '...',
                            style: VStyles.h4Bold(context)),
                        Text(
                          "${widget.garagesItem.lat!}, ${widget.garagesItem.lng}",
                          style: VStyles.bodyLargeMedium(context).copyWith(
                            color: VColors.greyScale700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      FloatingSnackBar.show(
                        context: context,
                        message: widget.garagesItem.isSaved!
                            ? AppLocalizations.of(context)!.translate(
                                'youHaveToExitThePageToRemoveItFromYourFavorites')!
                            : AppLocalizations.of(context)!.translate(
                                'youHaveToExitThePageToAddItToYourFavorites')!,
                        textColor: Colors.white,
                        duration: const Duration(milliseconds: 4000),
                        backgroundColor: VColors.warning,
                      );
                    },
                    child: SvgPicture.asset(
                      widget.garagesItem.isSaved!
                          ? VImages.savedIconSelected
                          : VImages.savedIconNotSelected,
                      height: 28.h,
                      width: 28.w,
                    ),
                  ),
                ],
              ),

              /// Make Space
              SizedBox(height: 24.h),

              Row(
                children: [
                  Text(AppLocalizations.of(context)!.translate('startIn')!,
                      style: VStyles.h5Bold(context)),
                  CircledWidget(
                    widget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(VImages.clockIcon),
                        SizedBox(width: 8.w),
                        Text(
                          widget.garagesItem.openDate != null
                              ? DateFormat.jm().format(
                                  DateFormat("yyyy-MM-dd h:mm a")
                                      .parse(widget.garagesItem.openDate!))
                              : 'Invalid date',
                          // '8 AM - 10 PM',
                          style: VStyles.bodyLargeSemiBold(context).copyWith(
                            color: VColors.primaryColor500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              /// Make Space
              SizedBox(height: 24.h),

              Row(
                children: [
                  Text('${AppLocalizations.of(context)!.translate('endIn')}', style: VStyles.h5Bold(context)),
                  CircledWidget(
                    widget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(VImages.clockIcon),
                        SizedBox(width: 8.w),
                        Text(
                          widget.garagesItem.openDate != null
                              ? DateFormat.jm().format(
                                  DateFormat("yyyy-MM-dd h:mm a")
                                      .parse(widget.garagesItem.endDate!))
                              : 'Invalid date',
                          // '8 AM - 10 PM',
                          style: VStyles.bodyLargeSemiBold(context).copyWith(
                            color: VColors.primaryColor500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              //
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [

              // CircledWidget(
              //   widget: Row(
              //     children: [
              //       Text(
              //         'Valet',
              //         style: VStyles.bodyLargeSemiBold.copyWith(
              //           color: VColors.primaryColor500,
              //         ),
              //       ),
              //     ],
              //   ),
              // )
              // ],
              // ),

              /// Make Space
              SizedBox(height: 24.h),

              Text(AppLocalizations.of(context)!.translate('description')!, style: VStyles.h5Bold(context)),

              /// Make Space
              SizedBox(height: 16.h),

              ExpandableTextWidget(
                text: widget.garagesItem.grageDescription ?? '...',
                // "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua..., Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua..., Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua..., Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua..., Lorem ipsum dolor sit amet, consectetur adipiscing.",
              ),

              /// Make Space
              SizedBox(height: 24.h),

              Container(
                color: VColors.blueBg,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Column(
                  children: [
                    Text(
                      '\$${widget.garagesItem.gragePricePerHoure}',
                      // '\$2.00',
                      style: VStyles.h4Bold(context).copyWith(
                        color: VColors.primaryColor500,
                      ),
                    ),

                    /// Make Space
                    SizedBox(height: 8.h),
                    Text(
                      AppLocalizations.of(context)!.translate('perHour')!,
                      style: VStyles.bodySmallMedium(context).copyWith(
                        color: VColors.greyScale600,
                      ),
                    ),
                  ],
                ),
              ),

              /// Make Space
              SizedBox(height: 40.h),

              /// Cancel & Book Parking
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: MainButtonWidget(
                      centerWidgetInButton: Text(
                        AppLocalizations.of(context)!.translate('cancel')!,
                        style: VStyles.bodyLargeBold(context).copyWith(
                          color: VColors.primaryColor500,
                        ),
                      ),
                      margin: EdgeInsets.zero,
                      buttonColor: VColors.primaryColor100,
                      boxShadow: const [],
                      onTap: () => context.pop(),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: MainButtonWidget(
                      centerWidgetInButton: Text(
                        AppLocalizations.of(context)!.translate('BookParking')!,
                        style: VStyles.bodyLargeBold(context).copyWith(
                          color: VColors.whiteColor,
                        ),
                      ),
                      margin: EdgeInsets.zero,
                      buttonColor: VColors.primaryColor500,
                      boxShadow: [AppBoxShadows.buttonShadowOne],
                      onTap: () {
                        context.pushNamed(VRoutesName.choiceYourPassenger,
                            arguments: {
                              'garageId':
                                  widget.garagesItem.garageId.toString(),
                              'garageName':
                                  widget.garagesItem.gragename.toString(),
                              'pricePerHour': widget
                                  .garagesItem.gragePricePerHoure
                                  .toString(),
                              'lat': widget.garagesItem.lat.toString(),
                              'lng': widget.garagesItem.lng.toString(),
                              // 'openDate': widget.garagesItem.openDate.toString(),
                              // 'endDate': widget.garagesItem.endDate.toString(),
                            });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
