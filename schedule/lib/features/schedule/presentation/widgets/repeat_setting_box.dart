import 'package:flutter/material.dart';

enum RepeatType {
  none,
  daily,
  weekly,
  monthly,
}

class RepeatSettingBox extends StatelessWidget {
  final RepeatType repeatType;
  final int? monthlyDay;
  final ValueChanged<RepeatType>? onTypeChanged;
  final ValueChanged<int>? onMonthlyDayChanged;

  const RepeatSettingBox({
    super.key,
    this.repeatType = RepeatType.none,
    this.monthlyDay,
    this.onTypeChanged,
    this.onMonthlyDayChanged,
  });

  String _getRepeatText() {
    switch (repeatType) {
      case RepeatType.none:
        return '반복 안함';
      case RepeatType.daily:
        return '매일';
      case RepeatType.weekly:
        return '매주';
      case RepeatType.monthly:
        if (monthlyDay != null) {
          return '매월 ${monthlyDay}일';
        }
        return '매월';
    }
  }

  Future<void> _showRepeatSelector(BuildContext context) async {
    RepeatType tempType = repeatType;
    int tempMonthlyDay = monthlyDay ?? 1;
    
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            '반복',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Container(
                width: 250,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RadioListTile<RepeatType>(
                      title: const Text('반복 안함', style: TextStyle(fontSize: 14)),
                      value: RepeatType.none,
                      groupValue: tempType,
                      contentPadding: const EdgeInsets.symmetric(vertical: 4),
                      onChanged: (value) {
                        setState(() {
                          tempType = value!;
                        });
                      },
                    ),
                    RadioListTile<RepeatType>(
                      title: const Text('매일', style: TextStyle(fontSize: 14)),
                      value: RepeatType.daily,
                      groupValue: tempType,
                      contentPadding: const EdgeInsets.symmetric(vertical: 4),
                      onChanged: (value) {
                        setState(() {
                          tempType = value!;
                        });
                      },
                    ),
                    RadioListTile<RepeatType>(
                      title: const Text('매주', style: TextStyle(fontSize: 14)),
                      value: RepeatType.weekly,
                      groupValue: tempType,
                      contentPadding: const EdgeInsets.symmetric(vertical: 4),
                      onChanged: (value) {
                        setState(() {
                          tempType = value!;
                        });
                      },
                    ),
                    RadioListTile<RepeatType>(
                      title: const Text('매월', style: TextStyle(fontSize: 14)),
                      value: RepeatType.monthly,
                      groupValue: tempType,
                      contentPadding: const EdgeInsets.symmetric(vertical: 4),
                      onChanged: (value) {
                        setState(() {
                          tempType = value!;
                        });
                      },
                    ),
                    if (tempType == RepeatType.monthly)
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, top: 12.0, bottom: 8.0),
                        child: Row(
                          children: [
                            const Text('매월 ', style: TextStyle(fontSize: 14)),
                            SizedBox(
                              width: 50,
                              child: TextField(
                                controller: TextEditingController(text: tempMonthlyDay.toString()),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    int day = int.parse(value);
                                    if (day > 0 && day <= 31) {
                                      setState(() {
                                        tempMonthlyDay = day;
                                      });
                                    }
                                  }
                                },
                              ),
                            ),
                            const Text(' 일', style: TextStyle(fontSize: 14)),
                          ],
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
          actionsPadding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                minimumSize: const Size(60, 36),
              ),
              child: const Text('취소', style: TextStyle(fontSize: 14)),
            ),
            ElevatedButton(
              onPressed: () {
                onTypeChanged?.call(tempType);
                if (tempType == RepeatType.monthly) {
                  onMonthlyDayChanged?.call(tempMonthlyDay);
                }
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                minimumSize: const Size(60, 36),
              ),
              child: const Text('확인', style: TextStyle(fontSize: 14)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '반복설정',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: () => _showRepeatSelector(context),
          child: Container(
            width: 140,
            height: 60,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                _getRepeatText(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
} 