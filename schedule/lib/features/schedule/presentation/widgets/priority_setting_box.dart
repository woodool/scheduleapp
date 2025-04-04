import 'package:flutter/material.dart';
import '../../domain/models/priority.dart';

class PrioritySettingBox extends StatelessWidget {
  final Priority? selectedPriority;

  const PrioritySettingBox({
    super.key,
    this.selectedPriority,
  });

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
          ),
        ),
        const SizedBox(height: 5),
        Container(
          width: 84,
          height: 22,
          decoration: BoxDecoration(
            color: selectedPriority?.color ?? Priority.none.color,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }
} 