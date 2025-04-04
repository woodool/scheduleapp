import 'package:flutter/material.dart';
import '../widgets/schedule_title_field.dart';
import '../widgets/schedule_date_field.dart';
import '../widgets/schedule_repeat_field.dart';
import '../widgets/schedule_notification_field.dart';
import '../widgets/schedule_category_field.dart';
import '../widgets/schedule_priority_field.dart';
import '../widgets/schedule_memo_field.dart';
import '../widgets/schedule_calendar_toggle.dart';

class AddScheduleScreen extends StatefulWidget {
  const AddScheduleScreen({Key? key}) : super(key: key);

  @override
  State<AddScheduleScreen> createState() => _AddScheduleScreenState();
}

class _AddScheduleScreenState extends State<AddScheduleScreen> {
  final _titleController = TextEditingController();
  final _memoController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  String _repeatOption = '반복 안함';
  String _selectedCategory = '카테고리 선택';
  int _priority = 1;
  bool _isCalendarDisplayed = false;
  bool _isNotificationOn = false;
  
  // 기본 텍스트 스타일
  static const TextStyle defaultTextStyle = TextStyle(
    height: 1.4,
    letterSpacing: -0.025,
  );
  
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('일정 추가', 
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 1.4,
            letterSpacing: -0.025,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: SafeArea(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.035),
                  ScheduleTitleField(
                    controller: _titleController,
                    hintText: '제목을 입력하세요',
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.022),
                  const Text(
                    '날짜 및 시간',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                      letterSpacing: -0.025,
                      fontFamily: 'Pretendard',
                    ),
                  ),
                  const SizedBox(height: 5),
                  ScheduleDateField(
                    startDate: _startDate,
                    endDate: _endDate,
                    onStartDateChanged: (date) => setState(() => _startDate = date),
                    onEndDateChanged: (date) => setState(() => _endDate = date),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '반복 설정',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 1.4,
                                letterSpacing: -0.025,
                                fontFamily: 'Pretendard',
                              ),
                            ),
                            const SizedBox(height: 5),
                            ScheduleRepeatField(
                              value: _repeatOption,
                              onTap: _showRepeatOptions,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '알림 설정',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 1.4,
                                letterSpacing: -0.025,
                                fontFamily: 'Pretendard',
                              ),
                            ),
                            const SizedBox(height: 5),
                            ScheduleNotificationField(
                              isOn: _isNotificationOn,
                              onTap: () => setState(() => _isNotificationOn = !_isNotificationOn),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '카테고리',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 1.4,
                                letterSpacing: -0.025,
                                fontFamily: 'Pretendard',
                              ),
                            ),
                            const SizedBox(height: 5),
                            ScheduleCategoryField(
                              value: _selectedCategory,
                              onTap: _showCategoryOptions,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '우선순위',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 1.4,
                                letterSpacing: -0.025,
                                fontFamily: 'Pretendard',
                              ),
                            ),
                            const SizedBox(height: 5),
                            SchedulePriorityField(
                              priority: _priority,
                              onChanged: (value) => setState(() => _priority = value),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '메모',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                      letterSpacing: -0.025,
                      fontFamily: 'Pretendard',
                    ),
                  ),
                  const SizedBox(height: 5),
                  ScheduleMemoField(
                    controller: _memoController,
                    hintText: '메모를 입력하세요',
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '달력 표시',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                      letterSpacing: -0.025,
                      fontFamily: 'Pretendard',
                    ),
                  ),
                  const SizedBox(height: 5),
                  ScheduleCalendarToggle(
                    isDisplayed: _isCalendarDisplayed,
                    onChanged: (value) => setState(() => _isCalendarDisplayed = value),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.074),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.close),
            label: '취소',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: '등록',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context);
          } else {
            // TODO: 일정 저장 로직 구현
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  void _showRepeatOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('반복 안함'),
            onTap: () {
              setState(() => _repeatOption = '반복 안함');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('매일'),
            onTap: () {
              setState(() => _repeatOption = '매일');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('매주'),
            onTap: () {
              setState(() => _repeatOption = '매주');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('매월'),
            onTap: () {
              setState(() => _repeatOption = '매월');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _showCategoryOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('업무'),
            onTap: () {
              setState(() => _selectedCategory = '업무');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('개인'),
            onTap: () {
              setState(() => _selectedCategory = '개인');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('가족'),
            onTap: () {
              setState(() => _selectedCategory = '가족');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('기타'),
            onTap: () {
              setState(() => _selectedCategory = '기타');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}