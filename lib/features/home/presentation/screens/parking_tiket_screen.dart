import 'package:url_launcher/url_launcher.dart';
import 'package:valetparking_user/features/home/models/make_order_response_model.dart';
import 'package:valetparking_user/utils/constants/exports.dart';

class ParkingTicketScreen extends StatefulWidget {
  const ParkingTicketScreen({super.key, required this.makeOrderResponseModel});

  final MakeOrderResponseModel makeOrderResponseModel;

  @override
  State<ParkingTicketScreen> createState() => _ParkingTicketScreenState();
}

class _ParkingTicketScreenState extends State<ParkingTicketScreen> {
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
                  AppLocalizations.of(context)!.translate('parkingTicket')!,
                  style: VStyles.h4Bold(context),
                ),
              ),
              leading: null,
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
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 28.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.r),
                    image: const DecorationImage(
                      image: AssetImage(VImages.bgOfTicketImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: VDeviceUtils.getScreenWidth(context) / 1.6,
                        child: Column(
                          children: [
                            /// Make Size
                            SizedBox(height: 21.h),

                            Text(
                              AppLocalizations.of(context)!.translate('scanThisOnTheScannerMachine')!,
                              style: VStyles.bodyMediumMedium(context),
                              textAlign: TextAlign.center,
                            ),

                            /// Make Size
                            SizedBox(height: 5.h),

                            /// BarCode
                            Padding(
                              padding: EdgeInsets.all(16.sp),
                              child: GestureDetector(
                                onTap: () {
                                  logSuccess(widget
                                      .makeOrderResponseModel.order!.qrCode
                                      .toString());
                                },
                                child: widget.makeOrderResponseModel.order!
                                            .qrCode !=
                                        null
                                    ? Image.memory(
                                        base64Decode(
                                          widget.makeOrderResponseModel.order!
                                              .qrCode!
                                              .split(',')[1],
                                        ),
                                        fit: BoxFit.cover,
                                      )
                                    : Lottie.asset(VImages.qrCodeLoadingLottie),
                              ),
                            ),

                            /// Make Size
                            SizedBox(height: 36.h),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.translate('name')!,
                                        style:
                                            VStyles.bodyMediumRegular(context).copyWith(
                                          color: VColors.greyScale600,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        widget.makeOrderResponseModel.order!
                                                    .garage!.gragename !=
                                                null
                                            ? '${widget.makeOrderResponseModel.order!.garage!.gragename![0].toUpperCase()}${widget.makeOrderResponseModel.order!.garage!.gragename!.substring(1).toLowerCase()}'
                                            : '',
                                        style: VStyles.bodyLargeBold(context),
                                        overflow: TextOverflow.ellipsis,
                                      ),

                                      /// Make Size
                                      SizedBox(height: 20.h),

                                      Text(
                                        AppLocalizations.of(context)!.translate('parkingArea')!,
                                        style:
                                            VStyles.bodyMediumRegular(context).copyWith(
                                          color: VColors.greyScale600,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        widget.makeOrderResponseModel.order!
                                            .garage!.grageDescription
                                            .toString(),
                                        style: VStyles.bodyLargeBold(context),
                                        overflow: TextOverflow.ellipsis,
                                      ),

                                      /// Make Size
                                      SizedBox(height: 20.h),

                                      Text(
                                        AppLocalizations.of(context)!.translate('duration')!,
                                        style:
                                            VStyles.bodyMediumRegular(context).copyWith(
                                          color: VColors.greyScale600,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        '${widget.makeOrderResponseModel.order!.duration} hours',
                                        style: VStyles.bodyLargeBold(context),
                                        overflow: TextOverflow.ellipsis,
                                      ),

                                      /// Make Size
                                      SizedBox(height: 20.h),
                                    ],
                                  ),
                                ),
                                const Expanded(child: SizedBox()),
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!.translate('date')!,
                                          style: VStyles.bodyLargeBold(context),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          '${widget.makeOrderResponseModel.order!.timeRange!.start} - ${widget.makeOrderResponseModel.order!.timeRange!.end}',
                                          style: VStyles.bodyLargeBold(context),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        // Text(
                                        //   'Vehicle',
                                        //   style: VStyles.bodyMediumRegular
                                        //       .copyWith(
                                        //     color: VColors.greyScale600,
                                        //     overflow: TextOverflow.ellipsis,
                                        //   ),
                                        // ),
                                        // Text(
                                        //   widget.makeOrderResponseModel.order!
                                        //               .typeOfCar ==
                                        //           '1'
                                        //       ? '💸 Cash'
                                        //       : widget.makeOrderResponseModel
                                        //                   .order!.typeOfCar ==
                                        //               '2'
                                        //           ? '🎫 VISA'
                                        //           :  '💳 Wallet',
                                        //   style: VStyles.bodyLargeBold,
                                        //   overflow: TextOverflow.ellipsis,
                                        // ),

                                        /// Make Size
                                        SizedBox(height: 20.h),

                                        Text(
                                          AppLocalizations.of(context)!.translate('parkingSpot')!,
                                          style: VStyles.bodyMediumRegular(context)
                                              .copyWith(
                                            color: VColors.greyScale600,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        // Text(
                                        //   '1st Floor (A05)',
                                        //   style: VStyles.bodyLargeBold,
                                        //   overflow: TextOverflow.ellipsis,
                                        // ),
                                        //
                                        // /// Make Size
                                        // SizedBox(height: 20.h),

                                        Text(
                                          AppLocalizations.of(context)!.translate('date')!,
                                          style: VStyles.bodyMediumRegular(context)
                                              .copyWith(
                                            color: VColors.greyScale600,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                          widget.makeOrderResponseModel.order!
                                              .date
                                              .toString(),
                                          style: VStyles.bodyLargeBold(context),
                                          overflow: TextOverflow.ellipsis,
                                        ),

                                        // /// Make Size
                                        // SizedBox(height: 20.h),
                                        // widget.makeOrderResponseModel.order!
                                        //             .user!.userData ==
                                        //         null
                                        //     ? Text(
                                        //         '',
                                        //         style: VStyles.bodyMediumRegular
                                        //             .copyWith(
                                        //           color: VColors.greyScale600,
                                        //           overflow:
                                        //               TextOverflow.ellipsis,
                                        //         ),
                                        //         overflow: TextOverflow.ellipsis,
                                        //       )
                                        //     : Text(
                                        //         'Phone',
                                        //         style: VStyles.bodyMediumRegular
                                        //             .copyWith(
                                        //           color: VColors.greyScale600,
                                        //           overflow:
                                        //               TextOverflow.ellipsis,
                                        //         ),
                                        //         overflow: TextOverflow.ellipsis,
                                        //       ),
                                        // widget.makeOrderResponseModel.order!
                                        //             .user!.userData ==
                                        //         null
                                        //     ? Text(
                                        //         '',
                                        //         style: VStyles.bodyLargeBold,
                                        //         overflow: TextOverflow.ellipsis,
                                        //       )
                                        //     : Text(
                                        //         widget
                                        //                     .makeOrderResponseModel
                                        //                     .order!
                                        //                     .user!
                                        //                     .userData ==
                                        //                 null
                                        //             ? '..'
                                        //             : widget
                                        //                 .makeOrderResponseModel
                                        //                 .order!
                                        //                 .user!
                                        //                 .userData!
                                        //                 .phone
                                        //                 .toString(),
                                        //         style: VStyles.bodyLargeBold,
                                        //         overflow: TextOverflow.ellipsis,
                                        //       ),

                                        /// Make Size
                                        SizedBox(height: 30.h),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                /// Make Size
                SizedBox(height: 26.h),

                MainButtonWidget(
                  centerWidgetInButton: Text(
                    AppLocalizations.of(context)!.translate('navigateToParkingLot')!,
                    style: VStyles.bodyLargeBold(context).copyWith(
                      color: VColors.whiteColor,
                    ),
                  ),
                  margin: EdgeInsets.zero,
                  buttonColor: VColors.primaryColor500,
                  boxShadow: [AppBoxShadows.buttonShadowOne],
                  onTap: () async {
                    /// Create the Google Maps URL
                    String googleMapsUrl =
                        "https://www.google.com/maps/search/?api=1&query=${widget.makeOrderResponseModel.order!.garage!.lat},${widget.makeOrderResponseModel.order!.garage!.lng}";

                    /// Go to google maps
                    if (await canLaunch(googleMapsUrl)) {
                      await launch(googleMapsUrl);

                      /// Launch Google Maps
                    } else {
                      throw 'Could not open Google Maps.';
                    }
                  },
                ),

                /// Make Size
                SizedBox(height: 26.h),

                MainButtonWidget(
                  centerWidgetInButton: Text(
                    AppLocalizations.of(context)!.translate('goToHome')!,
                    style: VStyles.bodyLargeBold(context).copyWith(
                      color: VColors.greyScale900,
                    ),
                  ),
                  margin: EdgeInsets.zero,
                  buttonColor: VColors.primaryColor100,
                  boxShadow: const [],
                  onTap: () {
                    context.pushNamedAndRemoveUntil(
                      VRoutesName.navigationMenuRoute,
                      arguments: 0,
                      predicate: (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
