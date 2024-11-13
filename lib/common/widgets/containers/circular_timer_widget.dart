import 'package:valetparking_user/utils/constants/exports.dart';

class CircularTimerWidget extends StatefulWidget {
  const CircularTimerWidget({super.key, required this.endTime, required this.progressColor});

  final int endTime;
  final Color progressColor;

  @override
  _CircularTimerWidgetState createState() => _CircularTimerWidgetState();
}

class _CircularTimerWidgetState extends State<CircularTimerWidget> {
  @override
  Widget build(BuildContext context) {
    // Convert the provided endTime to DateTime and check if it has passed
    DateTime endDateTime = DateTime.fromMillisecondsSinceEpoch(widget.endTime);
    DateTime now = DateTime.now();
    bool hasPassed = endDateTime.isBefore(now);

    return CountdownTimer(
      // If the time has passed, set the endTime to a future 1 second
      endTime: hasPassed ? now.millisecondsSinceEpoch + 1000 : widget.endTime,
      widgetBuilder: (context, time) {
        double percent = 0.0;
        int totalSeconds = hasPassed ? 1 : 3 * 60 * 60; // Set to 1 second when time has passed

        // Safely calculate the remaining seconds, even if some fields are null
        if (time != null) {
          int hours = time.hours ?? 0;
          int minutes = time.min ?? 0;
          int seconds = time.sec ?? 0;

          int remainingSeconds = hours * 3600 + minutes * 60 + seconds;
          percent = hasPassed ? 0.0 : 1 - (remainingSeconds / totalSeconds);
        }

        // Display the countdown and the progress bar
        return CircularPercentIndicator(
          radius: 120.0,
          lineWidth: 12.0,
          percent: percent,
          circularStrokeCap: CircularStrokeCap.round,
          center: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                // Display 00:00:01 if the timer has passed, else show the actual countdown
                "${hasPassed ? '00' : (time?.hours?.toString().padLeft(2, '0') ?? '00')} : "
                    "${hasPassed ? '00' : (time?.min?.toString().padLeft(2, '0') ?? '00')} : "
                    "${hasPassed ? '01' : (time?.sec?.toString().padLeft(2, '0') ?? '00')}",
                style: VStyles.h2Bold(context),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Hours",
                    style: VStyles.bodySmallRegular(context).copyWith(
                      color: VColors.greyScale700,
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Text(
                    "Minutes",
                    style: VStyles.bodySmallRegular(context).copyWith(
                      color: VColors.greyScale700,
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Text(
                    "Seconds",
                    style: VStyles.bodySmallRegular(context).copyWith(
                      color: VColors.greyScale700,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Use the passed progressColor value
          progressColor: widget.progressColor,
          backgroundColor: VColors.greyScale100,
        );
      },
    );
  }
}


// import 'package:valetparking_user/utils/constants/exports.dart';
//
// class CircularTimerWidget extends StatefulWidget {
//   const CircularTimerWidget({super.key, required this.endTime, required this.progressColor});
//
//   final int endTime;
//   final Color progressColor;
//
//   @override
//   _CircularTimerWidgetState createState() => _CircularTimerWidgetState();
// }
//
// class _CircularTimerWidgetState extends State<CircularTimerWidget> {
//   @override
//   Widget build(BuildContext context) {
//     DateTime endDateTime = DateTime.fromMillisecondsSinceEpoch(widget.endTime);
//     DateTime now = DateTime.now();
//     bool hasPassed = endDateTime.isBefore(now);
//
//     return CountdownTimer(
//       endTime: hasPassed ? now.millisecondsSinceEpoch + 1000 : widget.endTime,
//       widgetBuilder: (context, time) {
//         double percent = 0.0;
//         int totalSeconds = hasPassed ? 1 : 3 * 60 * 60; /// 1 second if time is passed, 3 hours otherwise
//
//         /// Safely calculate remaining seconds
//         if (time != null) {
//           int hours = time.hours ?? 0;
//           int minutes = time.min ?? 0;
//           int seconds = time.sec ?? 0;
//
//           int remainingSeconds = hours * 3600 + minutes * 60 + seconds;
//           percent = hasPassed ? 0.0 : 1 - (remainingSeconds / totalSeconds);
//         }
//
//         return CircularPercentIndicator(
//           radius: 120.0,
//           lineWidth: 12.0,
//           percent: percent,
//           circularStrokeCap: CircularStrokeCap.round,
//           center: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 "${hasPassed ? '00' : (time?.hours?.toString().padLeft(2, '0') ?? '00')} : ${hasPassed ? '00' : (time?.min?.toString().padLeft(2, '0') ?? '00')} : ${hasPassed ? '01' : (time?.sec?.toString().padLeft(2, '0') ?? '00')}",
//                 style: VStyles.h2Bold,
//               ),
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     "Hours",
//                     style: VStyles.bodySmallRegular.copyWith(
//                       color: VColors.greyScale700,
//                     ),
//                   ),
//                   SizedBox(width: 20.w),
//                   Text(
//                     "Minutes",
//                     style: VStyles.bodySmallRegular.copyWith(
//                       color: VColors.greyScale700,
//                     ),
//                   ),
//                   SizedBox(width: 20.w),
//                   Text(
//                     "Seconds",
//                     style: VStyles.bodySmallRegular.copyWith(
//                       color: VColors.greyScale700,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           progressColor: widget.progressColor,
//           // progressColor: hasPassed ? VColors.error : VColors.primaryColor500,
//           backgroundColor: VColors.greyScale100,
//         );
//       },
//     );
//   }
// }