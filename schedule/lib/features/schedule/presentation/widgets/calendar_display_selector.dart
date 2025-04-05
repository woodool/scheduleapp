import 'package:flutter/material.dart';
import '../../domain/models/calendar_display_type.dart';

class CalendarDisplaySelector extends StatelessWidget {
  final CalendarDisplayType selectedType;
  final ValueChanged<CalendarDisplayType>? onTypeSelected;

  const CalendarDisplaySelector({
    super.key,
    required this.selectedType,
    this.onTypeSelected,
  });

  String _getDisplayText() {
    switch (selectedType) {
      case CalendarDisplayType.show:
        return '표시';
      case CalendarDisplayType.hide:
        return '숨김';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '달력 표시',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
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
                            '달력 표시 설정',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            _getDisplayText(),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              RadioListTile<CalendarDisplayType>(
                                title: Text('표시'),
                                value: CalendarDisplayType.show,
                                groupValue: selectedType,
                                onChanged: (value) {
                                  onTypeSelected?.call(value!);
                                  Navigator.of(context).pop();
                                },
                              ),
                              RadioListTile<CalendarDisplayType>(
                                title: Text('숨김'),
                                value: CalendarDisplayType.hide,
                                groupValue: selectedType,
                                onChanged: (value) {
                                  onTypeSelected?.call(value!);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: Container(
            width: 335,
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
                _getDisplayText(),
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