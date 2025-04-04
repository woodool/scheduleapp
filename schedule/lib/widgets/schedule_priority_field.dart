import 'package:flutter/material.dart';

class SchedulePriorityField extends StatelessWidget {
  final int priority;
  final Function(int) onChanged;

  const SchedulePriorityField({
    Key? key,
    required this.priority,
    required this.onChanged,
  }) : super(key: key);

  static const List<Color> priorityColors = [
    Color(0xFFEC7F7F), // 높음
    Color(0xFFFFF0A3), // 중간
    Color(0xFFB4E07B), // 낮음
    Color(0xFFA5A5A5), // 기본
  ];

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
          '우선 순위',
          style: defaultTextStyle.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 5),
        Container(
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
          child: GestureDetector(
            onTap: () {
              // 현재 우선순위에서 다음 우선순위로 순환
              final nextPriority = (priority + 1) % priorityColors.length;
              onChanged(nextPriority);
            },
            child: Container(
              width: 84,
              height: 24,
              decoration: BoxDecoration(
                color: priorityColors[priority],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
} 