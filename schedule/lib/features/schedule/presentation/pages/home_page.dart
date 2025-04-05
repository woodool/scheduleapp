import 'package:flutter/material.dart';
import 'add_schedule_page.dart';
import '../../domain/models/schedule.dart';
import '../../data/repositories/schedule_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scheduleRepository = ScheduleRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('일정 관리'),
      ),
      body: ListView.builder(
        itemCount: _scheduleRepository.getAllSchedules().length,
        itemBuilder: (context, index) {
          final schedule = _scheduleRepository.getAllSchedules()[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(schedule.title),
              subtitle: Text(
                '${schedule.startDate.month}월 ${schedule.startDate.day}일 ${schedule.startDate.hour}시 - '
                '${schedule.endDate.month}월 ${schedule.endDate.day}일 ${schedule.endDate.hour}시',
              ),
              trailing: schedule.priority != null
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: schedule.priority!.color,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        schedule.priority!.name,
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  : null,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddSchedulePage()),
          );
          setState(() {}); // 일정 목록 새로고침
        },
        child: const Icon(Icons.add),
      ),
    );
  }
} 