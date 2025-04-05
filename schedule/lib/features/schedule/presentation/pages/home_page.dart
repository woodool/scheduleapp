import 'package:flutter/material.dart';
import 'add_schedule_page.dart';
import 'add_reminder_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isMenuOpen = false;

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

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
      floatingActionButton: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          if (_isMenuOpen)
            Positioned(
              bottom: 80,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildMenuItem(
                    imagePath: 'assets/images/reminder_add.png',
                    label: '리마인더 추가',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AddReminderPage()),
                      );
                      _toggleMenu();
                    },
                  ),
                  const SizedBox(height: 10),
                  _buildMenuItem(
                    imagePath: 'assets/images/schedule_add.png',
                    label: '일정 추가',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AddSchedulePage()),
                      );
                      _toggleMenu();
                    },
                  ),
                ],
              ),
            ),
          FloatingActionButton(
            onPressed: _toggleMenu,
            child: AnimatedRotation(
              duration: const Duration(milliseconds: 300),
              turns: _isMenuOpen ? 0.125 : 0,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required String imagePath,
    required String label,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 106,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 12),
              Image.asset(
                imagePath,
                width: 24,
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
} 