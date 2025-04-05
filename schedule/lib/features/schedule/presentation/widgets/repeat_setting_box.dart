import 'package:flutter/material.dart';

class RepeatSettingBox extends StatelessWidget {
  final List<bool> selectedDays;
  final ValueChanged<List<bool>>? onDaysChanged;

  const RepeatSettingBox({
    super.key,
    required this.selectedDays,
    this.onDaysChanged,
  });

  static const List<String> weekdays = ['월', '화', '수', '목', '금', '토', '일'];

  String _getSelectedDaysText() {
    if (!selectedDays.contains(true)) return '-';
    
    final selectedWeekdays = <String>[];
    for (int i = 0; i < selectedDays.length; i++) {
      if (selectedDays[i]) {
        selectedWeekdays.add(weekdays[i]);
      }
    }
    
    if (selectedWeekdays.length >= 4) {
      return '매주 ${selectedWeekdays.length}일';
    }
    
    return '매주 ${selectedWeekdays.join(', ')}';
  }

  Future<void> _showDaySelector(BuildContext context) async {
    List<bool> tempSelectedDays = List.from(selectedDays);
    
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
                        '반복 설정',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        _getSelectedDaysText(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: ListView.builder(
                          itemCount: weekdays.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey.shade200,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: CheckboxListTile(
                                title: Text(
                                  '${weekdays[index]}요일',
                                  style: TextStyle(fontSize: 16),
                                ),
                                value: tempSelectedDays[index],
                                onChanged: (bool? value) {
                                  if (value != null) {
                                    setState(() {
                                      tempSelectedDays[index] = value;
                                    });
                                  }
                                },
                                activeColor: Colors.blue,
                                contentPadding: EdgeInsets.symmetric(horizontal: 8),
                              ),
                            );
                          },
                        ),
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
                    onDaysChanged?.call(tempSelectedDays);
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '반복설정',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: () => _showDaySelector(context),
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
                _getSelectedDaysText(),
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