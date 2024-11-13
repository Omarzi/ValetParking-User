import 'dart:async';
import 'package:valetparking_user/utils/constants/exports.dart';
import 'package:valetparking_user/utils/language/app_localizations.dart';

class TextRich2Widget extends StatefulWidget {
  final String text1;
  final TextStyle style;

  const TextRich2Widget({
    super.key,
    required this.text1,
    required this.style,
  });

  @override
  _TextRich2WidgetState createState() => _TextRich2WidgetState();
}

class _TextRich2WidgetState extends State<TextRich2Widget> {
  Timer? _timer;
  int _start = 60;
  bool _isCounting = false;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            _isCounting = false;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!_isCounting) {
          setState(() {
            _start = 60;
            _isCounting = true;
          });
          startTimer();
        }
      },
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(text: widget.text1, style: VStyles.bodyXLargeMedium(context)),
            TextSpan(
              text: _isCounting ? ' $_start s' : ' ${AppLocalizations.of(context)!.translate('message')!}',
              style: widget.style,
            ),
          ],
        ),
      ),
    );
  }
}
