import 'package:valetparking_user/utils/constants/exports.dart';

class TimePickerContainer extends StatefulWidget {
  final TimeOfDay initialTime;
  final ValueChanged<TimeOfDay> onTimeChanged;

  const TimePickerContainer({
    super.key,
    required this.initialTime,
    required this.onTimeChanged,
  });

  @override
  _TimePickerContainerState createState() => _TimePickerContainerState();
}

class _TimePickerContainerState extends State<TimePickerContainer> {
  late TimeOfDay selectedTime;

  @override
  void initState() {
    super.initState();
    selectedTime = widget.initialTime;

    /// Set the initial time from the widget's property
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: VColors.primaryColor500,
            timePickerTheme: TimePickerThemeData(
              backgroundColor: VColors.greyScale50,
              hourMinuteTextColor: VColors.primaryColor500,
              hourMinuteColor: VColors.greyScale50,
              hourMinuteTextStyle: VStyles.bodyLargeBold(context).copyWith(fontSize: 60.sp),
              dayPeriodTextColor: VColors.greyScale900,
              dayPeriodColor: VColors.greyScale200,
              dialHandColor: VColors.primaryColor100,
              dialBackgroundColor: VColors.greyScale50,
              entryModeIconColor: VColors.primaryColor500,
              dialTextColor: VColors.primaryColor500,
            ),
            textTheme: TextTheme(
              bodyLarge: VStyles.bodyLargeBold(context),
            ),
            colorScheme: ColorScheme.light(
              primary: VColors.primaryColor500,
              onSurface: VColors.greyScale900,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
      widget.onTimeChanged(selectedTime); /// Notify parent widget of the change
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectTime(context),
      child: Container(
        decoration: BoxDecoration(
          color: VColors.greyScale50,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedTime.format(context),
              style: VStyles.bodyMediumSemiBold(context),
            ),
            SizedBox(width: 12.w),
            Icon(
              Icons.access_time,
              color: VColors.greyScale900,
              size: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:valetparking_user/utils/constants/exports.dart';
//
// class TimePickerContainer extends StatefulWidget {
//   final TimeOfDay initialTime;
//
//   const TimePickerContainer({
//     super.key,
//     required this.initialTime,
//   });
//
//   @override
//   _TimePickerContainerState createState() => _TimePickerContainerState();
// }
//
// class _TimePickerContainerState extends State<TimePickerContainer> {
//   late TimeOfDay selectedTime;
//
//   @override
//   void initState() {
//     super.initState();
//     selectedTime = widget.initialTime;
//
//     /// Set the initial time from the widget's property
//   }
//
//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: selectedTime,
//       builder: (BuildContext context, Widget? child) {
//         return Theme(
//           data: ThemeData.light().copyWith(
//             primaryColor: VColors.primaryColor500,
//             /// Color of the time picker header (AM/PM selector)
//             timePickerTheme: TimePickerThemeData(
//               backgroundColor: VColors.greyScale50,
//               /// Background color of the dialog
//               hourMinuteTextColor: VColors.primaryColor500,
//               /// Color of the hour/minute text
//               hourMinuteColor: VColors.greyScale50,
//               /// Background color of hour/minute box
//               hourMinuteTextStyle: VStyles.bodyLargeBold.copyWith(fontSize: 60.sp),
//               dayPeriodTextColor: VColors.greyScale900,
//               /// AM/PM text color
//               dayPeriodColor: VColors.greyScale200,
//               /// AM/PM background color
//               dialHandColor: VColors.primaryColor100,
//               /// Color of the dial hand
//               dialBackgroundColor: VColors.greyScale50,
//               /// Background color of the dial
//               entryModeIconColor: VColors.primaryColor500,
//               /// Color of the icon to switch to text input mode
//               dialTextColor:
//               VColors.primaryColor500, /// Color of the numbers on the dial
//             ),
//             textTheme: TextTheme(
//               bodyLarge: VStyles.bodyLargeBold,
//             ),
//             colorScheme: ColorScheme.light(
//               primary: VColors.primaryColor500,
//               /// Affects various parts like selected time in dial mode
//               onSurface: VColors.greyScale900, /// Color for unselected text
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//
//     if (picked != null && picked != selectedTime) {
//       setState(() {
//         selectedTime = picked;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => _selectTime(context),
//       child: Container(
//         decoration: BoxDecoration(
//           color: VColors.greyScale50,
//           borderRadius: BorderRadius.circular(12.0),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               selectedTime.format(context),
//               style: VStyles.bodyMediumSemiBold,
//             ),
//             SizedBox(width: 12.w),
//             Icon(
//               Icons.access_time,
//               color: VColors.greyScale900,
//               size: 20.0,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
