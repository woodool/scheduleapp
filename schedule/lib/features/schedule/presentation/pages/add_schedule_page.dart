import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddSchedulePage extends StatefulWidget {
  const AddSchedulePage({super.key});

  @override
  State<AddSchedulePage> createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  final _titleController = TextEditingController();
  final _memoController = TextEditingController();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 3));
  String _repeatSetting = '매주 화, 수';
  String _scheduleSetting = '';
  String _category = '';
  double _priority = 0.5;
  bool _showInCalendar = true;

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
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      _buildTitleField(),
                      const SizedBox(height: 32),
                      _buildDateTimeSection(),
                      const SizedBox(height: 32),
                      _buildSettingsSection(),
                      const SizedBox(height: 32),
                      _buildMemoSection(),
                      const SizedBox(height: 24),
                      _buildCalendarToggle(),
                    ],
                  ),
                ),
              ),
            ),
            _buildBottomButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return TextField(
      controller: _titleController,
      decoration: const InputDecoration(
        hintText: '제목',
        hintStyle: TextStyle(
          color: Colors.black26,
          fontSize: 16,
          fontFamily: 'Pretendard',
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
        ),
      ),
      style: const TextStyle(
        fontSize: 16,
        fontFamily: 'Pretendard',
      ),
    );
  }

  Widget _buildDateTimeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '날짜 및 시간',
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '12월 12일 (금)',
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '오후 10시',
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Pretendard',
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(Icons.arrow_forward, size: 20, color: Colors.black45),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '12월 15일 (월)',
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '오후 11시',
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Pretendard',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSettingsSection() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildSettingBox(
                '반복 설정',
                _repeatSetting.isEmpty ? '-' : _repeatSetting,
                onTap: () {
                  // TODO: 반복 설정 다이얼로그
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildSettingBox(
                '일정 설정',
                _scheduleSetting.isEmpty ? '-' : _scheduleSetting,
                onTap: () {
                  // TODO: 일정 설정 다이얼로그
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildSettingBox(
                '카테고리',
                _category.isEmpty ? '-' : _category,
                onTap: () {
                  // TODO: 카테고리 선택 다이얼로그
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '우선 순위',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Pretendard',
                        color: Colors.black45,
                      ),
                    ),
                    SliderTheme(
                      data: SliderThemeData(
                        trackHeight: 4,
                        activeTrackColor: Colors.green,
                        inactiveTrackColor: Colors.black12,
                        thumbColor: Colors.white,
                        overlayColor: Colors.green.withOpacity(0.1),
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 8,
                          elevation: 2,
                        ),
                      ),
                      child: Slider(
                        value: _priority,
                        onChanged: (value) {
                          setState(() {
                            _priority = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSettingBox(String title, String value, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Pretendard',
                color: Colors.black45,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Pretendard',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '메모',
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _memoController,
          decoration: const InputDecoration(
            hintText: '메모 내용',
            hintStyle: TextStyle(
              color: Colors.black26,
              fontSize: 16,
              fontFamily: 'Pretendard',
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
            ),
          ),
          style: const TextStyle(
            fontSize: 16,
            fontFamily: 'Pretendard',
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          '달력 표시',
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
          ),
        ),
        Switch(
          value: _showInCalendar,
          onChanged: (value) {
            setState(() {
              _showInCalendar = value;
            });
          },
          activeColor: Colors.green,
          activeTrackColor: Colors.green.withOpacity(0.3),
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: Colors.black12,
        ),
      ],
    );
  }

  Widget _buildBottomButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text(
                '취소',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // TODO: 일정 저장 로직
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: const Text(
                '등록',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 