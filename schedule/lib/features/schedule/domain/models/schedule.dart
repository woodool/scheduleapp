import 'package:flutter/material.dart';

enum NotificationType {
  none,
  tenMinutes,
  oneHour,
  oneDay,
  custom,
}

class Schedule {
  final String id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final bool isAllDay;
  final List<bool> repeatDays;
  final NotificationType notificationType;
  final DateTime? customDateTime;
  final int priority;
  final String category;

  Schedule({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.isAllDay,
    required this.repeatDays,
    required this.notificationType,
    this.customDateTime,
    required this.priority,
    required this.category,
  });
} 