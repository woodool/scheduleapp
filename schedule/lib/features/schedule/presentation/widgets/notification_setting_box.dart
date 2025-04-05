import 'package:flutter/material.dart';
import '../../domain/models/notification_type.dart';

class NotificationSettingBox extends StatelessWidget {
  final NotificationType notificationType;
  final int? customMinutes;
  final ValueChanged<NotificationType>? onTypeChanged;
  final ValueChanged<int>? onCustomMinutesChanged;

  const NotificationSettingBox({
    super.key,
    required this.notificationType,
    this.customMinutes,
    this.onTypeChanged,
    this.onCustomMinutesChanged,
  });

  String _getNotificationText() {
    switch (notificationType) {
      case NotificationType.none:
        return '-';
      case NotificationType.tenMinutes:
        return '10분 전';
      case NotificationType.oneHour:
        return '1시간 전';
      case NotificationType.oneDay:
        return '1일 전';
      case NotificationType.custom:
        return customMinutes != null ? '$customMinutes분 전' : '-';
    }
  }

  Future<void> _showNotificationSelector(BuildContext context) async {
    NotificationType tempType = notificationType;
    int? tempMinutes = customMinutes;

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
                            '알림 없음',
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
                            '사용자 지정',
                            tempType,
                            (value) => tempType = value,
                          ),
                          if (tempType == NotificationType.custom)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: '분',
                                        suffixText: '분 전',
                                      ),
                                      onChanged: (value) {
                                        tempMinutes = int.tryParse(value);
                                      },
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
                    onTypeChanged?.call(tempType);
                    if (tempType == NotificationType.custom) {
                      onCustomMinutesChanged?.call(tempMinutes ?? 0);
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
    NotificationType value,
    ValueChanged<NotificationType> onChanged,
  ) {
    return RadioListTile<NotificationType>(
      title: Text(title),
      value: type,
      groupValue: value,
      onChanged: (newValue) {
        setState(() {
          onChanged(newValue!);
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