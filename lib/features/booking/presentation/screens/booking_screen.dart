import 'package:valetparking_user/features/booking/managers/booking_cubit.dart';
import 'package:valetparking_user/utils/constants/exports.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int selectedIndex = 0;

  final List<String> items = ['Ongoing', 'Completed', 'Cancelled'];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingCubit, BookingState>(
      listener: (context, state) {},
      builder: (context, state) {
        var bookingCubit = BookingCubit.get(context);
        var bookingItem = bookingCubit.getAllOrdersModel.orderDetails;

        return RefreshIndicator(
          onRefresh: () {
            return bookingCubit.getAllOrdersFunction(status: 'ongoing');
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                /// Make Space
                SizedBox(height: 24.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    items.length,
                    (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                          selectedIndex == 0
                              ? bookingCubit.getAllOrdersFunction(
                                  status: 'ongoing')
                              : selectedIndex == 1
                                  ? bookingCubit.getAllOrdersFunction(
                                      status: 'completed')
                                  : bookingCubit.getAllOrdersFunction(
                                      status: 'canceled');
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          // Feel free to change the curve for different animations
                          padding: EdgeInsets.symmetric(
                            vertical: 10.h,
                            horizontal: index == 1
                                ? 14.w
                                : index == 2
                                    ? 21.w
                                    : 24.w,
                          ),
                          decoration: BoxDecoration(
                            color: selectedIndex == index
                                ? VColors.primaryColor500
                                : Colors.white,
                            borderRadius: BorderRadius.circular(100.r),
                            border: Border.all(
                              color: VColors.primaryColor500,
                              width: 2.w,
                            ),
                          ),
                          child: Text(
                            items[index],
                            style: VStyles.bodyXLargeBold(context).copyWith(
                              color: selectedIndex == index
                                  ? Colors.white
                                  : VColors.primaryColor500,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                /// Make Space
                SizedBox(height: 24.h),

                selectedIndex == 2

                    /// Cancelled
                    ? Expanded(
                        child: state is GetAllOrdersLoadingState ||
                                bookingItem == []
                            ? Center(
                                child: LoadingWidget(
                                    iconColor: VColors.primaryColor500),
                              )
                            : bookingItem == null
                                ? Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!.translate('haveAnAProblemInGetSavedItems')!,
                                          style: VStyles.h6Bold(context),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  )
                                : bookingItem!.isEmpty
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Lottie.asset(
                                              VImages.orderEmptyLottie),
                                          SizedBox(height: 40.h),
                                          Text(AppLocalizations.of(context)!.translate('emptyCancelOrder')!,
                                              style: VStyles.bodyXLargeBold(context)),
                                        ],
                                      )
                                    : ListView.separated(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (context, index) {
                                          return CancelledWidget(
                                            pLaceImage:
                                                VImages.welBeckNorthImagePlace,
                                            placeName:
                                                bookingItem[index].garage ==
                                                        null
                                                    ? '..'
                                                    : bookingItem[index]
                                                        .garage!
                                                        .garageName
                                                        .toString(),
                                            placeDesc:
                                                bookingItem[index].garage ==
                                                        null
                                                    ? '..'
                                                    : bookingItem[index]
                                                        .garage!
                                                        .garageDescription
                                                        .toString(),
                                            placePrice:
                                                '\$ ${bookingItem[index].garage == null ? '..' : bookingItem[index].garage!.garagePricePerHour}',
                                            numberOfWaiting: bookingItem[index]
                                                .duration
                                                .toString(),
                                            onTap: () {
                                              VDeviceUtils.showCustomBottomSheet(
                                                  context: context,
                                                  widget:
                                                      const CancelParkingWidget());
                                            },
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return SizedBox(height: 20.h);
                                        },
                                        itemCount: bookingItem.length,
                                      ),
                      )

                    /// Completed
                    : selectedIndex == 1
                        ? Expanded(
                            child: state is GetAllOrdersLoadingState ||
                                    bookingItem == []
                                ? Center(
                                    child: LoadingWidget(
                                        iconColor: VColors.primaryColor500),
                                  )
                                : bookingItem == null
                                    ? Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!.translate('haveAnAProblemInGetOrdersItems')!,
                                              style: VStyles.h6Bold(context),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      )
                                    : bookingItem!.isEmpty
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Lottie.asset(
                                                  VImages.orderEmptyLottie),
                                              SizedBox(height: 40.h),
                                              Text(AppLocalizations.of(context)!.translate('emptyCompletedOrder')!,
                                                  style:
                                                      VStyles.bodyXLargeBold(context)),
                                            ],
                                          )
                                        : ListView.separated(
                                            shrinkWrap: true,
                                            padding: EdgeInsets.zero,
                                            itemBuilder: (context, index) {
                                              return CompleteWidget(
                                                pLaceImage: VImages
                                                    .welBeckNorthImagePlace,
                                                placeName:
                                                    bookingItem[index].garage ==
                                                            null
                                                        ? '..'
                                                        : bookingItem[index]
                                                            .garage!
                                                            .garageName
                                                            .toString(),
                                                placeDesc:
                                                    bookingItem[index].garage ==
                                                            null
                                                        ? '..'
                                                        : bookingItem[index]
                                                            .garage!
                                                            .garageDescription
                                                            .toString(),
                                                placePrice:
                                                    '\$ ${bookingItem[index].garage == null ? '..' : bookingItem[index].garage!.garagePricePerHour}',
                                                numberOfWaiting:
                                                    bookingItem[index]
                                                        .duration
                                                        .toString(),
                                                onTap: () {
                                                  context.pushNamed(VRoutesName
                                                      .parkingTicketRoute);
                                                },
                                              );
                                            },
                                            separatorBuilder: (context, index) {
                                              return SizedBox(height: 20.h);
                                            },
                                            itemCount: bookingItem.length,
                                          ),
                          )

                        /// Ongoing
                        : Expanded(
                            child: state is GetAllOrdersLoadingState ||
                                    bookingItem == []
                                ? Center(
                                    child: LoadingWidget(
                                        iconColor: VColors.primaryColor500),
                                  )
                                : bookingItem == null
                                    ? Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!.translate('haveAnAProblemInGetOrdersItems')!,
                                              style: VStyles.h6Bold(context),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      )
                                    : bookingItem!.isEmpty
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Lottie.asset(
                                                  VImages.orderEmptyLottie),
                                              SizedBox(height: 40.h),
                                              Text(AppLocalizations.of(context)!.translate('emptyOnGoingOrder')!,
                                                  style:
                                                      VStyles.bodyXLargeBold(context)),
                                            ],
                                          )
                                        : ListView.separated(
                                            shrinkWrap: true,
                                            padding: EdgeInsets.zero,
                                            itemBuilder: (context, index) {
                                              return OnGoingWidget(
                                                pLaceImage: VImages.welBeckNorthImagePlace,
                                                placeName:
                                                    bookingItem[index].garage == null
                                                        ? '..'
                                                        : bookingItem[index].garage!.garageName.toString(),
                                                // VConstants.placesNames[index],
                                                placeDesc:
                                                    bookingItem[index].garage == null
                                                        ? '..'
                                                        : bookingItem[index].garage!.garageDescription.toString(),
                                                placePrice:
                                                    '\$ ${bookingItem[index].garage == null ? '..' : bookingItem[index].garage!.garagePricePerHour}',
                                                numberOfWaiting:
                                                    bookingItem[index].duration.toString(),
                                                status: bookingItem[index].isPaid ==
                                                        null
                                                    ? ''
                                                    : bookingItem[index].isPaid!
                                                        ? AppLocalizations.of(context)!.translate('paid')!
                                                        : AppLocalizations.of(context)!.translate('notPaid')!,
                                                onViewTimer: () {
                                                  context.pushNamed(
                                                    VRoutesName.parkingTimerRoute,
                                                    arguments: {
                                                      'parkingArea': bookingItem[index].garage!.garageId,
                                                      'lat': bookingItem[index].garage!.lat,
                                                      'lng': bookingItem[index].garage!.lng,
                                                      'typeCar': bookingItem[index].typeOfCar,
                                                      'date': bookingItem[index].date,
                                                      'duration': bookingItem[index].duration,
                                                      'start': bookingItem[index].timeRange!.start,
                                                      'end': bookingItem[index].timeRange!.end,
                                                    },
                                                  );
                                                },
                                                onShowTicket: () {
                                                  context.pushNamed(VRoutesName.viewTicket, arguments: bookingItem[index].orderId);
                                                  // context.pushNamed(
                                                  //   VRoutesName
                                                  //       .parkingTicketRoute,
                                                  //   arguments:
                                                  // );
                                                },
                                                orderNumber: bookingItem[index].orderNumber ?? 0,
                                              );
                                            },
                                            separatorBuilder: (context, index) {
                                              return SizedBox(height: 20.h);
                                            },
                                            itemCount: bookingItem.length,
                                          ),
                          ),
              ],
            ),
          ),
        );
      },
    );
  }
}
