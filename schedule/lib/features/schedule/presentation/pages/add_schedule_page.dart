import 'package:flutter/material.dart';
import '../widgets/title_input.dart';
import '../widgets/date_time_selector.dart';

class AddSchedulePage extends StatefulWidget {
  const AddSchedulePage({super.key});

  @override
  State<AddSchedulePage> createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  final _titleController = TextEditingController();
  final _startDate = DateTime(2023, 12, 12, 22); // 12월 12일 오후 10시
  final _endDate = DateTime(2023, 12, 15, 23);   // 12월 15일 오후 11시

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  onStartDateTap: () {
                    // TODO: 시작 날짜/시간 선택
                  },
                  onEndDateTap: () {
                    // TODO: 종료 날짜/시간 선택
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 