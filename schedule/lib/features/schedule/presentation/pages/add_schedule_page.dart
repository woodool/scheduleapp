import 'package:flutter/material.dart';
import '../widgets/title_input.dart';
import '../widgets/date_time_selector.dart';
import '../widgets/repeat_setting_box.dart';
import '../widgets/notification_setting_box.dart';
import '../widgets/category_setting_box.dart';
import '../widgets/priority_setting_box.dart';
import '../widgets/memo_input.dart';
import '../widgets/calendar_display_selector.dart';
import '../widgets/action_buttons.dart';
import '../../domain/models/priority.dart';
import 'package:scheduleapp/features/schedule/domain/entities/schedule.dart';
import 'package:scheduleapp/features/schedule/presentation/widgets/date_setting_box.dart';

class AddSchedulePage extends StatefulWidget {
  const AddSchedulePage({super.key});

  @override
  State<AddSchedulePage> createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(hours: 1));
  List<bool> _selectedDays = List.filled(7, false);
  NotificationType _notificationType = NotificationType.none;
  DateTime? _customDateTime;
  int _priority = 1;
  String _category = '업무';
  CalendarDisplayType _calendarDisplayType = CalendarDisplayType.show; // 기본값은 달력 표시

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _handleCancel() {
    Navigator.of(context).pop();
  }

  void _handleRegister() {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('제목을 입력해주세요')),
      );
      return;
    }

    final schedule = Schedule(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text,
      description: _contentController.text,
      startDate: _startDate,
      endDate: _endDate,
      isAllDay: false,
      repeatDays: _selectedDays,
      notificationType: _notificationType,
      customDateTime: _customDateTime,
      priority: _priority,
      category: _category,
    );

    Navigator.of(context).pop(schedule);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('일정 추가'),
        actions: [
          TextButton(
            onPressed: _handleCancel,
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: _handleRegister,
            child: const Text('등록'),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      TitleInput(
                        controller: _titleController,
                        onChanged: (value) {
                          // TODO: 제목 변경 처리
                        },
                      ),
                      const SizedBox(height: 32),
                      DateSettingBox(
                        startDate: _startDate,
                        endDate: _endDate,
                        onStartDateChanged: (date) {
                          setState(() {
                            _startDate = date;
                          });
                        },
                        onEndDateChanged: (date) {
                          setState(() {
                            _endDate = date;
                          });
                        },
                      ),
                      const SizedBox(height: 32),
                      RepeatSettingBox(
                        selectedDays: _selectedDays,
                        onDaysChanged: (days) {
                          setState(() {
                            _selectedDays = days;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      NotificationSettingBox(
                        notificationType: _notificationType,
                        customDateTime: _customDateTime,
                        onTypeChanged: (type) {
                          setState(() {
                            _notificationType = type;
                          });
                        },
                        onCustomDateTimeChanged: (dateTime) {
                          setState(() {
                            _customDateTime = dateTime;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      PrioritySettingBox(
                        priority: _priority,
                        onPriorityChanged: (priority) {
                          setState(() {
                            _priority = priority;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      CategorySettingBox(
                        category: _category,
                        onCategoryChanged: (category) {
                          setState(() {
                            _category = category;
                          });
                        },
                      ),
                      const SizedBox(height: 32),
                      MemoInput(
                        controller: _contentController,
                        onChanged: (value) {
                          // TODO: 메모 변경 처리
                        },
                      ),
                      const SizedBox(height: 32),
                      CalendarDisplaySelector(
                        selectedType: _calendarDisplayType,
                        onTypeSelected: (type) {
                          setState(() {
                            _calendarDisplayType = type;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ActionButtons(
                onCancelPressed: _handleCancel,
                onSubmitPressed: _handleRegister,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 
