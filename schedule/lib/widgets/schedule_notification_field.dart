import 'package:flutter/material.dart';

class ScheduleNotificationField extends StatelessWidget {
  final bool isOn;
  final VoidCallback onTap;

  const ScheduleNotificationField({
    Key? key,
    required this.isOn,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const defaultTextStyle = TextStyle(
      height: 1.4,
      letterSpacing: -0.025,
      fontFamily: 'Pretendard',
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '알림 설정',
          style: defaultTextStyle.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 140,
            height: 60,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              isOn ? 'ON' : 'OFF',
              style: defaultTextStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
} 