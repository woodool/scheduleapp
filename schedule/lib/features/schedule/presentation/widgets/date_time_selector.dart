import 'package:flutter/material.dart';

class DateTimeSelector extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;
  final VoidCallback? onStartDateTap;
  final VoidCallback? onEndDateTap;

  const DateTimeSelector({
    super.key,
    required this.startDate,
    required this.endDate,
    this.onStartDateTap,
    this.onEndDateTap,
  });

  String _getWeekday(DateTime date) {
    const weekdays = ['월', '화', '수', '목', '금', '토', '일'];
    return weekdays[date.weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '날짜 및 시간',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1.4,
            letterSpacing: -0.025,
            color: Colors.black,
            fontFamily: 'Pretendard',
          ),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            GestureDetector(
              onTap: onStartDateTap,
              child: Container(
                width: 150,
                height: 104,
                padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 98,
                      height: 22,
                      child: Text(
                        '${startDate.month}월 ${startDate.day}일 (${_getWeekday(startDate)})',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                          letterSpacing: -0.025,
                          color: Colors.black,
                          fontFamily: 'Pretendard',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 98,
                      height: 22,
                      child: Text(
                        '오후 ${startDate.hour > 12 ? startDate.hour - 12 : startDate.hour}시',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.4,
                          letterSpacing: -0.025,
                          color: Colors.black,
                          fontFamily: 'Pretendard',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Image(
                image: AssetImage('assets/images/arrow-right.png'),
                width: 28,
                height: 28,
                fit: BoxFit.contain,
              ),
            ),
            GestureDetector(
              onTap: onEndDateTap,
              child: Container(
                width: 150,
                height: 104,
                padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 98,
                      height: 22,
                      child: Text(
                        '${endDate.month}월 ${endDate.day}일 (${_getWeekday(endDate)})',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                          letterSpacing: -0.025,
                          color: Colors.black,
                          fontFamily: 'Pretendard',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 98,
                      height: 22,
                      child: Text(
                        '오후 ${endDate.hour > 12 ? endDate.hour - 12 : endDate.hour}시',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.4,
                          letterSpacing: -0.025,
                          color: Colors.black,
                          fontFamily: 'Pretendard',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
} 