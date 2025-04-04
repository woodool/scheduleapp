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

class AddSchedulePage extends StatefulWidget {
  const AddSchedulePage({super.key});

  @override
  State<AddSchedulePage> createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  final _titleController = TextEditingController();
  final _memoController = TextEditingController();
  final _startDate = DateTime(2023, 12, 12, 22); // 12월 12일 오후 10시
  final _endDate = DateTime(2023, 12, 15, 23);   // 12월 15일 오후 11시
  String? _selectedRepeat;
  String? _selectedNotification;
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DateTimeSelector(
                        startDate: _startDate,
                        endDate: _endDate,
                        onStartDateTap: () {
                          // TODO: 시작 날짜/시간 선택
                        },
                        onEndDateTap: () {
                          // TODO: 종료 날짜/시간 선택
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RepeatSettingBox(
                        selectedRepeat: _selectedRepeat,
                      ),
                      const SizedBox(width: 35),
                      NotificationSettingBox(
                        selectedNotification: _selectedNotification,
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
                  const SizedBox(height: 32),
                  ActionButtons(
                    onCancelPressed: () {
                      // TODO: 취소 처리
                    },
                    onSubmitPressed: () {
                      // TODO: 등록 처리
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
} 