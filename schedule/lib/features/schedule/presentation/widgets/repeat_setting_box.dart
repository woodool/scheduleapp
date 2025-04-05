import 'package:flutter/material.dart';

class RepeatSettingBox extends StatelessWidget {
  final List<bool> selectedDays;
  final ValueChanged<List<bool>>? onDaysChanged;

  const RepeatSettingBox({
    super.key,
    this.selectedDays = const [false, false, false, false, false, false, false],
    this.onDaysChanged,
  });

  String _getSelectedDaysText() {
    if (selectedDays.every((day) => !day)) {
      return '-';
    }

    const weekdays = ['월', '화', '수', '목', '금', '토', '일'];
    final selectedWeekdays = <String>[];
    
    for (int i = 0; i < selectedDays.length; i++) {
      if (selectedDays[i]) {
        selectedWeekdays.add(weekdays[i]);
      }
    }
    
    if (selectedWeekdays.length >= 5) {
      return '매주 ${selectedWeekdays.length}일';
    }
    
    return '매주 ${selectedWeekdays.join(', ')}';
  }

  Future<void> _showDaySelector(BuildContext context) async {
    List<bool> tempSelectedDays = List.from(selectedDays);
    
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('반복 요일 선택'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildDayCheckbox(context, setState, 0, '월', tempSelectedDays),
                  _buildDayCheckbox(context, setState, 1, '화', tempSelectedDays),
                  _buildDayCheckbox(context, setState, 2, '수', tempSelectedDays),
                  _buildDayCheckbox(context, setState, 3, '목', tempSelectedDays),
                  _buildDayCheckbox(context, setState, 4, '금', tempSelectedDays),
                  _buildDayCheckbox(context, setState, 5, '토', tempSelectedDays),
                  _buildDayCheckbox(context, setState, 6, '일', tempSelectedDays),
                ],
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
            TextButton(
              onPressed: () {
                onDaysChanged?.call(tempSelectedDays);
                Navigator.of(context).pop();
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDayCheckbox(BuildContext context, StateSetter setState, int index, String day, List<bool> tempSelectedDays) {
    return CheckboxListTile(
      title: Text(day),
      value: tempSelectedDays[index],
      onChanged: (value) {
        setState(() {
          tempSelectedDays[index] = value ?? false;
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
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
} 