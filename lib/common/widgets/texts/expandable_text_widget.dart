import 'package:valetparking_user/utils/constants/exports.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;

  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  _ExpandableTextWidgetState createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  bool isExpanded = false;
  final int maxLines = 7;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          child: ConstrainedBox(
            constraints: isExpanded
                ? const BoxConstraints()
                : BoxConstraints(maxHeight: maxLines * 20.0), // Adjust height as needed
            child: Text(
              widget.text,
              overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
              maxLines: isExpanded ? null : maxLines,
              style: VStyles.bodyMediumRegular(context).copyWith(
                color: VColors.greyScale800,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Text(
            isExpanded ? "Read less" : "Read more...",
            style: VStyles.bodyMediumBold(context).copyWith(
              fontSize: 14.sp,
              color: VColors.primaryColor500,
            ),
          ),
        ),
      ],
    );
  }
}
