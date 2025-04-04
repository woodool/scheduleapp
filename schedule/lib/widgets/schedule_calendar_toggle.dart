import 'package:flutter/material.dart';

class ScheduleCalendarToggle extends StatelessWidget {
  final bool isDisplayed;
  final Function(bool) onChanged;

  const ScheduleCalendarToggle({
    Key? key,
    required this.isDisplayed,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const defaultTextStyle = TextStyle(
      height: 1.4,
      letterSpacing: -0.025,
      fontFamily: 'Pretendard',
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );

    return Row(
      children: [
        GestureDetector(
          onTap: () => onChanged(false),
          child: Container(
            width: 160,
            height: 40,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
              color: !isDisplayed ? Colors.white : null,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
            ),
            child: Center(
              child: Text(
                '달력 미표시',
                style: defaultTextStyle.copyWith(
                  color: !isDisplayed ? Colors.black : const Color(0xFF767676),
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => onChanged(true),
          child: Container(
            width: 160,
            height: 40,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
              color: isDisplayed ? Colors.white : null,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Center(
              child: Text(
                '달력 표시',
                style: defaultTextStyle.copyWith(
                  color: isDisplayed ? Colors.black : const Color(0xFF767676),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
} 