import 'package:flutter/material.dart';

class ScheduleTitleField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;

  const ScheduleTitleField({
    Key? key,
    required this.controller,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
        style: const TextStyle(
          fontSize: 16,
          height: 1.4,
          letterSpacing: -0.025,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 16,
            height: 1.4,
            letterSpacing: -0.025,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
} 