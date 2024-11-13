import 'package:valetparking_user/utils/constants/exports.dart';

class CustomHourSlider extends StatefulWidget {
  final double initialValue;
  final ValueChanged<double> onValueChanged;

  const CustomHourSlider({
    Key? key,
    required this.initialValue,
    required this.onValueChanged,
  }) : super(key: key);

  @override
  _CustomHourSliderState createState() => _CustomHourSliderState();
}

class _CustomHourSliderState extends State<CustomHourSlider> {
  late double _currentSliderValue;

  @override
  void initState() {
    super.initState();
    _currentSliderValue = widget.initialValue;
  }

  @override
  void didUpdateWidget(CustomHourSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      setState(() {
        _currentSliderValue = widget.initialValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: VColors.primaryColor500,
            inactiveTrackColor: VColors.greyScale200,
            trackShape: const RoundedRectSliderTrackShape(),
            trackHeight: 6.h,
            thumbShape: RoundSliderThumbShape(
              enabledThumbRadius: 12.r,
              elevation: 4,
              pressedElevation: 8,
            ),
            thumbColor: VColors.primaryColor500,
            overlayColor: VColors.primaryColor500.withAlpha(32),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 28.r),
            tickMarkShape: const RoundSliderTickMarkShape(),
            activeTickMarkColor: VColors.primaryColor500,
            inactiveTickMarkColor: VColors.greyScale200,
            valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
            valueIndicatorColor: VColors.primaryColor500,
            valueIndicatorTextStyle: VStyles.bodySmallBold(context).copyWith(
              color: VColors.whiteColor,
            ),
          ),
          child: Slider(
            value: _currentSliderValue,
            min: 0,
            max: 24,
            divisions: 24,
            label: '${_currentSliderValue.round()} hrs',
            onChanged: (double value) {
              setState(() {
                _currentSliderValue = value;
              });
              widget.onValueChanged(value);
            },
          ),
        ),
      ],
    );
  }
}