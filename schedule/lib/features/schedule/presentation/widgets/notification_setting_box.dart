import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

enum NotificationType {
  none,
  tenMinutes,
  oneHour,
  oneDay,
  custom,
}

class NotificationSettingBox extends StatelessWidget {
  final NotificationType notificationType;
  final int? customMinutes;
  final ValueChanged<NotificationType>? onTypeChanged;
  final ValueChanged<int>? onCustomMinutesChanged;

  const NotificationSettingBox({
    super.key,
    this.notificationType = NotificationType.none,
    this.customMinutes,
    this.onTypeChanged,
    this.onCustomMinutesChanged,
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
        if (customMinutes != null) {
          return '$customMinutes분 전';
        }
        return '직접 설정';
    }
  }

  Future<void> _showNotificationSelector(BuildContext context) async {
    NotificationType tempType = notificationType;
    int tempMinutes = customMinutes ?? 5;
    
    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: Column(
                mainAxisSize: MainAxisSize.min,
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
                  InkWell(
                    onTap: () async {
                      final result = await _showCustomMinutesSelector(context, tempMinutes);
                      if (result != null) {
                        setState(() {
                          tempType = NotificationType.custom;
                          tempMinutes = result;
                        });
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: Row(
                        children: [
                          Icon(
                            Icons.add_circle_outline,
                            size: 24,
                            color: Colors.blue,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            '직접 설정',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
                      onCustomMinutesChanged?.call(tempMinutes);
                    }
                    Navigator.of(context).pop();
                  },
                  child: const Text('확인'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<int?> _showCustomMinutesSelector(BuildContext context, int initialMinutes) async {
    int selectedMinutes = initialMinutes;
    
    return showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Container(
            height: 200,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: Text(
                    '${selectedMinutes}분',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: CupertinoPicker(
                    itemExtent: 40,
                    onSelectedItemChanged: (int index) {
                      selectedMinutes = index + 1;
                    },
                    children: List<Widget>.generate(60, (index) {
                      return Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(fontSize: 20),
                        ),
                      );
                    }),
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
              onPressed: () => Navigator.of(context).pop(selectedMinutes),
              child: Text('확인'),
            ),
          ],
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
    Function(NotificationType) onChanged,
  ) {
    return RadioListTile<NotificationType>(
      title: Text(
        title,
        style: TextStyle(fontSize: 16),
      ),
      value: type,
      groupValue: selectedType,
      onChanged: (value) {
        setState(() {
          onChanged(value!);
        });
      },
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
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