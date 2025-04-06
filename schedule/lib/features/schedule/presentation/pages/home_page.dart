import 'package:flutter/material.dart';
import '../widgets/add_button.dart';
import 'add_reminder_page.dart';
import 'add_schedule_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('일정 관리'),
      ),
      body: const Center(
        child: Text('일정 목록이 여기에 표시됩니다.'),
      ),
      floatingActionButton: AddButton(
        menuItems: [
          MenuItem(
            imagePath: 'assets/images/add_reminder.png',
            label: '리마인더 추가',
            page: const AddReminderPage(),
          ),
          MenuItem(
            imagePath: 'assets/images/add_schedule.png',
            label: '일정 추가',
            page: const AddSchedulePage(),
          ),
        ],
      ),
    );
  }
} 