import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum NotificationType {
  none,
  on,
  custom,
}

class NotificationSettingBox extends StatelessWidget {
  final NotificationType notificationType;
  final DateTime? customDateTime;
  final ValueChanged<NotificationType>? onTypeChanged;
  final ValueChanged<DateTime>? onCustomDateTimeChanged;

  const NotificationSettingBox({
    super.key,
    this.notificationType = NotificationType.none,
    this.customDateTime,
    this.onTypeChanged,
    this.onCustomDateTimeChanged,
  });

  String _getNotificationText() {
    switch (notificationType) {
      case NotificationType.none:
        return 'OFF';
      case NotificationType.on:
        return 'ON';
      case NotificationType.custom:
        if (customDateTime != null) {
          return DateFormat('MM/dd HH:mm').format(customDateTime!);
        }
        return '시간 설정';
    }
  }

  Future<void> _showNotificationSelector(BuildContext context) async {
    NotificationType tempType = notificationType;
    DateTime tempDateTime = customDateTime ?? DateTime.now();
    
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            '알림 설정',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Container(
                width: 250,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RadioListTile<NotificationType>(
                      title: const Text('OFF', style: TextStyle(fontSize: 14)),
                      value: NotificationType.none,
                      groupValue: tempType,
                      contentPadding: EdgeInsets.zero,
                      onChanged: (value) {
                        setState(() {
                          tempType = value!;
                        });
                      },
                    ),
                    RadioListTile<NotificationType>(
                      title: const Text('ON', style: TextStyle(fontSize: 14)),
                      value: NotificationType.on,
                      groupValue: tempType,
                      contentPadding: EdgeInsets.zero,
                      onChanged: (value) {
                        setState(() {
                          tempType = value!;
                        });
                      },
                    ),
                    RadioListTile<NotificationType>(
                      title: const Text('시간 설정', style: TextStyle(fontSize: 14)),
                      value: NotificationType.custom,
                      groupValue: tempType,
                      contentPadding: EdgeInsets.zero,
                      onChanged: (value) {
                        setState(() {
                          tempType = value!;
                        });
                      },
                    ),
                    if (tempType == NotificationType.custom)
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                        child: Row(
                          children: [
                            const Text('알림 시간: ', style: TextStyle(fontSize: 14)),
                            TextButton(
                              onPressed: () async {
                                final DateTime? date = await showDatePicker(
                                  context: context,
                                  initialDate: tempDateTime,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(const Duration(days: 365)),
                                );
                                if (date != null) {
                                  setState(() {
                                    tempDateTime = DateTime(
                                      date.year,
                                      date.month,
                                      date.day,
                                      tempDateTime.hour,
                                      tempDateTime.minute,
                                    );
                                  });
                                }
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                DateFormat('MM/dd').format(tempDateTime),
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                final TimeOfDay? time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay(
                                    hour: tempDateTime.hour,
                                    minute: tempDateTime.minute,
                                  ),
                                );
                                if (time != null) {
                                  setState(() {
                                    tempDateTime = DateTime(
                                      tempDateTime.year,
                                      tempDateTime.month,
                                      tempDateTime.day,
                                      time.hour,
                                      time.minute,
                                    );
                                  });
                                }
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                DateFormat('HH:mm').format(tempDateTime),
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
          actionsPadding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text('취소', style: TextStyle(fontSize: 14)),
            ),
            ElevatedButton(
              onPressed: () {
                onTypeChanged?.call(tempType);
                if (tempType == NotificationType.custom) {
                  onCustomDateTimeChanged?.call(tempDateTime);
                }
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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