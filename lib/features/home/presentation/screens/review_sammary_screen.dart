import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:valetparking_user/features/home/managers/home_cubit.dart';
import 'package:valetparking_user/utils/constants/api_constants.dart';
import 'package:valetparking_user/utils/constants/exports.dart';

class ReviewSummaryScreen extends StatefulWidget {
  const ReviewSummaryScreen({super.key, required this.data});

  final Map data;

  @override
  State<ReviewSummaryScreen> createState() => _ReviewSummaryScreenState();
}

class _ReviewSummaryScreenState extends State<ReviewSummaryScreen> {
  Future<String> getPlaceName(double lat, double lng) async {
    const apiKey = 'AIzaSyD03tmmafIJahLSvVG3xHQQa_7NDrEZ1i8';
    Dio dio = Dio();

    try {
      final response = await dio.get(
        'https://maps.googleapis.com/maps/api/geocode/json',
        queryParameters: {
          'latlng': '$lat,$lng',
          'key': apiKey,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['status'] == 'OK') {
          final results = data['results'];
          if (results.isNotEmpty) {
            return results[0]['formatted_address']; // Return the first result
          } else {
            return 'No address found';
          }
        } else {
          return 'Error: ${data['status']}';
        }
      } else {
        return 'Failed to fetch address';
      }
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }

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
                  AppLocalizations.of(context)!.translate('reviewSummary')!,
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
        body: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is MakeNewOrderSuccessState) {
              context.pushNamedAndRemoveUntil(
                VRoutesName.parkingTicketRoute,
                arguments: state.makeOrderResponseModel,
                predicate: (route) => false,
              );
              FloatingSnackBar.show(
                context: context,
                message: state.message!,
                textColor: Colors.white,
                duration: const Duration(milliseconds: 4000),
                backgroundColor: VColors.success,
              );
            } else if (state is MakeNewOrderErrorState) {
              FloatingSnackBar.show(
                context: context,
                message: state.message!,
                textColor: Colors.white,
                duration: const Duration(milliseconds: 4000),
                backgroundColor: VColors.error,
              );
            }
          },
          builder: (context, state) {
            var makeOrderCubit = HomeCubit.get(context);
            Duration duration = calculateDuration((widget.data['startTime']), widget.data['endTime']);
            String formattedDuration = formatDuration(duration);

            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 24.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 24.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [AppBoxShadows.cardShadowTwo],
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Column(
                        children: [
                          /// Parking Name
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width:
                                    VDeviceUtils.getScreenWidth(context) / 3.8,
                                child: Text(
                                  AppLocalizations.of(context)!.translate('parkingArea')!,
                                  style: VStyles.bodyMediumSemiBold(context).copyWith(
                                    color: VColors.greyScale700,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width:
                                    VDeviceUtils.getScreenWidth(context) / 2.5,
                                child: Text(
                                  widget.data['garageName'] != null
                                      ? '${widget.data['garageName']![0].toUpperCase()}${widget.data['garageName']!.substring(1).toLowerCase()}'
                                      : '',
                                  // 'Parking Lot of San Manolia',
                                  style: VStyles.bodyLargeBold(context),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),

                          /// Make Space
                          SizedBox(height: 20.h),

                          /// Parking Address
                          GestureDetector(
                            onTap: () {
                              openMap(double.parse(widget.data['lat']),
                                  double.parse(widget.data['lng']));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: VDeviceUtils.getScreenWidth(context) /
                                      3.8,
                                  child: Text(
                                    AppLocalizations.of(context)!.translate('address')!,
                                    style: VStyles.bodyMediumSemiBold(context).copyWith(
                                      color: VColors.greyScale700,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                // SizedBox(
                                //   width:
                                //       VDeviceUtils.getScreenWidth(context) / 2.5,
                                //   child: Text(
                                //     (widget.data['lat'] + widget.data['lng'])
                                //         .toString(),
                                //     style: VStyles.bodyLargeBold,
                                //     overflow: TextOverflow.ellipsis,
                                //     textAlign: TextAlign.end,
                                //   ),
                                // ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: FutureBuilder<String>(
                                    future: getPlaceName(
                                        double.parse(widget.data['lat']),
                                        double.parse(widget.data['lng'])),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        return Text(
                                          snapshot.error != null
                                              ? 'Error: ${snapshot.error.toString()}'
                                              : 'An unexpected error occurred',
                                          style: const TextStyle(
                                            color: Colors.red,
                                            // Make error text red
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        );
                                      } else if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data!,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.end,
                                        );
                                      } else {
                                        return const Text('No address found');
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// Make Space
                          SizedBox(height: 20.h),

                          /// Vehicle
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width:
                                    VDeviceUtils.getScreenWidth(context) / 3.8,
                                child: Text(
                                  AppLocalizations.of(context)!.translate('vehicle')!,
                                  style: VStyles.bodyMediumSemiBold(context).copyWith(
                                    color: VColors.greyScale700,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width:
                                    VDeviceUtils.getScreenWidth(context) / 2.5,
                                child: Text(
                                  widget.data['typeOfCar'] == 1
                                      ? 'Small car'
                                      : widget.data['typeOfCar'] == 2
                                          ? 'Big car'
                                          : widget.data['typeOfCar'] == 3
                                              ? 'MotoCycle'
                                              : 'Bycle',
                                  style: VStyles.bodyLargeBold(context),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),

                          /// Make Space
                          SizedBox(height: 20.h),

                          /// Date
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width:
                                    VDeviceUtils.getScreenWidth(context) / 3.8,
                                child: Text(
                                  AppLocalizations.of(context)!.translate('date')!,
                                  style: VStyles.bodyMediumSemiBold(context).copyWith(
                                    color: VColors.greyScale700,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width:
                                    VDeviceUtils.getScreenWidth(context) / 2.5,
                                child: Text(
                                  widget.data['date'],
                                  style: VStyles.bodyLargeBold(context),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),

                          /// Make Space
                          SizedBox(height: 20.h),

                          /// Date
                          widget.data['duration'] == 0
                              ? const SizedBox()
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width:
                                          VDeviceUtils.getScreenWidth(context) /
                                              3.8,
                                      child: Text(
                                        AppLocalizations.of(context)!.translate('duration')!,
                                        style:
                                            VStyles.bodyMediumSemiBold(context).copyWith(
                                          color: VColors.greyScale700,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                          VDeviceUtils.getScreenWidth(context) /
                                              2.5,
                                      child: Text(
                                        formattedDuration,
                                        // '${widget.data['duration']} hours',
                                        style: VStyles.bodyLargeBold(context),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ],
                                ),

                          /// Make Space
                          widget.data['duration'] == 0
                              ? const SizedBox()
                              : SizedBox(height: 20.h),

                          /// Date
                          widget.data['startTime'] == 0 &&
                                  widget.data['endTime'] == 0
                              ? const SizedBox()
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width:
                                          VDeviceUtils.getScreenWidth(context) /
                                              3.8,
                                      child: Text(
                                        AppLocalizations.of(context)!.translate('hours')!,
                                        style:
                                            VStyles.bodyMediumSemiBold(context).copyWith(
                                          color: VColors.greyScale700,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                          VDeviceUtils.getScreenWidth(context) /
                                              2.5,
                                      child: Text(
                                        '${widget.data['startTime']} - ${widget.data['endTime']}',
                                        style: VStyles.bodyLargeBold(context),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),

                    /// Make Space
                    widget.data['startTime'] == 0 && widget.data['endTime'] == 0
                        ? const SizedBox()
                        : SizedBox(height: 24.h),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 24.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [AppBoxShadows.cardShadowTwo],
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Column(
                        children: [
                          /// Amount
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width:
                                    VDeviceUtils.getScreenWidth(context) / 3.8,
                                child: Text(
                                  AppLocalizations.of(context)!.translate('amount')!,
                                  style: VStyles.bodyMediumSemiBold(context).copyWith(
                                    color: VColors.greyScale700,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width:
                                    VDeviceUtils.getScreenWidth(context) / 2.5,
                                child: Text(
                                  '\$ ${widget.data['totalPrice'] == 0 ? widget.data['pricePerHour'] : widget.data['totalPrice']}',
                                  style: VStyles.bodyLargeBold(context),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),

                          /// Make Space
                          SizedBox(height: 20.h),

                          /// Taxes & Fees
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width:
                                    VDeviceUtils.getScreenWidth(context) / 3.8,
                                child: Text(
                                  AppLocalizations.of(context)!.translate('taxesFees')!,
                                  style: VStyles.bodyMediumSemiBold(context).copyWith(
                                    color: VColors.greyScale700,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width:
                                    VDeviceUtils.getScreenWidth(context) / 2.5,
                                child: Text(
                                  '0 kwd',
                                  style: VStyles.bodyLargeBold(context),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),

                          /// Make Space
                          SizedBox(height: 22.h),

                          Container(height: 1.4.h, color: VColors.greyScale200),

                          /// Make Space
                          SizedBox(height: 20.h),

                          /// Total
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width:
                                    VDeviceUtils.getScreenWidth(context) / 3.8,
                                child: Text(
                                  AppLocalizations.of(context)!.translate('total')!,
                                  style: VStyles.bodyMediumSemiBold(context).copyWith(
                                    color: VColors.greyScale700,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width:
                                    VDeviceUtils.getScreenWidth(context) / 2.5,
                                child: Text(
                                  '\$ ${widget.data['totalPrice'] == 0 || widget.data['totalPrice'] == null ? widget.data['pricePerHour'] : widget.data['totalPrice']}',
                                  style: VStyles.bodyLargeBold(context),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    /// Make Space
                    SizedBox(height: 20.h),

                    /// Payment Method
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 24.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [AppBoxShadows.cardShadowTwo],
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.data['paymentMethod'],
                              style: VStyles.h6Bold(context)),
                          Text(
                            AppLocalizations.of(context)!.translate('payment')!,
                            style: VStyles.bodyLargeSemiBold(context).copyWith(
                              color: VColors.primaryColor500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// Make Space
                    SizedBox(height: 44.h),

                    MainButtonWidget(
                      centerWidgetInButton: state is MakeNewOrderLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              AppLocalizations.of(context)!
                                  .translate('continue')!,
                              style: VStyles.bodyLargeBold(context).copyWith(
                                color: VColors.whiteColor,
                              ),
                            ),
                      onTap: () {
                        if(widget.data['startNow'] == true) {
                          makeOrderCubit.makeNewOrderFunction(
                            typeOfCar: widget.data['typeOfCar'].toString(),
                            garageId: widget.data['garageId'],
                            startNow: widget.data['startNow'] ? true : false,
                            duration: 0 ,
                            totalPrice: 0,
                            status: widget.data['status'],

                            startTime: widget.data['startNow'] == true ? '00:00:00 pm' : widget.data['startTime'],

                            endTime: widget.data['startNow'] == true ? '00:00:00 pm' : widget.data['endTime'],

                            date: widget.data['date'],
                            isPaid: widget.data['isPaid'],
                            paymentMethod:
                            widget.data['paymentMethod'] == '💸 Cash'
                                ? 'cash'
                                : widget.data['paymentMethod'] == '🎫 VISA'
                                ? 'visa'
                                : 'wallet',
                          );
                        } else {
                          makeOrderCubit.makeNewOrderFunction(
                            typeOfCar: widget.data['typeOfCar'].toString(),
                            garageId: widget.data['garageId'],
                            startNow: widget.data['startNow'] ? true : false,
                            duration: widget.data['startNow'] == true ? 0 : widget.data['duration'],
                            totalPrice: widget.data['totalPrice'],
                            status: widget.data['status'],

                            startTime: widget.data['startNow'] == true ? '' : widget.data['startTime'],

                            endTime: widget.data['startNow'] == true ? '' : widget.data['endTime'],

                            date: widget.data['date'],
                            isPaid: widget.data['isPaid'],
                            paymentMethod:
                            widget.data['paymentMethod'] == '💸 Cash'
                                ? 'cash'
                                : widget.data['paymentMethod'] == '🎫 VISA'
                                ? 'visa'
                                : 'wallet',
                          );
                        }

                      },
                      margin: EdgeInsets.zero,
                      buttonColor: VColors.primaryColor500,
                      boxShadow: [AppBoxShadows.buttonShadowOne],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Function to open the location in Google Maps
  void openMap(double latitude, double longitude) {
    final url =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    // Use a package like `url_launcher` to open the map
    launchUrl(Uri.parse(url));
  }
  // Duration calculateDuration(String startTime, String endTime) {
  //   final DateFormat timeFormat = DateFormat.jm();
  //   DateTime start = timeFormat.parse(startTime);
  //   DateTime end = timeFormat.parse(endTime);
  //   return end.difference(start);
  // }
  Duration calculateDuration(int startTime, int endTime) {
    DateTime start = DateTime.fromMillisecondsSinceEpoch(startTime);
    DateTime end = DateTime.fromMillisecondsSinceEpoch(endTime);
    return end.difference(start);
  }

  String formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes % 60;
    return "$hours hours ${minutes > 0 ? '$minutes mins' : ''}";
  }

}
