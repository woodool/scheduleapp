import 'package:flutter/material.dart';

class PrioritySettingBox extends StatelessWidget {
  final int priority;
  final ValueChanged<int>? onPriorityChanged;

  const PrioritySettingBox({
    super.key,
    this.priority = 1,
    this.onPriorityChanged,
  });

  String _getPriorityText() {
    switch (priority) {
      case 1:
        return '낮음';
      case 2:
        return '보통';
      case 3:
        return '높음';
      default:
        return '-';
    }
  }

  Color _getPriorityColor() {
    switch (priority) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Future<void> _showPrioritySelector(BuildContext context) async {
    int tempPriority = priority;

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
                        '우선순위 설정',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        _getPriorityText(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: _getPriorityColor(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          _buildPriorityOption(
                            context,
                            setState,
                            1,
                            '낮음',
                            Colors.green,
                            tempPriority,
                            (value) => tempPriority = value,
                          ),
                          _buildPriorityOption(
                            context,
                            setState,
                            2,
                            '보통',
                            Colors.orange,
                            tempPriority,
                            (value) => tempPriority = value,
                          ),
                          _buildPriorityOption(
                            context,
                            setState,
                            3,
                            '높음',
                            Colors.red,
                            tempPriority,
                            (value) => tempPriority = value,
                          ),
                        ],
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
                    onPriorityChanged?.call(tempPriority);
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

  Widget _buildPriorityOption(
    BuildContext context,
    StateSetter setState,
    int value,
    String title,
    Color color,
    int selectedValue,
    ValueChanged<int> onChanged,
  ) {
    return RadioListTile<int>(
      title: Text(
        title,
        style: TextStyle(
          color: color,
          fontWeight: selectedValue == value ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      value: value,
      groupValue: selectedValue,
      onChanged: (value) {
        setState(() {
          onChanged(value!);
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
          '우선순위',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: () => _showPrioritySelector(context),
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
                _getPriorityText(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: _getPriorityColor(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
} 