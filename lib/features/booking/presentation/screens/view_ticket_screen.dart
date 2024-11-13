import 'package:url_launcher/url_launcher.dart';
import 'package:valetparking_user/features/booking/managers/booking_cubit.dart';
import 'package:valetparking_user/utils/constants/exports.dart';

class ViewTicketScreen extends StatefulWidget {
  const ViewTicketScreen({super.key, required this.orderId});

  final String orderId;

  @override
  State<ViewTicketScreen> createState() => _ViewTicketScreenState();
}

class _ViewTicketScreenState extends State<ViewTicketScreen> {

  @override
  void initState() {
    BookingCubit.get(context).getSpecificFunction(status: 'ongoing', orderId: widget.orderId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<BookingCubit, BookingState>(
        listener: (context, state) {},
        builder: (context, state) {
          var getSpecificOrderCubit = BookingCubit.get(context);

          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  elevation: 0,
                  backgroundColor: VColors.whiteColor,
                  title: Padding(
                    padding: EdgeInsets.only(right: 24.w),
                    child: Text(
                      'Parking Ticket',
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
                child: getSpecificOrderCubit.getSpecificOrderModel.garage ==
                        null
                    ? LoadingWidget(iconColor: VColors.primaryColor500)
                    : Column(
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
                                  width: VDeviceUtils.getScreenWidth(context) /
                                      1.6,
                                  child: Column(
                                    children: [
                                      /// Make Size
                                      SizedBox(height: 21.h),

                                      Text(
                                        'Scan this on the scanner machine when you are in the parking lot',
                                        style: VStyles.bodyMediumMedium(context),
                                        textAlign: TextAlign.center,
                                      ),

                                      /// Make Size
                                      SizedBox(height: 5.h),

                                      /// BarCode
                                      Padding(
                                        padding: EdgeInsets.all(16.sp),
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: getSpecificOrderCubit
                                                      .getSpecificOrderModel
                                                      .qrCode !=
                                                  null
                                              ? Image.memory(
                                                  base64Decode(
                                                    getSpecificOrderCubit
                                                        .getSpecificOrderModel
                                                        .qrCode!
                                                        .split(',')[1],
                                                  ),
                                                  fit: BoxFit.cover,
                                            // width: double.infinity,
                                                )
                                              : Lottie.asset(
                                                  VImages.qrCodeLoadingLottie),
                                        ),
                                      ),

                                      /// Make Size
                                      SizedBox(height: 36.h),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Name',
                                                  style: VStyles
                                                      .bodyMediumRegular
                                                      (context).copyWith(
                                                    color: VColors.greyScale600,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Text(
                                                  getSpecificOrderCubit.getSpecificOrderModel.user!.name!,
                                                  style: VStyles.bodyLargeBold(context),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),

                                                /// Make Size
                                                SizedBox(height: 20.h),

                                                Text(
                                                  'Parking Area',
                                                  style: VStyles
                                                      .bodyMediumRegular
                                                      (context).copyWith(
                                                    color: VColors.greyScale600,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Text(
                                                  getSpecificOrderCubit
                                                      .getSpecificOrderModel
                                                      .garage!
                                                      .grageDescription
                                                      .toString(),
                                                  style: VStyles.bodyLargeBold(context),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),

                                                /// Make Size
                                                SizedBox(height: 20.h),

                                                Text(
                                                  'Duration',
                                                  style: VStyles
                                                      .bodyMediumRegular
                                                      (context).copyWith(
                                                    color: VColors.greyScale600,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Text(
                                                  '${getSpecificOrderCubit.getSpecificOrderModel.duration} hours',
                                                  style: VStyles.bodyLargeBold(context),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),

                                                /// Make Size
                                                SizedBox(height: 20.h),
                                              ],
                                            ),
                                          ),
                                          Expanded(child: SizedBox()),
                                          Expanded(
                                            flex: 5,
                                            child: Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Date',
                                                    style:
                                                        VStyles.bodyLargeBold(context),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    '${getSpecificOrderCubit.getSpecificOrderModel.timeRange!.start} - ${getSpecificOrderCubit.getSpecificOrderModel.timeRange!.end}',
                                                    style:
                                                        VStyles.bodyLargeBold(context),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),

                                                  /// Make Size
                                                  SizedBox(height: 20.h),

                                                  Text(
                                                    'Parking Spot',
                                                    style: VStyles
                                                        .bodyMediumRegular
                                                        (context).copyWith(
                                                      color:
                                                          VColors.greyScale600,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Text(
                                                    '1st Floor (A05)',
                                                    style:
                                                        VStyles.bodyLargeBold(context),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),

                                                  /// Make Size
                                                  SizedBox(height: 20.h),

                                                  Text(
                                                    'Date',
                                                    style: VStyles
                                                        .bodyMediumRegular
                                                        (context).copyWith(
                                                      color:
                                                          VColors.greyScale600,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Text(
                                                    getSpecificOrderCubit
                                                        .getSpecificOrderModel
                                                        .toString(),
                                                    style:
                                                        VStyles.bodyLargeBold(context),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),

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
                              'Navigate to Parking Lot',
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
                                  "https://www.google.com/maps/search/?api=1&query=${getSpecificOrderCubit.getSpecificOrderModel.garage!.lat},${getSpecificOrderCubit.getSpecificOrderModel.garage!.lng}";

                              /// Go to google maps
                              if (await canLaunch(googleMapsUrl)) {
                                await launch(googleMapsUrl);

                                /// Launch Google Maps
                              } else {
                                throw 'Could not open Google Maps.';
                              }
                            },
                          ),
                        ],
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
