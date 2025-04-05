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

class EditSchedulePage extends StatefulWidget {
  const EditSchedulePage({super.key});

  @override
  State<EditSchedulePage> createState() => _EditSchedulePageState();
}

class _EditSchedulePageState extends State<EditSchedulePage> {
  final _titleController = TextEditingController();
  final _memoController = TextEditingController();
  DateTime _startDate = DateTime(2023, 12, 12, 22); // 12월 12일 오후 10시
  DateTime _endDate = DateTime(2023, 12, 15, 23);   // 12월 15일 오후 11시
  RepeatType _repeatType = RepeatType.none;
  int? _monthlyDay;
  NotificationType _notificationType = NotificationType.none;
  DateTime? _customDateTime;
  String? _selectedCategory;
  Priority? _selectedPriority;
  CalendarDisplayType _calendarDisplayType = CalendarDisplayType.show; // 기본값은 달력 표시

  @override
  void dispose() {
    _titleController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('일정 수정'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleInput(
                controller: _titleController,
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RepeatSettingBox(
                    repeatType: _repeatType,
                    monthlyDay: _monthlyDay,
                    onTypeChanged: (type) {
                      setState(() {
                        _repeatType = type;
                      });
                    },
                    onMonthlyDayChanged: (day) {
                      setState(() {
                        _monthlyDay = day;
                      });
                    },
                  ),
                  const SizedBox(width: 35),
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
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CategorySettingBox(
                    selectedCategory: _selectedCategory,
                  ),
                  const SizedBox(width: 35),
                  PrioritySettingBox(
                    selectedPriority: _selectedPriority,
                  ),
                ],
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
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: ActionButtons(
          onCancelPressed: () {
            // TODO: 취소 처리
          },
          onSubmitPressed: () {
            // TODO: 수정 처리
          },
          cancelText: '취소',
          submitText: '수정',
        ),
      ),
    );
  }
} 