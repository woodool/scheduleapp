import 'package:flutter/material.dart';
import '../../domain/models/schedule.dart';
import 'package:scheduleapp/features/schedule/presentation/pages/add_schedule_page.dart';
import 'package:scheduleapp/features/schedule/presentation/pages/edit_schedule_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        title: const Text('홈'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _schedules.isEmpty
                ? const Center(
                    child: Text('일정이 없습니다.'),
                  )
                : ListView.builder(
                    itemCount: _schedules.length,
                    itemBuilder: (context, index) {
                      final schedule = _schedules[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ListTile(
                          title: Text(
                            schedule.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${schedule.startDate.toString().split('.')[0]} - ${schedule.endDate.toString().split('.')[0]}',
                              ),
                              if (schedule.category.isNotEmpty)
                                Text('카테고리: ${schedule.category}'),
                              if (schedule.priority > 0)
                                Text('우선순위: ${schedule.priority}'),
                            ],
                          ),
                          onTap: () => _editSchedule(schedule),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addSchedule,
        child: const Icon(Icons.add),
      ),
    );
  }
} 