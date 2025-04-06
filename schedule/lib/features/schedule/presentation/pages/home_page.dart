import 'package:flutter/material.dart';
import 'add_reminder_page.dart';
import 'add_schedule_page.dart';

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
      backgroundColor: Colors.white,
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
              bottom: 68,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      _toggleMenu();
                      Navigator.pushNamed(context, '/add_reminder');
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          '리마인더 추가',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                            letterSpacing: -0.025,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Image.asset(
                          'assets/images/add_reminder.png',
                          width: 48,
                          height: 48,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      _toggleMenu();
                      Navigator.pushNamed(context, '/add_schedule');
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          '일정 추가',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                            letterSpacing: -0.025,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Image.asset(
                          'assets/images/add_schedule.png',
                          width: 48,
                          height: 48,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF0062FF),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: _toggleMenu,
                customBorder: const CircleBorder(),
                child: Center(
                  child: AnimatedRotation(
                    duration: const Duration(milliseconds: 300),
                    turns: _isMenuOpen ? 0.125 : 0,
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 