import 'package:uuid/uuid.dart';
import '../../domain/models/schedule.dart';

class ScheduleRepository {
  final List<Schedule> _schedules = [];
  final _uuid = const Uuid();

  List<Schedule> getAllSchedules() {
    return List.from(_schedules);
  }

  void addSchedule(Schedule schedule) {
    _schedules.add(schedule);
  }

  void updateSchedule(Schedule schedule) {
    final index = _schedules.indexWhere((s) => s.id == schedule.id);
    if (index != -1) {
      _schedules[index] = schedule;
    }
  }

  void deleteSchedule(String id) {
    _schedules.removeWhere((schedule) => schedule.id == id);
  }

  String generateId() {
    return _uuid.v4();
  }
} 