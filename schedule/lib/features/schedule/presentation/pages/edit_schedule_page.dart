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
import '../../domain/models/schedule.dart';

class EditSchedulePage extends StatefulWidget {
  final Schedule schedule;

  const EditSchedulePage({
    super.key,
    required this.schedule,
  });

  @override
  State<EditSchedulePage> createState() => _EditSchedulePageState();
}

class _EditSchedulePageState extends State<EditSchedulePage> {
  late final TextEditingController _titleController;
  late final TextEditingController _memoController;
  late DateTime _startDate;
  late DateTime _endDate;
  late List<bool> _selectedDays;
  late NotificationType _notificationType;
  late DateTime? _customDateTime;
  late int _priority;
  late String _category;
  late CalendarDisplayType _calendarDisplayType;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.schedule.title);
    _memoController = TextEditingController(text: widget.schedule.description);
    _startDate = widget.schedule.startDate;
    _endDate = widget.schedule.endDate;
    _selectedDays = List.from(widget.schedule.repeatDays);
    _notificationType = widget.schedule.notificationType;
    _customDateTime = widget.schedule.customDateTime;
    _priority = widget.schedule.priority;
    _category = widget.schedule.category;
    _calendarDisplayType = CalendarDisplayType.show;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  void _handleCancel() {
    Navigator.of(context).pop();
  }

  void _handleEdit() {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('제목을 입력해주세요')),
      );
      return;
    }

    final schedule = Schedule(
      id: widget.schedule.id,
      title: _titleController.text,
      description: _memoController.text,
      startDate: _startDate,
      endDate: _endDate,
      isAllDay: widget.schedule.isAllDay,
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
        title: const Text('일정 수정'),
        actions: [
          TextButton(
            onPressed: _handleCancel,
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: _handleEdit,
            child: const Text('수정'),
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
                      DateTimeSelector(
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
                        controller: _memoController,
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
                onSubmitPressed: _handleEdit,
                cancelText: '취소',
                submitText: '수정',
              ),
            ),
          ],
        ),
      ),
    );
  }
} 