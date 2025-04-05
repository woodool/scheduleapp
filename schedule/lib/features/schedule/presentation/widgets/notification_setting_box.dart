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
                    _buildNotificationOption(
                      context, 
                      setState, 
                      NotificationType.none, 
                      '알림 없음', 
                      '알림을 받지 않습니다', 
                      Icons.notifications_off,
                      tempType,
                      (value) => tempType = value,
                    ),
                    const SizedBox(height: 8),
                    _buildNotificationOption(
                      context, 
                      setState, 
                      NotificationType.dayBefore, 
                      '1일 전', 
                      '일정 하루 전에 알림을 받습니다', 
                      Icons.calendar_today,
                      tempType,
                      (value) => tempType = value,
                    ),
                    const SizedBox(height: 8),
                    _buildNotificationOption(
                      context, 
                      setState, 
                      NotificationType.hoursBefore, 
                      '2시간 전', 
                      '일정 2시간 전에 알림을 받습니다', 
                      Icons.access_time,
                      tempType,
                      (value) => tempType = value,
                    ),
                    const SizedBox(height: 8),
                    _buildNotificationOption(
                      context, 
                      setState, 
                      NotificationType.custom, 
                      '사용자 지정', 
                      '원하는 시간에 알림을 받습니다', 
                      Icons.settings,
                      tempType,
                      (value) => tempType = value,
                    ),
                    if (tempType == NotificationType.custom)
                      Container(
                        margin: const EdgeInsets.only(top: 16, left: 16),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Text(
                              '알림 시간: ',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            DropdownButton<int>(
                              value: tempValue,
                              underline: Container(),
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
                if (tempType == NotificationType.custom) {
                  onCustomValueChanged?.call(tempValue);
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

  Widget _buildNotificationOption(
    BuildContext context,
    StateSetter setState,
    NotificationType type,
    String title,
    String subtitle,
    IconData icon,
    NotificationType selectedType,
    Function(NotificationType) onChanged,
  ) {
    final isSelected = selectedType == type;
    
    return InkWell(
      onTap: () {
        setState(() {
          onChanged(type);
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.transparent,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.blue : Colors.grey,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.blue : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Colors.blue,
              ),
          ],
        ),
      ),
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