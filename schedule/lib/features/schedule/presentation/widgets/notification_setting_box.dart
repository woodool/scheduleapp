import 'package:flutter/material.dart';

enum NotificationType {
  none,
  dayBefore,
  hoursBefore,
  custom,
}

class NotificationSettingBox extends StatelessWidget {
  final NotificationType notificationType;
  final int? customValue;
  final ValueChanged<NotificationType>? onTypeChanged;
  final ValueChanged<int>? onCustomValueChanged;

  const NotificationSettingBox({
    super.key,
    this.notificationType = NotificationType.none,
    this.customValue,
    this.onTypeChanged,
    this.onCustomValueChanged,
  });

  String _getNotificationText() {
    switch (notificationType) {
      case NotificationType.none:
        return '-';
      case NotificationType.dayBefore:
        return '1일 전';
      case NotificationType.hoursBefore:
        return '2시간 전';
      case NotificationType.custom:
        return '${customValue ?? 0}일 전';
    }
  }

  Future<void> _showNotificationSelector(BuildContext context) async {
    NotificationType tempType = notificationType;
    int tempValue = customValue ?? 1;
    
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('알림 설정'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile<NotificationType>(
                    title: const Text('알림 없음'),
                    value: NotificationType.none,
                    groupValue: tempType,
                    onChanged: (value) {
                      setState(() {
                        tempType = value!;
                      });
                    },
                  ),
                  RadioListTile<NotificationType>(
                    title: const Text('1일 전'),
                    value: NotificationType.dayBefore,
                    groupValue: tempType,
                    onChanged: (value) {
                      setState(() {
                        tempType = value!;
                      });
                    },
                  ),
                  RadioListTile<NotificationType>(
                    title: const Text('2시간 전'),
                    value: NotificationType.hoursBefore,
                    groupValue: tempType,
                    onChanged: (value) {
                      setState(() {
                        tempType = value!;
                      });
                    },
                  ),
                  RadioListTile<NotificationType>(
                    title: const Text('사용자 지정'),
                    value: NotificationType.custom,
                    groupValue: tempType,
                    onChanged: (value) {
                      setState(() {
                        tempType = value!;
                      });
                    },
                  ),
                  if (tempType == NotificationType.custom)
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Row(
                        children: [
                          const Text('알림 시간: '),
                          DropdownButton<int>(
                            value: tempValue,
                            items: List.generate(7, (index) => index + 1)
                                .map((days) => DropdownMenuItem<int>(
                                      value: days,
                                      child: Text('$days일 전'),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                tempValue = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                onTypeChanged?.call(tempType);
                if (tempType == NotificationType.custom) {
                  onCustomValueChanged?.call(tempValue);
                }
                Navigator.of(context).pop();
              },
              child: const Text('확인'),
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
          '알림설정',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: () => _showNotificationSelector(context),
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
                _getNotificationText(),
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