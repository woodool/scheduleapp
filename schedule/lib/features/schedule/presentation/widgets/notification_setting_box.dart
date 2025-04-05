import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum NotificationType {
  none,
  dayBefore,
  hoursBefore,
}

class NotificationSettingBox extends StatelessWidget {
  final NotificationType notificationType;
  final int? hoursValue;
  final ValueChanged<NotificationType>? onTypeChanged;
  final ValueChanged<int>? onHoursValueChanged;

  const NotificationSettingBox({
    super.key,
    this.notificationType = NotificationType.none,
    this.hoursValue,
    this.onTypeChanged,
    this.onHoursValueChanged,
  });

  String _getNotificationText() {
    switch (notificationType) {
      case NotificationType.none:
        return '-';
      case NotificationType.dayBefore:
        return '1일 전';
      case NotificationType.hoursBefore:
        return '${hoursValue ?? 2}시간 전';
    }
  }

  Future<void> _showNotificationSelector(BuildContext context) async {
    NotificationType tempType = notificationType;
    int tempHours = hoursValue ?? 2;
    final TextEditingController hoursController = TextEditingController(text: tempHours.toString());
    
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            '알림 설정',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Container(
                width: double.maxFinite,
                child: Column(
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
                      title: const Text('시간 지정'),
                      value: NotificationType.hoursBefore,
                      groupValue: tempType,
                      onChanged: (value) {
                        setState(() {
                          tempType = value!;
                        });
                      },
                    ),
                    if (tempType == NotificationType.hoursBefore)
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Row(
                          children: [
                            const Text('알림 시간: '),
                            SizedBox(
                              width: 80,
                              child: TextField(
                                controller: hoursController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    setState(() {
                                      tempHours = int.parse(value);
                                    });
                                  }
                                },
                              ),
                            ),
                            const Text(' 시간 전'),
                          ],
                        ),
                      ),
                  ],
                ),
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
            ElevatedButton(
              onPressed: () {
                onTypeChanged?.call(tempType);
                if (tempType == NotificationType.hoursBefore) {
                  onHoursValueChanged?.call(tempHours);
                }
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
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