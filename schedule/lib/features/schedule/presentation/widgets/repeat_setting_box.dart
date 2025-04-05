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
      return '반복 안함';
    }

    const weekdays = ['월', '화', '수', '목', '금', '토', '일'];
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
        return AlertDialog(
          title: const Text(
            '반복',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Container(
                width: 250,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RadioListTile<int>(
                      title: const Text('반복 안함', style: TextStyle(fontSize: 14)),
                      value: 0,
                      groupValue: tempSelectedDays.every((day) => !day) ? 0 : 1,
                      contentPadding: const EdgeInsets.symmetric(vertical: 4),
                      onChanged: (value) {
                        setState(() {
                          tempSelectedDays = List.filled(7, false);
                        });
                      },
                    ),
                    RadioListTile<int>(
                      title: const Text('매일', style: TextStyle(fontSize: 14)),
                      value: 2,
                      groupValue: tempSelectedDays.every((day) => day) ? 2 : 1,
                      contentPadding: const EdgeInsets.symmetric(vertical: 4),
                      onChanged: (value) {
                        setState(() {
                          tempSelectedDays = List.filled(7, true);
                        });
                      },
                    ),
                    RadioListTile<int>(
                      title: const Text('매주', style: TextStyle(fontSize: 14)),
                      value: 1,
                      groupValue: (!tempSelectedDays.every((day) => !day) && !tempSelectedDays.every((day) => day)) ? 1 : (tempSelectedDays.every((day) => day) ? 2 : 0),
                      contentPadding: const EdgeInsets.symmetric(vertical: 4),
                      onChanged: (value) {
                        setState(() {
                          if (tempSelectedDays.every((day) => !day)) {
                            tempSelectedDays[0] = true; // 월요일 선택
                          }
                        });
                      },
                    ),
                    if ((!tempSelectedDays.every((day) => !day) && !tempSelectedDays.every((day) => day)))
                      Padding(
                        padding: const EdgeInsets.only(left: 32.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                _buildDayCheckbox(context, setState, 0, '월', tempSelectedDays),
                                _buildDayCheckbox(context, setState, 1, '화', tempSelectedDays),
                                _buildDayCheckbox(context, setState, 2, '수', tempSelectedDays),
                              ],
                            ),
                            Row(
                              children: [
                                _buildDayCheckbox(context, setState, 3, '목', tempSelectedDays),
                                _buildDayCheckbox(context, setState, 4, '금', tempSelectedDays),
                                _buildDayCheckbox(context, setState, 5, '토', tempSelectedDays),
                              ],
                            ),
                            Row(
                              children: [
                                _buildDayCheckbox(context, setState, 6, '일', tempSelectedDays),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
          actionsPadding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                minimumSize: const Size(60, 36),
              ),
              child: const Text('취소', style: TextStyle(fontSize: 14)),
            ),
            ElevatedButton(
              onPressed: () {
                onDaysChanged?.call(tempSelectedDays);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                minimumSize: const Size(60, 36),
              ),
              child: const Text('확인', style: TextStyle(fontSize: 14)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDayCheckbox(BuildContext context, StateSetter setState, int index, String day, List<bool> tempSelectedDays) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: InkWell(
        onTap: () {
          setState(() {
            tempSelectedDays[index] = !tempSelectedDays[index];
          });
        },
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: tempSelectedDays[index] ? Colors.blue : Colors.transparent,
            border: Border.all(
              color: tempSelectedDays[index] ? Colors.blue : Colors.grey,
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              day,
              style: TextStyle(
                fontSize: 14,
                color: tempSelectedDays[index] ? Colors.white : Colors.black,
              ),
            ),
          ),
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