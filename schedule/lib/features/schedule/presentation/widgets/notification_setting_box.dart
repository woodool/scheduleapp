import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../domain/models/schedule.dart';

enum NotificationType {
  none,
  tenMinutes,
  oneHour,
  oneDay,
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
        return '일정 시작시간';
      case NotificationType.tenMinutes:
        return '10분 전';
      case NotificationType.oneHour:
        return '1시간 전';
      case NotificationType.oneDay:
        return '1일 전';
      case NotificationType.custom:
        if (customDateTime != null) {
          final now = DateTime.now();
          final difference = customDateTime!.difference(now);
          final days = difference.inDays;
          final hours = difference.inHours % 24;
          final minutes = difference.inMinutes % 60;
          
          if (days > 0) {
            return '$days일 ${hours > 0 ? '$hours시간' : ''} 전';
          } else if (hours > 0) {
            return '$hours시간 ${minutes > 0 ? '$minutes분' : ''} 전';
          } else {
            return '$minutes분 전';
          }
        }
        return '직접 설정';
    }
  }

  Future<void> _showNotificationSelector(BuildContext context) async {
    NotificationType tempType = notificationType;
    DateTime? tempDateTime = customDateTime;
    bool isMinutes = true;
    int selectedValue = 0;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: Container(
                width: 300,
                height: 320,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        '알림 설정',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        _getNotificationText(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          _buildRadioListTile(
                            context,
                            setState,
                            NotificationType.none,
                            '일정 시작시간',
                            tempType,
                            (value) => tempType = value,
                          ),
                          _buildRadioListTile(
                            context,
                            setState,
                            NotificationType.tenMinutes,
                            '10분 전',
                            tempType,
                            (value) => tempType = value,
                          ),
                          _buildRadioListTile(
                            context,
                            setState,
                            NotificationType.oneHour,
                            '1시간 전',
                            tempType,
                            (value) => tempType = value,
                          ),
                          _buildRadioListTile(
                            context,
                            setState,
                            NotificationType.oneDay,
                            '1일 전',
                            tempType,
                            (value) => tempType = value,
                          ),
                          _buildRadioListTile(
                            context,
                            setState,
                            NotificationType.custom,
                            '직접 설정',
                            tempType,
                            (value) => tempType = value,
                          ),
                          if (tempType == NotificationType.custom)
                            Container(
                              height: 100,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CupertinoPicker(
                                      itemExtent: 44,
                                      onSelectedItemChanged: (index) {
                                        setState(() {
                                          bool newIsMinutes = index == 0;
                                          if (newIsMinutes != isMinutes) {
                                            isMinutes = newIsMinutes;
                                            selectedValue = selectedValue.clamp(0, isMinutes ? 59 : 23);
                                          }
                                        });
                                      },
                                      children: [
                                        Text('분'),
                                        Text('시간'),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: CupertinoPicker(
                                      itemExtent: 44,
                                      onSelectedItemChanged: (index) {
                                        setState(() {
                                          selectedValue = index;
                                        });
                                      },
                                      children: List.generate(
                                        isMinutes ? 60 : 24,
                                        (index) => Text('$index'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('취소'),
                ),
                TextButton(
                  onPressed: () {
                    if (tempType == NotificationType.custom) {
                      final now = DateTime.now();
                      if (isMinutes) {
                        tempDateTime = now.add(Duration(minutes: selectedValue));
                      } else {
                        tempDateTime = now.add(Duration(hours: selectedValue));
                      }
                    } else {
                      tempDateTime = null;
                    }
                    onTypeChanged?.call(tempType);
                    if (tempDateTime != null) {
                      onCustomDateTimeChanged?.call(tempDateTime!);
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text('확인'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildRadioListTile(
    BuildContext context,
    StateSetter setState,
    NotificationType type,
    String title,
    NotificationType selectedType,
    ValueChanged<NotificationType> onChanged,
  ) {
    return RadioListTile<NotificationType>(
      title: Text(title),
      value: type,
      groupValue: selectedType,
      onChanged: (value) {
        setState(() {
          onChanged(value!);
        });
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