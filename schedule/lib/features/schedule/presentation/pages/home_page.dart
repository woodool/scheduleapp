import 'package:flutter/material.dart';
import 'package:schedule/features/schedule/presentation/pages/add_schedule_page.dart';
import 'package:schedule/features/schedule/presentation/pages/add_reminder_page.dart';
import 'package:schedule/features/schedule/presentation/widgets/add_button.dart';

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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddReminderPage(),
                ),
              );
            },
          ),
          MenuItem(
            imagePath: 'assets/images/add_schedule.png',
            label: '일정 추가',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddSchedulePage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
} 