import 'package:valetparking_user/features/home/managers/home_cubit.dart';
import 'package:valetparking_user/utils/constants/exports.dart';

class ChoiceDateAndTimeScreen extends StatefulWidget {
  const ChoiceDateAndTimeScreen({super.key, required this.data});

  final Map data;

  @override
  State<ChoiceDateAndTimeScreen> createState() =>
      _ChoiceDateAndTimeScreenState();
}

class _ChoiceDateAndTimeScreenState extends State<ChoiceDateAndTimeScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  TimeOfDay? startHour = TimeOfDay.now();
  TimeOfDay? endHour = TimeOfDay.now();

  bool isChecked = false;
  bool isStartNow = false;

  double sliderValue = 4.0;

  String paymentMethod = '';

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  double getTextWidth(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.size.width / 1.1;
  }

  double calculateHoursDifference(TimeOfDay start, TimeOfDay end) {
    final startMinutes = start.hour * 60 + start.minute;
    final endMinutes = end.hour * 60 + end.minute;

    // Calculate the difference
    double durationInMinutes = (endMinutes - startMinutes).toDouble();

    // If the end time is before the start time, it means the end time is on the next day
    if (durationInMinutes < 0) {
      durationInMinutes += 24 * 60;
    }

    return durationInMinutes / 60; // Convert minutes to hours
  }

  void updateStartAndEndHour(double value) {
    if (startHour != null) {
      final durationInMinutes = (value * 60).toInt();
      final startMinutes = startHour!.hour * 60 + startHour!.minute;
      final newEndMinutes = startMinutes + durationInMinutes;
      final newEndHour = TimeOfDay(
        hour: newEndMinutes ~/ 60,
        minute: newEndMinutes % 60,
      );

      setState(() {
        endHour = newEndHour;
      });
    }
  }

  double get sliderValueFun {
    if (startHour != null && endHour != null) {
      return calculateHoursDifference(startHour!, endHour!);
    }
    return 4.0; // Default value if times are not set
  }

  void updateSliderValue() {
    if (startHour != null && endHour != null) {
      final durationInHours = calculateHoursDifference(startHour!, endHour!);

      setState(() {
        sliderValue =
            durationInHours; // Update the state that affects the slider
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String startNowText = AppLocalizations.of(context)!.translate('startNow')!;
    String choiceTimeText = AppLocalizations.of(context)!.translate('choiceSpecificTime')!;

    double startNowWidth = getTextWidth(startNowText, VStyles.h5Bold(context));
    double choiceTimeWidth = getTextWidth(choiceTimeText, VStyles.h5Bold(context));

    final sliderValue = startHour != null && endHour != null
        ? calculateHoursDifference(startHour!, endHour!)
        : 4.0;

    String formattedDate = VDeviceUtils.formatDateString(
        date: DateTime.now(), dateFormat: 'yyyy-MM-dd', context: context);

    logSuccess(sliderValue.toString());

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
                  AppLocalizations.of(context)!.translate('bookParkingDetails')!,
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
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                left: 24.w, right: 24.w, top: 24.h, bottom: 24.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${AppLocalizations.of(context)!.translate('selectDate')}', style: VStyles.h6Bold(context)),

                /// Make Space
                SizedBox(height: 16.h),

                /// Calender
                Container(
                  decoration: BoxDecoration(
                    color: VColors.blueBg,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: TableCalendar(
                    firstDay: DateTime.now(),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });

                      /// Format the selected date as yyyy-MM-dd
                      formattedDate = VDeviceUtils.formatDateString(
                          date: selectedDay,
                          dateFormat: 'yyyy-MM-dd',
                          context: context);
                      // String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDay);
                      logSuccess(formattedDate);
                    },
                    calendarStyle: CalendarStyle(
                      isTodayHighlighted: false,
                      selectedDecoration: BoxDecoration(
                        color: VColors.primaryColor500,
                        shape: BoxShape.circle,
                      ),
                      selectedTextStyle: VStyles.bodySmallBold(context).copyWith(
                        color: Colors.white,
                      ),
                      disabledTextStyle: VStyles.bodySmallRegular(context).copyWith(
                        color: VColors.greyScale700,
                      ),
                      defaultDecoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      defaultTextStyle: VStyles.bodySmallRegular(context).copyWith(
                        color: VColors.greyScale900,
                      ),
                      weekendTextStyle: VStyles.bodySmallRegular(context).copyWith(
                        color: VColors.greyScale900,
                      ),
                      outsideDaysVisible: false,
                    ),
                    headerStyle: HeaderStyle(
                      titleCentered: true,
                      formatButtonVisible: false,
                      titleTextStyle: VStyles.bodyXLargeBold(context),
                      leftChevronIcon: Icon(
                        Icons.chevron_left,
                        color: VColors.greyScale900,
                      ),
                      rightChevronIcon: Icon(
                        Icons.chevron_right,
                        color: VColors.greyScale900,
                      ),
                    ),
                    calendarFormat: CalendarFormat.month,
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: VStyles.bodyMediumMedium(context),
                      weekendStyle: VStyles.bodyMediumMedium(context),
                    ),
                  ),
                ),

                /// Make Space
                SizedBox(height: 36.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isStartNow = true;
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            startNowText,
                            style: VStyles.h5Bold(context).copyWith(
                              color: isStartNow
                                  ? VColors.primaryColor500
                                  : VColors.greyScale900,
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            // Duration of the animation
                            width: isStartNow ? startNowWidth : 0,
                            // Animate width
                            height: 2.h,
                            // Adjust the height as needed
                            decoration: BoxDecoration(
                              color: isStartNow
                                  ? VColors.primaryColor500
                                  : Colors.transparent, // Animate color
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isStartNow = false;
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            choiceTimeText,
                            style: VStyles.h5Bold(context).copyWith(
                              color: !isStartNow
                                  ? VColors.primaryColor500
                                  : VColors.greyScale900,
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),

                            /// Duration of the animation
                            width: !isStartNow ? choiceTimeWidth : 0,

                            /// Animate width
                            height: 2.h, // Adjust the height as needed
                            decoration: BoxDecoration(
                              color: !isStartNow
                                  ? VColors.primaryColor500
                                  : Colors.transparent,

                              /// Animate color
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                /// Make Space
                SizedBox(height: 26.h),

                /// Adjust spacing as needed
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),

                  /// Adjust the duration as needed
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.0, 0.1),
                          end: const Offset(0.0, 0.0),
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: isStartNow

                  /// Start now
                      ? Column(
                    key: const ValueKey<bool>(true),
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isChecked = !isChecked;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 30.w,
                            vertical: 18.h,
                          ),
                          decoration: BoxDecoration(
                            color: VColors.greyScale50,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text( AppLocalizations.of(context)!.translate('startNow')!,
                                  style: VStyles.h6Bold(context)),
                              AnimatedSwitcher(
                                duration:
                                const Duration(milliseconds: 300),
                                // Duration of the animation
                                transitionBuilder: (Widget child,
                                    Animation<double> animation) {
                                  return ScaleTransition(
                                      scale: animation, child: child);
                                },
                                child: Icon(
                                  isChecked
                                      ? Icons.check_box
                                      : Icons.check_box_outline_blank,
                                  key: ValueKey<bool>(isChecked),
                                  // Unique key for each icon state
                                  color: isChecked
                                      ? VColors.primaryColor500
                                      : VColors.greyScale900,
                                  size: 24.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )

                  /// End now
                      : Column(
                    key: const ValueKey<bool>(false),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text('${AppLocalizations.of(context)!.translate('duration')}', style: VStyles.h6Bold),
                      // SizedBox(height: 12.h),

                      /// Slider
                      // Visibility(
                      //   visible: !isStartNow,
                      //   child: CustomHourSlider(
                      //     initialValue: sliderValue,
                      //     onValueChanged: (value) {
                      //       updateStartAndEndHour(value);
                      //     },
                      //   ),
                      // ),
                      //
                      // SizedBox(height: 24.h),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(   AppLocalizations.of(context)!.translate('startHour')!,
                                  style: VStyles.h6Bold(context)),
                              SizedBox(height: 12.h),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 22.w,
                                  vertical: 18.h,
                                ),
                                decoration: BoxDecoration(
                                  color: VColors.greyScale50,
                                  borderRadius:
                                  BorderRadius.circular(12.r),
                                ),
                                child: TimePickerContainer(
                                  initialTime: startHour!,
                                  onTimeChanged: (value) {
                                    setState(() {
                                      startHour = value;
                                      updateSliderValue();
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Text(
                          '${AppLocalizations.of(context)!.translate('endHour')}',
                                style: VStyles.h6Bold(context).copyWith(
                                    color: Colors.transparent),
                              ),
                              SizedBox(height: 12.h),
                              SvgPicture.asset(VImages.arrowRight),
                            ],
                          ),
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text('${AppLocalizations.of(context)!.translate('endHour')}', style: VStyles.h6Bold(context)),
                              SizedBox(height: 12.h),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 22.w,
                                  vertical: 18.h,
                                ),
                                decoration: BoxDecoration(
                                  color: VColors.greyScale50,
                                  borderRadius:
                                  BorderRadius.circular(12.r),
                                ),
                                child: TimePickerContainer(
                                  initialTime: endHour!,
                                  onTimeChanged: (value) {
                                    setState(() {
                                      endHour = value;
                                      updateSliderValue();
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                /// Make Space
                SizedBox(height: 24.h),

                Text(AppLocalizations.of(context)!.translate('total')!, style: VStyles.h6Bold(context)),

                /// Make Space
                SizedBox(height: 16.h),

                TextRich1Widget(
                  text1: '${widget.data['pricePerHour']} kwd',
                  text2: !isStartNow
                      // ? ' / ${int.parse(widget.data['pricePerHour']) * (endHour!.hour - startHour!.hour)}'
                      // ? ' / ${} hours'
                      ? ' / ${sliderValue.toInt()} ${AppLocalizations.of(context)!.translate('hours')}'
                      : ' / 1 hour',
                  styleOfText1: VStyles.h4Bold(context).copyWith(
                    color: VColors.primaryColor500,
                  ),
                  styleOfText2: VStyles.bodyMediumRegular(context).copyWith(
                    color: VColors.greyScale700,
                  ),
                ),

                /// Make Space
                SizedBox(height: 24.h),

                MainButtonWidget(
                  centerWidgetInButton: Text(
                    AppLocalizations.of(context)!
                        .translate('continue')!,
                    style: VStyles.bodyLargeBold(context).copyWith(
                      color: VColors.whiteColor,
                    ),
                  ),
                  onTap: () {
                    int difference = endHour!.hour - startHour!.hour;
                    var calculateTheTotalAmount =
                        int.parse(widget.data['pricePerHour']) * difference;

                    if (isStartNow) {
                      /// Validate for "Start now"
                      if (isChecked) {
                        logSuccess(widget.data['typeOfCar'].toString());
                        logSuccess(widget.data['garageId'].toString());
                        logSuccess(isStartNow.toString());
                        logSuccess(_selectedDay!.day.toString());

                        /// Proceed to show the bottom sheet
                        VDeviceUtils.showCustomBottomSheet(
                          context: context,
                          widget: Container(
                            width: double.infinity,
                            height:
                            VDeviceUtils.getScreenHeight(context) / 3.6,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      paymentMethod = '💸 Cash';
                                    });
                                    // print(widget.data['typeOfCar'].runtimeType);
                                    // print(widget.data['garageId'].runtimeType);
                                    // print(formattedDate.runtimeType);
                                    // print(widget.data['typeOfCar'].runtimeType);
                                    // print(widget.data['typeOfCar'].runtimeType);
                                    context.pop();
                                    context.pushNamed(
                                        VRoutesName.reviewSummaryRoute,
                                        arguments: {
                                          'paymentMethod': '💸 Cash',
                                          'typeOfCar': widget.data['typeOfCar'],
                                          'garageName': widget.data['garageName'],
                                          'pricePerHour': widget.data['pricePerHour'],
                                          'garageId': widget.data['garageId'],
                                          'startNow': isStartNow,
                                          'duration': 0,
                                          'totalPrice': calculateTheTotalAmount.toDouble(),
                                          'status': 'ongoing',
                                          'startTime': 0,
                                          'endTime': 0,
                                          'date': formattedDate,
                                          'isPaid': false,
                                          'lat': widget.data['lat'],
                                          'lng': widget.data['lng'],
                                        });

                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 14.h),
                                    margin: EdgeInsets.symmetric(
                                      vertical: 14.h,
                                      horizontal: 30.w,
                                    ),
                                    decoration: BoxDecoration(
                                      color: VColors.primaryColor400,
                                      borderRadius:
                                      BorderRadius.circular(16.r),
                                      boxShadow: [
                                        AppBoxShadows.cardShadowTwo
                                      ],
                                    ),
                                    child: Text(
                                      '💸 Cash',
                                      style: VStyles.h5Bold(context).copyWith(
                                        color: VColors.whiteColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      paymentMethod = '🎫 VISA';
                                    });
                                    context.pop();
                                    context.pushNamed(
                                        VRoutesName.reviewSummaryRoute,
                                        arguments: {
                                          'paymentMethod': '🎫 VISA',
                                          'typeOfCar':
                                          widget.data['typeOfCar'],
                                          'pricePerHour':
                                          widget.data['pricePerHour'],
                                          'garageName':
                                          widget.data['garageName'],
                                          'garageId':
                                          widget.data['garageId'],
                                          'startNow': isStartNow,
                                          'duration': 0,
                                          'totalPrice':
                                          calculateTheTotalAmount
                                              .toDouble(),
                                          'status': 'ongoing',
                                          'startTime':
                                          VDeviceUtils.formatTime2(
                                              context, startHour!)
                                              .toString(),
                                          'endTime':
                                          VDeviceUtils.formatTime2(
                                              context, endHour!)
                                              .toString(),
                                          'date': formattedDate,
                                          'isPaid': false,
                                          'lat': widget.data['lat'],
                                          'lng': widget.data['lng'],
                                        });
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 14.h),
                                    margin: EdgeInsets.symmetric(
                                      vertical: 14.h,
                                      horizontal: 30.w,
                                    ),
                                    decoration: BoxDecoration(
                                      // color: VColors.primaryColor400,
                                      gradient: AppGradients
                                          .gradientUltramarineBlue,
                                      borderRadius:
                                      BorderRadius.circular(16.r),
                                      boxShadow: [
                                        AppBoxShadows.cardShadowTwo
                                      ],
                                    ),
                                    child: Text(
                                      '🎫 VISA',
                                      style: VStyles.h5Bold(context).copyWith(
                                        color: VColors.whiteColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      paymentMethod = '💳 Wallet';
                                    });
                                    context.pop();
                                    context.pushNamed(
                                        VRoutesName.reviewSummaryRoute,
                                        arguments: {
                                          'paymentMethod': '💳 Wallet',
                                          'typeOfCar':
                                          widget.data['typeOfCar'],
                                          'garageName':
                                          widget.data['garageName'],
                                          'garageId':
                                          widget.data['garageId'],
                                          'pricePerHour':
                                          widget.data['pricePerHour'],
                                          'startNow': isStartNow,
                                          'duration': 0,
                                          'totalPrice':
                                          calculateTheTotalAmount
                                              .toDouble(),
                                          'status': 'ongoing',
                                          'startTime':
                                          VDeviceUtils.formatTime2(
                                              context, startHour!)
                                              .toString(),
                                          'endTime':
                                          VDeviceUtils.formatTime2(
                                              context, endHour!)
                                              .toString(),
                                          'date': formattedDate,
                                          'isPaid': false,
                                          'lat': widget.data['lat'],
                                          'lng': widget.data['lng'],
                                        });
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 14.h),
                                    margin: EdgeInsets.symmetric(
                                      vertical: 14.h,
                                      horizontal: 30.w,
                                    ),
                                    decoration: BoxDecoration(
                                      color: VColors.greyScale200,
                                      borderRadius:
                                      BorderRadius.circular(16.r),
                                      boxShadow: [
                                        AppBoxShadows.cardShadowTwo
                                      ],
                                    ),
                                    child: Text(
                                      '💳 Wallet',
                                      style: VStyles.h5Bold(context).copyWith(
                                        color: VColors.primaryColor500,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        /// Show error validation for unchecked state
                        FloatingSnackBar.show(
                          context: context,
                          message: 'Please check the box to start now.',
                          textColor: Colors.white,
                          duration: const Duration(milliseconds: 4000),
                          backgroundColor: VColors.error,
                        );
                      }
                    }
                    else {
                      /// Calculate the duration between start and end hours
                      final duration = Duration(
                        hours: endHour!.hour - startHour!.hour,
                        minutes: endHour!.minute - startHour!.minute,
                      );

                      /// Convert the duration to hours, rounding to the nearest hour if needed
                      final durationInHours = duration.inMinutes / 60;

                      /// Validate for "Choose specific time"
                      if (startHour == endHour) {
                        FloatingSnackBar.show(
                          context: context,
                          message:
                          'The start time is not allowed to be equal to end time.',
                          textColor: Colors.white,
                          duration: const Duration(milliseconds: 4000),
                          backgroundColor: VColors.error,
                        );
                      }

                      /// Check if start time is after end time
                      else if (startHour!.hour > endHour!.hour ||
                          (startHour!.hour == endHour!.hour &&
                              startHour!.minute > endHour!.minute)) {
                        FloatingSnackBar.show(
                          context: context,
                          message: 'Start time cannot be after end time.',
                          textColor: Colors.white,
                          duration: const Duration(milliseconds: 4000),
                          backgroundColor: VColors.error,
                        );
                        return;
                      }

                      /// Validate slider value matches the duration
                      else if (durationInHours.toInt() !=
                          sliderValue.toInt()) {
                        FloatingSnackBar.show(
                          context: context,
                          message:
                          'Duration between start and end time must match the selected duration on the slider.',
                          textColor: Colors.white,
                          duration: const Duration(milliseconds: 4000),
                          backgroundColor: VColors.error,
                        );
                        logSuccess(startHour!.hour.toString());
                        logSuccess(endHour!.hour.toString());
                        logSuccess(durationInHours.toString());
                        return;
                      }

                      else {
                        /// Proceed to show the bottom sheet
                        VDeviceUtils.showCustomBottomSheet(
                          context: context,
                          widget: Container(
                            width: double.infinity,
                            height:
                            VDeviceUtils.getScreenHeight(context) / 3.6,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      paymentMethod = '💸 Cash';
                                    });
                                    context.pop();
                                    // makeOrderCubit.makeNewOrderFunction(
                                    //   typeOfCar: widget.data['typeOfCar'],
                                    //   garageId: widget.data['garageId'],
                                    //   startNow: isStartNow,
                                    //   duration: durationInHours,
                                    //   totalPrice: calculateTheTotalAmount
                                    //       .toDouble(),
                                    //   status: 'ongoing',
                                    //   startTime: VDeviceUtils.formatTime2(
                                    //           context, startHour!)
                                    //       .toString(),
                                    //   endTime: VDeviceUtils.formatTime2(
                                    //           context, endHour!)
                                    //       .toString(),
                                    //   date: formattedDate,
                                    //   isPaid: false,
                                    //   paymentMethod: 'cash',
                                    // );
                                    context.pushNamed(
                                      VRoutesName.reviewSummaryRoute,
                                      arguments: {
                                        'paymentMethod': '💸 Cash',
                                        'typeOfCar':
                                        widget.data['typeOfCar'],
                                        'garageName':
                                        widget.data['garageName'],
                                        'garageId': widget.data['garageId'],
                                        'startNow': isStartNow,
                                        'duration': durationInHours,
                                        'totalPrice':
                                        calculateTheTotalAmount
                                            .toDouble(),
                                        'status': 'ongoing',
                                        'startTime':
                                        VDeviceUtils.formatTime2(
                                            context, startHour!)
                                            .toString(),
                                        'endTime': VDeviceUtils.formatTime2(
                                            context, endHour!)
                                            .toString(),
                                        'date': formattedDate,
                                        'isPaid': false,
                                        'lat': widget.data['lat'],
                                        'lng': widget.data['lng'],
                                      },
                                    );
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 14.h),
                                    margin: EdgeInsets.symmetric(
                                      vertical: 14.h,
                                      horizontal: 30.w,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: AppGradients
                                          .gradientUltramarineBlue,
                                      // color: VColors.primaryColor400,
                                      borderRadius:
                                      BorderRadius.circular(16.r),
                                      boxShadow: [
                                        AppBoxShadows.cardShadowTwo
                                      ],
                                    ),
                                    child: Text(
                                      '💸 Cash',
                                      style: VStyles.h5Bold(context).copyWith(
                                        color: VColors.whiteColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      paymentMethod = '🎫 VISA';
                                    });
                                    context.pop();
                                    context.pushNamed(
                                        VRoutesName.reviewSummaryRoute,
                                        arguments: {
                                          'paymentMethod': '🎫 VISA',
                                          'typeOfCar':
                                          widget.data['typeOfCar'],
                                          'garageName':
                                          widget.data['garageName'],
                                          'garageId':
                                          widget.data['garageId'],
                                          'startNow': isStartNow,
                                          'duration': durationInHours,
                                          'totalPrice':
                                          calculateTheTotalAmount
                                              .toDouble(),
                                          'status': 'ongoing',
                                          'startTime':
                                          VDeviceUtils.formatTime2(
                                              context, startHour!)
                                              .toString(),
                                          'endTime':
                                          VDeviceUtils.formatTime2(
                                              context, endHour!)
                                              .toString(),
                                          'date': formattedDate,
                                          'isPaid': false,
                                          'lat': widget.data['lat'],
                                          'lng': widget.data['lng'],
                                        });
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 14.h),
                                    margin: EdgeInsets.symmetric(
                                      vertical: 14.h,
                                      horizontal: 30.w,
                                    ),
                                    decoration: BoxDecoration(
                                      // color: VColors.primaryColor400,
                                      gradient: AppGradients
                                          .gradientUltramarineBlue,
                                      borderRadius:
                                      BorderRadius.circular(16.r),
                                      boxShadow: [
                                        AppBoxShadows.cardShadowTwo
                                      ],
                                    ),
                                    child: Text(
                                      '🎫 VISA',
                                      style: VStyles.h5Bold(context).copyWith(
                                        color: VColors.whiteColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      paymentMethod = '💳 Wallet';
                                    });
                                    context.pop();
                                    // makeOrderCubit.makeNewOrderFunction(
                                    //   typeOfCar: widget.data['typeOfCar'],
                                    //   garageId: widget.data['garageId'],
                                    //   startNow: isStartNow,
                                    //   duration: durationInHours,
                                    //   totalPrice: calculateTheTotalAmount
                                    //       .toDouble(),
                                    //   status: 'ongoing',
                                    //   startTime: VDeviceUtils.formatTime2(
                                    //           context, startHour!)
                                    //       .toString(),
                                    //   endTime: VDeviceUtils.formatTime2(
                                    //           context, endHour!)
                                    //       .toString(),
                                    //   date: formattedDate,
                                    //   isPaid: true,
                                    //   paymentMethod: 'wallet',
                                    // );
                                    context.pushNamed(
                                        VRoutesName.reviewSummaryRoute,
                                        arguments: {
                                          'paymentMethod': '💳 Wallet',
                                          'typeOfCar':
                                          widget.data['typeOfCar'],
                                          'garageName':
                                          widget.data['garageName'],
                                          'garageId':
                                          widget.data['garageId'],
                                          'startNow': isStartNow,
                                          'duration': durationInHours,
                                          'totalPrice':
                                          calculateTheTotalAmount
                                              .toDouble(),
                                          'status': 'ongoing',
                                          'startTime':
                                          VDeviceUtils.formatTime2(
                                              context, startHour!)
                                              .toString(),
                                          'endTime':
                                          VDeviceUtils.formatTime2(
                                              context, endHour!)
                                              .toString(),
                                          'date': formattedDate,
                                          'isPaid': false,
                                          'lat': widget.data['lat'],
                                          'lng': widget.data['lng'],
                                        });
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 14.h),
                                    margin: EdgeInsets.symmetric(
                                      vertical: 14.h,
                                      horizontal: 30.w,
                                    ),
                                    decoration: BoxDecoration(
                                      color: VColors.greyScale200,
                                      borderRadius:
                                      BorderRadius.circular(16.r),
                                      boxShadow: [
                                        AppBoxShadows.cardShadowTwo
                                      ],
                                    ),
                                    child: Text(
                                      '💳 Wallet',
                                      style: VStyles.h5Bold(context).copyWith(
                                        color: VColors.primaryColor500,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    }
                  },
                  margin: EdgeInsets.zero,
                  buttonColor: VColors.primaryColor500,
                  boxShadow: [AppBoxShadows.buttonShadowOne],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
