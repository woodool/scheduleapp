import 'package:flutter/material.dart';
import 'priority.dart';
import 'notification_type.dart';
import 'calendar_display_type.dart';

class Schedule {
  final String id;
  final String title;
  final String? memo;
  final DateTime startDate;
  final DateTime endDate;
  final List<bool> repeatDays;
  final NotificationType notificationType;
  final int? customMinutes;
  final String category;
  final Priority? priority;
  final CalendarDisplayType calendarDisplayType;

  Schedule({
    required this.id,
    required this.title,
    this.memo,
    required this.startDate,
    required this.endDate,
    required this.repeatDays,
    required this.notificationType,
    this.customMinutes,
    required this.category,
    this.priority,
    required this.calendarDisplayType,
  });

  Schedule copyWith({
    String? id,
    String? title,
    String? memo,
    DateTime? startDate,
    DateTime? endDate,
    List<bool>? repeatDays,
    NotificationType? notificationType,
    int? customMinutes,
    String? category,
    Priority? priority,
    CalendarDisplayType? calendarDisplayType,
  }) {
    return Schedule(
      id: id ?? this.id,
      title: title ?? this.title,
      memo: memo ?? this.memo,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      repeatDays: repeatDays ?? this.repeatDays,
      notificationType: notificationType ?? this.notificationType,
      customMinutes: customMinutes ?? this.customMinutes,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      calendarDisplayType: calendarDisplayType ?? this.calendarDisplayType,
    );
  }
} 