import 'package:flutter/material.dart';

class ScheduleMemoField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;

  const ScheduleMemoField({
    Key? key,
    required this.controller,
    this.hintText,
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
          '메모',
          style: defaultTextStyle.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          width: 335,
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: Colors.black,
                style: BorderStyle.solid,
              ),
            ),
          ),
          child: TextField(
            controller: controller,
            style: defaultTextStyle.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: defaultTextStyle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }
} 