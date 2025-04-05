import 'package:flutter/material.dart';
import 'package:scheduleapp/features/schedule/domain/entities/schedule.dart';
import 'package:scheduleapp/features/schedule/presentation/pages/add_schedule_page.dart';
import 'package:scheduleapp/features/schedule/presentation/pages/edit_schedule_page.dart';

class ScheduleListPage extends StatefulWidget {
  const ScheduleListPage({super.key});

  @override
  State<ScheduleListPage> createState() => _ScheduleListPageState();
}

class _ScheduleListPageState extends State<ScheduleListPage> {
  List<Schedule> _schedules = [];

  void _addSchedule() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddSchedulePage()),
    );

    if (result != null && result is Schedule) {
      setState(() {
        _schedules.add(result);
      });
    }
  }

  void _editSchedule(Schedule schedule) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditSchedulePage(schedule: schedule),
      ),
    );

    if (result != null && result is Schedule) {
      setState(() {
        final index = _schedules.indexWhere((s) => s.id == schedule.id);
        if (index != -1) {
          _schedules[index] = result;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('일정 목록'),
      ),
      body: ListView.builder(
        itemCount: _schedules.length,
        itemBuilder: (context, index) {
          final schedule = _schedules[index];
          return ListTile(
            title: Text(schedule.title),
            subtitle: Text(
              '${schedule.startDate.toString().split('.')[0]} - ${schedule.endDate.toString().split('.')[0]}',
            ),
            onTap: () => _editSchedule(schedule),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addSchedule,
        child: const Icon(Icons.add),
      ),
    );
  }
} 